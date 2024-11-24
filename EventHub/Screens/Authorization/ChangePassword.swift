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
    @ObservedObject var Model: AuthenticationModel
    //MARK: - Properties
    let sfPro: String = "SF Pro"
    let backButton: String = "arrow.left"
    let mainTitle: String = "Reset Password"
    let placeholder: String = "Your password"
    let envelope: String = "lock"
    let buttonText: String = "CHANGE\nPASSWORD"
    let arrowRight: String = "arrow.right"
    var body: some View {
        VStack{
            VStack{
                //MARK: - Title
                HStack{
                    Button(action:{
                       // navigate Back
                    })
                    {
                        Image(systemName: backButton)
                            .resizable()
                            .frame(width:22, height:22)
                            .foregroundColor(.mainBlack)
                            .padding(.trailing,51)
                        
                    }
                    
                    
                    Text(mainTitle)
                        .frame(width: 181, height: 29)
                        .font(.custom(sfPro, size: 24).weight(.medium))
                        .foregroundColor(.mainBlack)
                        .padding(.trailing,97)
                }
               
                .padding(.top,6)
                
                //MARK: - TextFields
                VStack(spacing: 37){
                    CustomTextField(placeholder:placeholder , text: $Model.passwordText, isSecure: true, imageName: envelope)
                    
                        .padding(.top,71)
                    
                    CustomTextField(placeholder:placeholder , text: $Model.confirmPass,isSecure: true, imageName: envelope)
                        
                    
        DefaultSignInButton(buttonText: buttonText, arrowRight: arrowRight){
                    }
                        
                }
            }
            
            Spacer()
            
        }
    }
}


#Preview {
    ChangePassword(Model: AuthenticationModel())
}
