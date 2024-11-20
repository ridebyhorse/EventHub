//
//  Untitled.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/19/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import UIKit

//MARK: - Enum for Auth
enum AuthenticationState {
  case unauthenticated
  case authenticating
  case authenticated
}

enum AuthenticationFlow {
  case login
  case signUp
}

enum AuthenticationError: Error {
  case tokenError(message: String)
}

@MainActor
class AuthenticationModel: ObservableObject {
    //MARK: - Common Properties
    @Published var errorMessage: String = ""
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var confirmPass: String = ""
    @Published var user: User?
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var displayName: String = ""
    var emailError: String = "Email or password cannot be empty"
    var passwordError: String = "Passwords do not match"
    var noId: String = "No client ID found in Firebase configuration"
    var controllerError: String = "There is no root view controller!"
    var idMissing: String =  "ID token missing"
    var unknownError: String =  "unknown"
    var withEmail: String = "signed in with email"
    var userPrompt: String = "User"
    init(){
        registerAuthStateHandler()
    }
    
    // MARK: - Handle Whether User Logged or not
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? ""
            }
        }
    }
    
    // MARK: - Validate isEmpty
    func validateFields() -> Bool {
          if emailText.isEmpty || passwordText.isEmpty {
              errorMessage = emailError
              return false
          }
          
          if passwordText != confirmPass {
              errorMessage = passwordError
              return false
          }
          
          return true
      }

     
     // MARK: Google
    func signInWithGoogle() async -> Bool {
        //MARK: -  Method for ensuring ClientId isValid
        guard let clientID = FirebaseApp.app()?.options.clientID else {
          fatalError(noId)
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
  //MARK: -  Async
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = await windowScene.windows.first,
              let rootViewController = await window.rootViewController else {
            print(controllerError)
          return false
        }

          do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

            let user = userAuthentication.user
              guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: idMissing) }
            let accessToken = user.accessToken

            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
//MARK: - Main Action
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print(" \(userPrompt) \(firebaseUser.uid) \(withEmail) \(firebaseUser.email ?? unknownError)")
            return true
          }
          catch {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
            return false
          }
      }
     
     
     //MARK: - Sign In
     func SignIn() async -> Bool {
         guard validateFields() else { return false }
         
         authenticationState = .authenticating
         do{
             try await Auth.auth().signIn(withEmail: emailText, password: passwordText)
             return true
         }
         catch {
              print(error)
              errorMessage = error.localizedDescription
              authenticationState = .unauthenticated
              return false
            }
     }
     
     //MARK: - Sign Up
     func SignUp() async -> Bool {
         guard validateFields() else { return false }
         
         authenticationState = .authenticating
         do{
             try await Auth.auth().createUser(withEmail: emailText, password: passwordText)
             return true
         }
         catch {
             print(error)
             
             errorMessage = error.localizedDescription
             authenticationState = .unauthenticated
             return false
         }
     }
     //MARK: - Sign out
     func signOut() {
        do {
          try Auth.auth().signOut()
        }
        catch {
          print(error)
          errorMessage = error.localizedDescription
        }
      }
     
     // MARK: - Delete
     func deleteAccount() async -> Bool {
       do {
         try await user?.delete()
         return true
       }
       catch {
         errorMessage = error.localizedDescription
         return false
       }
     }
   
}




