//
//  OrganizationNameItem.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct OrganizationNameItem: View {
    // MARK: - Properties
    var imageURL: String
    var name: String
    var position: String
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 14) {
            PreLoadImageView(url: imageURL, scaleEffect: 0.6)
                .frame(width: 48, height: 48)
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.custom(EventHubFont.body2))
                    .foregroundColor(.mainBlack)
                
                Text(position)
                    .font(.custom(EventHubFont.subtitle2))
                    .foregroundColor(.textField)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    OrganizationNameItem(imageURL: "EDImageMock2", name: "Ashfak Sayem", position: "Organizer")
}

