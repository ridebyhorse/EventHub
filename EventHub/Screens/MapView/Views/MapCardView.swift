//
//  MapCardView.swift
//  EventHub
//
//  Created by Roman Golub on 28.11.2024.
//

import SwiftUI
import Kingfisher

struct MapCardView: View {
    // MARK: - Properties
    var image: URL?
    var date: String
    var title: String
    var adress: String
    
    private let width = UIScreen.main.bounds.width * 0.2
    private let height = UIScreen.main.bounds.height * 0.1
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            KFImage.url(image)
                .placeholder({
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(0.7)
                        .frame(width: width,height: height)
                })
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack {
                Text(date)
                    .font(.custom(EventHubFont.subtitle2))
                    .foregroundStyle(.mainBlue)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 12)
                
                Spacer()
                
                Text(title.capitalizingFirstLetter())
                    .font(.custom(EventHubFont.body2))
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(.mapPin)
                    
                    Text(adress)
                        .font(.custom(EventHubFont.subtitle2))
                }
                .padding(.bottom, 12)
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

//#Preview {
//    MapCardView(image: "MockEventImage", date: "Wed, Apr 28 • 5:30 PM", title: "Jo Malone London’s Mother’s Day Presents", adress: "Radius Gallery • Santa Cruz, CA")
//}
