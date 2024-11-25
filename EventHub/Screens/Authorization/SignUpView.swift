//
//  SignUp.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/19/24.
//


import SwiftUI
struct SignUpView: View {
    // MARK: - Property Wrappers
    @ObservedObject var Model:  AuthenticationViewModel
    @State var navigate2: Bool = false
    @EnvironmentObject var navigationManager: NavigationManager
    //MARK: - Properties
    var lock: String = "lock"
    var buttonText: String = "SIGN UP"
    var profileLogo: String = "authProfile"
    var signInText: String  = "Signin"
   
    // MARK: - Body
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Button(action:{
                        navigationManager.currentDestination = .signIn
                    }) {
                        Image(systemName: AppTexts.Common.backButton)
                            .resizable()
                            .frame(width:22,height: 22)
                            .padding(.trailing,102)
                            .foregroundColor(.mainBlack)
                    }
                    Text(AppTexts.Authentication.signUpText)
                            .font(.custom(AppTexts.Authentication.sfPro, size: 24))
                            .foregroundColor(.mainBlack)
                    
                }
                .padding(.top,31)
                .padding(.trailing,147)
            }
            .padding(.bottom,71)
            
            VStack(spacing: 19){
                CustomTextField(
                    placeholder: AppTexts.Authentication.userPrompt,
                    text: $Model.myUser,
                    isSecure: false,
                    imageName: profileLogo,
                    keyboardType: .emailAddress
                )
                
                
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
                    imageName: lock
                )
                
                
                
                CustomTextField(
                    placeholder: AppTexts.Authentication.confirmPassword,
                    text: $Model.confirmPass,
                    isSecure: true,
                    imageName: lock
                )
            }
            Spacer()
            VStack{
                DefaultSignInButton(buttonText: buttonText, arrowRight: AppTexts.Authentication.arrowRight) {
                    Task {
                let success =  try await Model.SignUp()
                    if success {
            Model.saveUsernameToUserDefaults(username: Model.myUser)
                        navigationManager.currentDestination = .main
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
                GoogleLoginButton(Model: Model,mainIcon: AppTexts.Authentication.mainIcon, buttonText: AppTexts.Authentication.logGoogle)
                
                .padding(.horizontal, 50)
            }
            
            HStack {
                Text(AppTexts.Authentication.haveAccount)
                    .foregroundColor(.mainBlack)
                    .font(.custom(EventHubFont.body3.name, size: 14))
                Button(action: {
//                    navigate to sign In
                }) {
                    Text(signInText)
                        .foregroundColor(.primaryBlue)
                        .font(.custom(EventHubFont.body3.name, size: 14))
                }
            }
            .padding(.top, 82)
            .padding(.bottom, 20)
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
    SignUpView(Model: AuthenticationViewModel(favoritesDataController: FavoritesDataController()))
}
