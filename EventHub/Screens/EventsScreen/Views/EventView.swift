//
//  EventView.swift
//  EventHub
//
//  Created by Иван Семикин on 19/11/2024.
//

import SwiftUI

struct EventView: View {
    let event: EventModel
    
    var body: some View {
        HStack(spacing: 16) {
            if let firstImageUrl = event.images.first?.image {
                AsyncImage(url: firstImageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: UIScreen.main.bounds.width * 0.2,
                            height: UIScreen.main.bounds.height * 0.1
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(
                            width: UIScreen.main.bounds.width * 0.2,
                            height: UIScreen.main.bounds.height * 0.1
                        )
                }
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(
                        width: UIScreen.main.bounds.width * 0.2,
                        height: UIScreen.main.bounds.height * 0.1
                    )
            }
            
            VStack {
                Text(event.dates.first?.start.formattedForEvent() ?? "nil")
                    .font(.custom(EventHubFont.subtitle2))
                    .foregroundStyle(.mainBlue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(event.title.capitalized)
                    .font(.custom(EventHubFont.body2))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
    
                    Text(event.location.slug.formattedLocation)
                        .font(.custom(EventHubFont.subtitle2))
                }
                .padding(.top, 1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.gray)
            }
            .frame(height: UIScreen.main.bounds.height * 0.1)
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
        .padding(.horizontal, 32)
        .padding(.top, 12)
    }
}
