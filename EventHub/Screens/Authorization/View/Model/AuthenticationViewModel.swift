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

enum AuthError: LocalizedError {
    case invalidEmail
    case wrongPassword
    case emailAlreadyInUse
    case userNotFound
    case unknownError(String)

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("The email address is invalid.", comment: "Invalid email error")
        case .wrongPassword:
            return NSLocalizedString("The password is incorrect.", comment: "Wrong password error")
        case .emailAlreadyInUse:
            return NSLocalizedString("An account with this email already exists.", comment: "Email already in use error")
        case .userNotFound:
            return NSLocalizedString("No user found with this email.", comment: "User not found error")
        case .unknownError(let message):
            return NSLocalizedString("An unknown error occurred: \(message)", comment: "Unknown error")
        }
    }
}

@MainActor
class AuthenticationViewModel: ObservableObject {
    //MARK: - Common Properties
    @Published var errorMessage: String = ""
    @Published var myUser: String = ""
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var confirmPass: String = ""
    @Published var user: User?
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var displayName: String = ""
    @Published var showAlert: Bool = false
    @Published var currentUserEmail: String = ""
    @Published var favoritesItem: FavoriteItem
//    @Published var favoritesDataController: FavoritesDataController
    var emailError: String = "Email or password cannot be empty"
    var passwordError: String = "Passwords do not match"
    var noId: String = "No client ID found in Firebase configuration"
    var controllerError: String = "There is no root view controller!"
    var idMissing: String =  "ID token missing"
    var unknownError: String =  "unknown"
    var withEmail: String = "signed in with email"
    var userPrompt: String = "User"
    var errorMessages = [
          "emptyFields": "Email or password cannot be empty.",
          "passwordMismatch": "Passwords do not match.",
          "unknown": "An unknown error occurred."
      ]
    
    init(favoritesItem: FavoriteItem) {
//          self.favoritesDataController = favoritesDataController
        self.favoritesItem = favoritesItem
          registerAuthStateHandler()
      }
    // MARK: - Handle Whether User Logged or not
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    private func registerAuthStateHandler() {
            if authStateHandler == nil {
                authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                    self.user = user
                    self.authenticationState = user == nil ? .unauthenticated : .authenticated
                    self.currentUserEmail = user?.email ?? ""
//                    self.favoritesDataController.currentUserEmail = self.currentUserEmail
                }
            }
        }
    
    // Function to update the About Me section in UserDefaults
    func updateAboutMe(aboutMe: String) {
        let defaults = UserDefaults.standard
        defaults.set(aboutMe, forKey: "aboutMe")
    }

    // Function to retrieve the About Me section from UserDefaults
    func getAboutMe() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "aboutMe")
    }
    
    func saveAboutMe(aboutMe: String) {
           UserDefaults.standard.set(aboutMe, forKey: "aboutMe")
       }

    func autoSignIn() async {
        if let email = UserDefaults.standard.string(forKey: "rememberedEmail") {
            self.emailText = email
            _ = try? await SignIn()
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
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
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
    func SignIn() async throws -> Bool {
         
         authenticationState = .authenticating
         do{
            try await Auth.auth().signIn(withEmail: emailText, password: passwordText)
             return true
         } catch {
             handleAuthError(error)
             return false
         }
     }
     
     //MARK: - Sign Up
     func SignUp() async  throws -> Bool {
         guard validateFields() else { return false }
         
         authenticationState = .authenticating
         do{
             try await Auth.auth().createUser(withEmail: emailText, password: passwordText)
             return true
         } catch {
             handleAuthError(error)
             return false
         }
     }
     //MARK: - Sign out
     func signOut() {
        do {
          try Auth.auth().signOut()
            print(authStateHandler!)
            authenticationState = .unauthenticated
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
    //MARK: - remember user
    
    // MARK: - sendPassword Reset to email
    func resetPassword(email: String) async -> Bool {
      authenticationState = .authenticating
      do {
        try await Auth.auth().sendPasswordReset(withEmail: email)
        print("Password reset email sent to \(email)")
        return true
      } catch {
        print(error.localizedDescription)
        errorMessage = error.localizedDescription
        authenticationState = .unauthenticated
        return false
      }
    }

    
    // MARK: - saving user to userDefaults should be changed with Core data
    func saveUsernameToUserDefaults(username: String) {
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user found")
            return
        }
        
        let uid = user.uid
        let key = "username_\(uid)"
        UserDefaults.standard.set(username, forKey: key)
        print("Username '\(username)' saved for user: \(uid)")
    }
    
    // MARK: - saving isRememberMeOn to userDefaults
    func updateRememberingUser(isRemembered: Bool) {
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user found")
            return
        }
        
        let key = "remember\(user.uid)"
        UserDefaults.standard.set(isRemembered, forKey: key)
        print("Username '\(user.email ?? user.uid)' updated RememberMe state to \(isRemembered)")
    }
    
    // MARK: - function for getting username as It's Full name for proile view
    func getUsernameFromUserDefaults() -> String? {
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user found")
            return nil
        }
        
        let uid = user.uid
        let key = "username_\(uid)"
        return UserDefaults.standard.string(forKey: key)
    }
    func updateUsernameFromUserDefaults(username: String) {
        guard let user = Auth.auth().currentUser else {
            print("No authenticated user found")
            return
        }
        
        let uid = user.uid
        let key = "username_\(uid)"
        UserDefaults.standard.set(username, forKey: key)
    }
    
        //MARK: - Getting Data from Google for User (Fullname .etc)
    func fetchGoogleUserData() -> [String: String?]? {
        guard let user = GIDSignIn.sharedInstance.currentUser else {
            print("No Google user found")
            return nil
        }

        return [
            "fullName": user.profile?.name,
            "givenName": user.profile?.givenName,
            "familyName": user.profile?.familyName,
            "email": user.profile?.email
        ]
    }
    // MARK: - Handle Errors
    func handleAuthError(_ error: Error) {
        if let nsError = error as NSError? {
        errorMessage = nsError.toReadableMessage()
        } else {
        errorMessage = "An unexpected error occurred. Please try again."
        }
        showAlert = true
    }
}
//MARK: - Extension For cathing errors
extension NSError {
    func toReadableMessage() -> String {
        switch self.code {
        case AuthErrorCode.invalidEmail.rawValue:
            return "The email address is invalid."
        case AuthErrorCode.wrongPassword.rawValue:
            return "The password is incorrect."
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return "An account with this email already exists."
        case AuthErrorCode.userNotFound.rawValue:
            return "No user found with this email."
        default:
            return self.localizedDescription
        }
    }
}
