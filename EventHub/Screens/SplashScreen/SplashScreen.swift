//
//  SplashScreen.swift
//  EventHub
//
//  Created by Roman Golub on 19.11.2024.
//

import SwiftUI

struct SplashScreen: View {
    // MARK: - Properties
    @State private var isActive = false
    
    // MARK: - Body
    var body: some View {
        
        if isActive {
            OnboardingScreen()
        } else {
            ZStack {
                BackgroundEllipseView()
                
                VStack {
                    Image("SplashLogo")
                        .resizable()
                        .frame(width: 242, height: 58)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
