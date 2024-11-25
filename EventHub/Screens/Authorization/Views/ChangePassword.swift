//
//  ChangePassword.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/19/24.
//


import SwiftUI
struct ChangePassword: View {
    @State var passText: String = ""
    @State var confirmPass: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var showSuccessAlert: Bool = false
       
//    @EnvironmentObject var navigationManager: NavigationManager
    @ObservedObject var Model: AuthenticationViewModel
    var body: some View {
        VStack{
            VStack{
                //MARK: - Title
                HStack{
                    Button(action:{
                       // navigate Back
                    })
                    {
                        Image(systemName: AppTexts.Common.backButton)
                            .resizable()
                            .frame(width:22, height:22)
                            .foregroundColor(.mainBlack)
                            .padding(.trailing,51)
                        
                    }
                    
                    
                    Text(AppTexts.ChangePassword.mainTitle)
                        .frame(width: 181, height: 29)
                        .font(.custom(AppTexts.Authentication.sfPro, size: 24).weight(.medium))
                        .foregroundColor(.mainBlack)
                        .padding(.trailing,97)
                }
               
                .padding(.top,6)
                
                //MARK: - TextFields
                VStack(spacing: 37){
                    CustomTextField(placeholder:AppTexts.ChangePassword.placeholderPassword , text: $Model.passwordText, isSecure: true, imageName: AppTexts.Authentication.lock)
                    
                        .padding(.top,71)
                    
                    CustomTextField(placeholder:AppTexts.Authentication.confirmPassword , text: $Model.confirmPass,isSecure: true, imageName: AppTexts.Authentication.lock)
                        
                    
                    DefaultSignInButton(buttonText: AppTexts.ChangePassword.buttonText, arrowRight: AppTexts.ChangePassword.arrowRight){
                    }
                        
                }
            }
            
            Spacer()
            
        }
    }
}


#Preview {
    ChangePassword(Model: AuthenticationViewModel())
}
