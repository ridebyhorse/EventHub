//
//  ActionButtonHeader.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct ActionButtonHeader: View {
    // MARK: - Properties
    @Binding var isSelected: Bool
    
    var icon: String
    var iconChange: String
    var action: (() -> Void)?
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            isSelected.toggle()
            action?()
        }) {
            Rectangle()
                .foregroundColor(.clear)
                .background(.white.opacity(0.2))
                .cornerRadius(10)
                .frame(width: 36, height: 36)
                .overlay(
                    Image(isSelected ? iconChange : icon)
                        .frame(width: 16, height: 16)
                )
        }
        .buttonStyle(.plain)
    }
}
