//
//  DefaultLoadImageView.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct DefaultLoadImageView: View {
    // MARK: - Properties
    var scaleEffect: CGFloat = 1
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.defLoad
                .overlay(
                    LinearGradient(
                        colors: [Color.primaryBlue.opacity(0.3), .clear],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .ignoresSafeArea()
            
            ProgressView()
                .tint(.primaryBlue)
                .contrast(10)
                .scaleEffect(scaleEffect)
        }
    }
}

#Preview {
    DefaultLoadImageView()
}
