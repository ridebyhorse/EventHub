//
//  SignIn.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/18/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    // MARK: - Property Wrappers
    @State var isSaved: Bool = false
    @State var navigate: Bool = false
    @ObservedObject var Model:  AuthenticationViewModel
    @EnvironmentObject var navigationManager: NavigationManager
    //MARK: - Properties
    var togglePrompt: String = ""
    var body: some View {
        NavigationView {
            VStack {
                //MARK: - Title
                VStack(spacing: 8) {
                    Image(AppTexts.Authentication.titleImage)
                        .resizable()
                        .frame(width: 56, height: 58)
                    Text(AppTexts.Authentication.EventHub)
                        .foregroundColor(.black)
                        .font(.custom(AppTexts.Authentication.sfPro, size: EventHubFont.h2.size))
                }
                .padding(.top, 75)
                .padding(.trailing, 178.5)
                .padding(.leading, 46.5)

                //MARK: - TextFields
                VStack(spacing: 19) {
                    Text(AppTexts.Authentication.signText)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .font(.custom(AppTexts.Authentication.sfPro, size: 24))
                        .padding(.top, 10)
                        .padding(.trailing, 234)
                    
                    CustomTextField(
                        placeholder: AppTexts.Authentication.placeholderEmail,
                        text: $Model.emailText,
                        isSecure: false,
                        imageName: AppTexts.Authentication.envelope,
                        keyboardType: .emailAddress
                    )

                    CustomTextField(
                        placeholder: AppTexts.Authentication.placeholderPassword,
                        text: $Model.passwordText,
                        isSecure: true,
                        imageName: AppTexts.Authentication.lock
                    )
                }
                .padding(.horizontal, 28)

                //MARK: - Toggle
                HStack {
                    Toggle(togglePrompt, isOn: $isSaved)
                        .tint(.primaryBlue)
                        .frame(width: 32.3, height: 19)
                        .scaleEffect(0.7)
                        .padding(.leading, 28)

                    Text(AppTexts.Common.toggleText)
                        .padding(.leading, 20)

                    Spacer()

                    Button(action: {
//                       navigate to reset password
                    }) {
                        Text(AppTexts.Authentication.forgotPass)
                            .foregroundColor(.mainBlack)
                            .font(.custom(EventHubFont.body3.name, size: EventHubFont.body3.size))
                    }
                    .padding(.trailing, 42)
                }
                .padding(.top, 22)
                .padding(.leading, 28)
                
                .font(.custom(EventHubFont.body3.name, size: EventHubFont.body3.size))
                .foregroundColor(.mainBlack)

                //MARK: - Sign In
                DefaultSignInButton(buttonText: AppTexts.Authentication.signButton, arrowRight: AppTexts.Authentication.arrowRight) {
                    Task {
                // Call the async function inside Task
                        let success = try await Model.SignIn()
                    if success {
//                       navigate to contentview
                    } else {
                        Model.showAlert = true
                        }
                    }
            }
                .padding(.top, 30)
                .padding(.horizontal, 28)

                Text(AppTexts.Authentication.choice)
                .foregroundColor(.someGray)
                    .font(.custom(AppTexts.Authentication.sfPro, size: EventHubFont.body3.size))
                    .padding(.vertical, 20)

                //MARK: - Login with Google
                GoogleLoginButton(Model: Model, mainIcon: AppTexts.Authentication.mainIcon, buttonText: AppTexts.Authentication.logGoogle)

                .padding(.horizontal, 50)
                //MARK: - Bottom
                HStack {
                    Text(AppTexts.Common.noAccount)
                        .foregroundColor(.mainBlack)
                        .font(.custom(EventHubFont.body3.name, size: 14))
                    Button(action: {
// navigate to sign up
                    }) {
                        Text(AppTexts.Authentication.signUpText)
                            .foregroundColor(.primaryBlue)
                            .font(.custom(EventHubFont.body3.name, size: 14))
                    }
                }
                .padding(.top, 82)
                .padding(.bottom, 20)
            }
            
            .padding(.vertical, 20)
            .background(Color(.systemBackground))
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $Model.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(Model.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    SignInView(Model:AuthenticationViewModel(favoritesDataController: FavoritesDataController()))
    
}
