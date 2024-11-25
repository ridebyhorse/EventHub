//
//  InfoItem.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct InfoItem: View {
    // MARK: - Properties
    var image: String
    var title: String
    var subTitle: String
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 14) {
            Image(image)
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.custom(EventHubFont.title1))
                    .foregroundColor(.mainBlack)
                    .opacity(0.8)
                
                Text(subTitle)
                    .font(.custom(EventHubFont.subtitle2))
                    .foregroundColor(.textField)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    InfoItem(image: "Date", title: "14 December, 2021", subTitle: "Tuesday, 4:00PM - 9:00PM")
}
