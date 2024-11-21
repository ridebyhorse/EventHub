//
//  ResetPassword.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/19/24.
//


import SwiftUI

struct ResetPassword: View {
    @State var emailText: String = ""
    
    var sfPro: String = "SF Pro"
    var backButton: String = "arrow.left"
    var mainTitle: String = "Reset Password"
    var bodyText: String = "Please enter your email address to\nrequest a password reset"
    var placeholder: String = "abc@example.com"
    var envelope: String = "envelope"
    var buttonText: String = "SEND"
    var arrowRight: String = "arrow.right"
    
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Button(action:{
                        
                    })
                    {
                        Image(systemName: backButton)
                            .resizable()
                            .frame(width:22, height:22)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.mainBlack)
                            .padding(.trailing,51)
                        
                    }
                    Text(mainTitle)
                        .frame(width: 181, height: 29)
                        .font(.custom(sfPro, size: 24))
                        .foregroundColor(.mainBlack)
                        .padding(.trailing,97)
                }
                
                .padding(.top,6)
                
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(bodyText)
                        .font(.custom(sfPro, size: 15))
                        .foregroundColor(.mainBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineSpacing(4)
                    
                    CustomTextField(placeholder: placeholder, text: $emailText, imageName: envelope)
                        .padding(.top, 10)
                    
                    DefaultSignInButton(buttonText: buttonText, arrowRight: arrowRight, action: {})
                        .frame(maxWidth: .infinity)
                        .padding(.top, 20)
                }
                .padding(.horizontal, 40)
                .padding(.top, 59)
                
                Spacer()
            }
            .background(Color.white)
        }
    }
}

    
#Preview {
    ResetPassword()
}
