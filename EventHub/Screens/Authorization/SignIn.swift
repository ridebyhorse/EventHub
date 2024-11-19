//
//  SignIn.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/18/24.
//


import SwiftUI

struct SignIn: View {
    // MARK: - Property Wrappers
    @State var emailText: String = ""
    @State var passwordText: String = ""
    @State var isSaved: Bool = false
    //MARK: - Properties
    var titleText: String = "EventHub"
    var titleImage: String = "titleLogo"
    var signText: String = "Sign in"
    var placeholder: String = "abc@example.com"
    var envelope: String = "envelope"
    var placeholder2: String = "Your password"
    var lock: String = "lock"
    var toggleText: String = "Remember Me"
    var forgotPass: String = "Forgot Password?"
    var buttonText: String = "SIGN IN"
    var arrowRight: String = "arrow.right"
    var choice: String = "OR"
    var mainIcon = "google"
    var logGoogle: String = "Login with Google"
    var noAccount: String = "Don’t have an account?"
    var signUp: String = "Sign Up"
    var sfPro: String = "SF Pro"

    var body: some View {
        NavigationView {
            VStack {
                //MARK: - Title
                VStack(spacing: 8) {
                    Image(titleImage)
                        .resizable()
                        .frame(width: 56, height: 58)
                    Text(titleText)
                        .foregroundColor(.black)
                        .font(.custom(sfPro, size: EventHubFont.h2.size))
                }
                .padding(.top, 75)
                .padding(.trailing, 178.5)
                .padding(.leading, 46.5)

                //MARK: - TextFields
                VStack(spacing: 19) {
                    Text(signText)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .font(.custom(sfPro, size: 24))
                        .padding(.top, 10)
                        .padding(.trailing, 234)
                    
                    CustomTextField(
                        placeholder: placeholder,
                        text: $emailText,
                        isSecure: false,
                        imageName: envelope,
                        keyboardType: .emailAddress
                    )

                    CustomTextField(
                        placeholder: placeholder2,
                        text: $passwordText,
                        isSecure: true,
                        imageName: lock
                    )
                }
                .padding(.horizontal, 28)

                //MARK: - Toggle
                HStack {
                    Toggle("", isOn: $isSaved)
                        .tint(.primaryBlue)
                        .frame(width: 32.3, height: 19)
                        .scaleEffect(0.7)
                        .padding(.leading, 28)

                    Text(toggleText)
                        .padding(.leading, 20)

                    Spacer()

                    Button(action: {}) {
                        Text(forgotPass)
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
                DefaultSignInButton(buttonText: buttonText, arrowRight: arrowRight) {
                   // action
                }
                .padding(.top, 30)
                .padding(.horizontal, 28)

                Text(choice)
                    .foregroundColor(.midGray)
                    .font(.custom(sfPro, size: EventHubFont.body3.size))
                    .padding(.vertical, 20)

                //MARK: - Login with Google
                GoogleLoginButton(mainIcon: mainIcon, buttonText: logGoogle) {
                    // action
                }
                .padding(.horizontal, 50)

                //MARK: - Bottom
                HStack {
                    Text(noAccount)
                        .foregroundColor(.mainBlack)
                        .font(.custom(EventHubFont.body3.name, size: 14))
                    Button(action: {}) {
                        Text(signUp)
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
        }
    }
}

#Preview {
    SignIn()
}
