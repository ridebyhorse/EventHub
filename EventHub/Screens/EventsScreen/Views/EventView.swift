//
//  EventView.swift
//  EventHub
//
//  Created by Иван Семикин on 19/11/2024.
//

import SwiftUI

struct MockEvent {
    let image: String
    let title: String
    let date: Date
    let locationName: String
    let city: String
    let state: String
    
    func formattedLocation() -> String {
        "\(locationName) • \(city), \(state)"
    }
}

struct EventView: View {
    let event: MockEvent
    
    var body: some View {
        HStack {
            Image(.mockEvent)
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width * 0.2,
                    height: UIScreen.main.bounds.height * 0.1
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack {
                Text(event.date.formattedForEvent())
                    .font(.custom(EventHubFont.subtitle2))
                    .foregroundStyle(.mainBlue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(event.title)
                    .font(.custom(EventHubFont.body2))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Image(systemName: "mappin.circle.fill")
    
                    Text(event.formattedLocation())
                        .font(.custom(EventHubFont.subtitle2))
                }
                .padding(.top, 1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    EventView(
        event: MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA"
        )
    )
}
