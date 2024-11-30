//
//  SearchCardView.swift
//  EventHub
//
//  Created by Мария Нестерова on 24.11.2024.
//

import SwiftUI
import Kingfisher

struct SearchCardView: View {
    let event: SearchCardViewItem
    
    var body: some View {
        HStack(spacing: 18) {
            KFImage.url(event.image)
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width * 0.2,
                    height: UIScreen.main.bounds.height * 0.1
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(spacing: 4) {
                Text(event.date)
                    .font(.custom(EventHubFont.subtitle2))
                    .foregroundStyle(.primaryBlue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 22)
                
                Text(event.title)
                    .font(.custom(EventHubFont.title3))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 22)
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
        .padding(.horizontal, 24)
        .padding(.top, 16)
    }
}

struct SearchCardViewItem: Hashable {
    let image: URL?
    let title: String
    let date: String
}

#Preview {
    SearchCardView(
        event: .init(
            image: URL(string: "https://steamuserimages-a.akamaihd.net/ugc/1016066919921088590/5ADE1289A45536BB0885180A1B8DED0E339FD33A/?imw=512&amp;imh=373&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true"),
            title: "Jo malone london’s mother’s day",
            date: "1st  May- Sat -2:00 PM")
    )
}
