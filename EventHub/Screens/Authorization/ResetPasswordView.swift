//
//  ResetPassword.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/19/24.
//


import SwiftUI

struct ResetPasswordView: View {
    @State var emailText: String = ""
    @EnvironmentObject var navigationManager: NavigationManager
    @ObservedObject var Model: AuthenticationViewModel
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Button(action:{
navigationManager.currentDestination = .signIn
                    })
                    {
                        Image(systemName: AppTexts.Common.backButton)
                            .resizable()
                            .frame(width:22, height:22)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.mainBlack)
                            .padding(.trailing,51)
                        
                    }
                    Text(AppTexts.ResetPassword.mainTitle)
                        .frame(width: 181, height: 29)
                        .font(.custom(AppTexts.Authentication.sfPro, size: 24))
                        .foregroundColor(.mainBlack)
                        .padding(.trailing,97)
                }
                
                .padding(.top,6)
                
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(AppTexts.ResetPassword.bodyText)
                        .font(.custom(AppTexts.Authentication.sfPro, size: 15))
                        .foregroundColor(.mainBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineSpacing(4)
                    
                    CustomTextField(placeholder: AppTexts.ResetPassword.placeholderEmail, text: $Model.emailText, imageName: AppTexts.ResetPassword.envelope)
                        .padding(.top, 10)
                    
                    DefaultSignInButton(buttonText: AppTexts.ResetPassword.buttonText, arrowRight: AppTexts.ResetPassword.arrowRight){
                        Task{
                            let sucess = await
                            Model.resetPassword(email: Model.emailText)
                            if sucess{
                                navigationManager.currentDestination = .signIn
                                
                            } else {
                                Model.showAlert = true
                            }
                        }
                    }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                }
                .padding(.horizontal, 40)
                .padding(.top, 59)
                
                Spacer()
            }
            .background(Color.white)
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
    ResetPasswordView(Model: AuthenticationViewModel(favoritesDataController: FavoritesDataController()))
}
