//
//  ActionButtonPageView.swift
//  EventHub
//
//  Created by Roman Golub on 19.11.2024.
//

import SwiftUI

struct ActionButtonPageView: View {
    // MARK: - Properties
    var buttonText: String
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(buttonText)
                .font(.custom(EventHubFont.title1))
                .frame(width: 80, height: 40)
                .foregroundColor(.white)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ActionButtonPageView(buttonText: "Next", action: {})
}
