//
//  SignUp.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/19/24.
//


import SwiftUI
struct SignUp: View {
    // MARK: - Property Wrappers
    @State var userText: String = ""
    @ObservedObject var Model:  AuthenticationModel
    //MARK: - Properties
    var signUpText: String = "Sign Up"
    var sfPro: String = "SF Pro"
    var userPrompt: String = "Full name"
    var envelope: String = "envelope"
    var placeholder: String = "abc@example.com"
    var placeholder2: String = "Your password"
    var placeholder3: String = "Confirm password"
    var lock: String = "lock"
    var buttonText: String = "Sign Up"
    var profileLogo: String = "authProfile"
    var arrowRight: String = "arrow.right"
    var choice: String = "OR"
    var mainIcon = "google"
    var logGoogle: String = "Login with Google"
    var haveAccount: String = "Already have an account?"
    var signInText: String  = "Signin"
    var backButton: String = "arrow.left"
    // MARK: - Body
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Image(systemName: backButton)
                        .resizable()
                        .frame(width:22,height: 22)
                        .padding(.trailing,102)
                    Text(signUpText)
                        .font(.custom(sfPro, size: 24))
                        .foregroundColor(.mainBlack)
                }
                .padding(.top,31)
                .padding(.trailing,147)
            }
            .padding(.bottom,71)
            
            VStack(spacing: 19){
                CustomTextField(
                    placeholder: userPrompt,
                    text: $userText,
                    isSecure: false,
                    imageName: profileLogo,
                    keyboardType: .emailAddress
                )
                
                
                CustomTextField(
                    placeholder: placeholder,
                    text: $Model.emailText,
                    isSecure: false,
                    imageName: envelope,
                    keyboardType: .emailAddress
                )
                
                
                
                CustomTextField(
                    placeholder: placeholder2,
                    text: $Model.passwordText,
                    isSecure: true,
                    imageName: lock
                )
                
                
                
                CustomTextField(
                    placeholder: placeholder3,
                    text: $Model.confirmPass,
                    isSecure: true,
                    imageName: lock
                )
            }
            Spacer()
            
            VStack{
                DefaultSignInButton(buttonText: buttonText, arrowRight: arrowRight) {
                    Task {
                let success = await Model.SignUp()
                    if success {
                    // navigation to next page
                    } else {
                      // alert
                        }
                    }
                }
                .padding(.top, 30)
                .padding(.horizontal, 28)

                Text(choice)
                    .foregroundColor(.someGray)
                    .font(.custom(sfPro, size: EventHubFont.body3.size))
                    .padding(.vertical, 20)
                
                //MARK: - Login with Google
                GoogleLoginButton(Model: Model,mainIcon: mainIcon, buttonText: logGoogle)
                
                .padding(.horizontal, 50)
            }
            
            HStack {
                Text(haveAccount)
                    .foregroundColor(.mainBlack)
                    .font(.custom(EventHubFont.body3.name, size: 14))
                Button(action: {}) {
                    Text(signInText)
                        .foregroundColor(.primaryBlue)
                        .font(.custom(EventHubFont.body3.name, size: 14))
                }
            }
            .padding(.top, 82)
            .padding(.bottom, 20)
        }
        
    }
}


#Preview {
    SignUp(Model: AuthenticationModel())
}
