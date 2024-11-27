//
//  NotificationsView.swift
//  EventHub
//
//  Created by Мария Нестерова on 26.11.2024.
//

import SwiftUI

private struct NotificationsCardView: View {
    let title: String
    let dateDescription: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.custom(EventHubFont.title3))
                .foregroundStyle(.mainBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.top, 22)
            
            Text(dateDescription)
                .font(.custom(EventHubFont.subtitle3))
                .foregroundStyle(.mainBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 22)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
        .padding(.horizontal, 24)
        .padding(.top, 16)
    }
}

private struct NotificationsEmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image(.emptyNotifications)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 110)
                    .shadow(color: .primaryBlue, radius: 1)
                Text("No Notifications!")
                    .font(.custom(EventHubFont.h3))
                    .foregroundStyle(.mainBlack)
                    .padding(8)
                Text("There will be notifications here. Explore your favorite events and subscribe")
                    .font(.custom(EventHubFont.body2.name, size: EventHubFont.body2.size))
                    .foregroundStyle(.mainBlack)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 28)
            }
            Spacer()
        }
    }
}
#Preview {
//    NotificationsCardView(
//        title: "International International Band Music Concert coming soon!",
//        dateDescription: "7 days ago"
//    )
    NotificationsEmptyView()
}
