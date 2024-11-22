//
//  DefaultButtons.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/19/24.
//

import SwiftUI

struct DefaultSignInButton: View {
    var buttonText: String
    var arrowRight: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(buttonText)
                    .foregroundColor(.white)
                    .font(.custom(EventHubFont.body1.name, size: 16))
                    .kerning(1)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.trailing, 50)
                ZStack {
                    Circle()
                        .fill(Color.primaryBlue.opacity(2))
                        .frame(width: 30, height: 30)
                    Image(systemName: arrowRight)
                        .foregroundColor(.white)
                        .frame(width: 13, height: 13)
                        .cornerRadius(30)
                }
            }
            .padding()
            .frame(width: 271, height: 58)
            .background(Color.primaryBlue.opacity(0.8))
            .cornerRadius(12)
        }
    }
}
struct GoogleLoginButton: View {
    @ObservedObject var Model: AuthenticationModel
    var mainIcon: String
    var buttonText: String
//    @EnvironmentObject var navigationManager: NavigationManager
    var body: some View {
        Button(action: {
            Task {
                let success = await Model.signInWithGoogle()
                if success {
//                    navigationManager.currentDestination = .contentView
                    print("success")
                } else {
                    print("Failed to sign in with Google")
                }
            }
        }) {
            HStack(spacing: 20) {
                Image(mainIcon)
                    .resizable()
                    .frame(width: 26, height: 26)
                    .padding(.leading, 38)
                Text(buttonText)
                    .foregroundColor(.black)
                    .font(.custom("SF Pro", size: 16))
                Spacer()
            }
            .frame(width: 273, height: 56)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .google, radius: 15, x: 15, y: 0)
        }
    }
}
