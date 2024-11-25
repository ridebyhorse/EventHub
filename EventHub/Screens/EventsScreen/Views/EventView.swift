//
//  EventView.swift
//  EventHub
//
//  Created by Иван Семикин on 19/11/2024.
//

import SwiftUI

struct EventView: View {
    let event: EventModel
    
    private let width = UIScreen.main.bounds.width * 0.2
    private let height = UIScreen.main.bounds.height * 0.1
    
    var body: some View {
        HStack(spacing: 16) {
            if let firstImageUrl = event.images.first?.image {
                AsyncImage(url: firstImageUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width,height: height)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .frame(width: width,height: height)
                }
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: width,height: height)
            }
            
            VStack {
                Text(event.dates.first?.start.formattedForEvent() ?? "nil")
                    .font(.custom(EventHubFont.subtitle2))
                    .foregroundStyle(.mainBlue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(event.title.capitalized)
                    .font(.custom(EventHubFont.body2))
                    .foregroundStyle(.black)
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
            .frame(height: height)
        }
        .padding(10)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
        .padding(.horizontal, 32)
        .padding(.top, 12)
    }
}
