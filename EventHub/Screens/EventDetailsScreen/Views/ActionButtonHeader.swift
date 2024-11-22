//
//  ActionButtonHeader.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct ActionButtonHeader: View {
    // MARK: - Properties
    @State private var isNoteSelected: Bool = false
    
    var icon: String
    var iconChange: String
    var action: (() -> Void)?
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            isNoteSelected.toggle()
            action?()
        }) {
            Rectangle()
                .foregroundColor(.clear)
                .background(.white.opacity(0.2))
                .cornerRadius(10)
                .frame(width: 36, height: 36)
                .overlay(
                    Image(isNoteSelected ? iconChange : icon)
                        .frame(width: 16, height: 16)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ActionButtonHeader(icon: "bookmarkED", iconChange: "bookmarkFillED", action: {})
}
