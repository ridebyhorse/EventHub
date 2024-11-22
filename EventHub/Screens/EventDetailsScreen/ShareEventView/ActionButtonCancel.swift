//
//  ActionButtonCancel.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct ActionButtonCancel: View {
    // MARK: - Properties
    var buttonText: String
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(buttonText)
                .font(.custom(EventHubFont.title2))
                .frame(width: 271, height: 58)
                .kerning(1)
                .background(.lightGreyV2)
                .cornerRadius(15)
                .padding(.horizontal, 20)
                .foregroundColor(.typographyDarkGrey)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ActionButtonCancel(buttonText: "CANCEL", action: {})
}
