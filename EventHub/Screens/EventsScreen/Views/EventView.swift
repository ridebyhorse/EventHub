//
//  EventView.swift
//  EventHub
//
//  Created by Иван Семикин on 19/11/2024.
//

import SwiftUI

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
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
    
                    Text(event.formattedLocation())
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

struct MockEvent: Hashable {
    let image: String
    let title: String
    let date: Date
    let locationName: String
    let city: String
    let state: String
    let isUpcoming: Bool
    
    func formattedLocation() -> String {
        "\(locationName) • \(city), \(state)"
    }
    
    static func mockEvents() -> [Self] {
        return [
            MockEvent(
                image: "MockEventImage",
                title: "Jo Malone London’s Mother’s Day Presents",
                date: .now,
                locationName: "Radius Gallery",
                city: "Santa Cruz",
                state: "CA",
                isUpcoming: true
            ),
            MockEvent(
                image: "MockEventImage",
                title: "Santa Cruz Art Festival",
                date: Calendar.current.date(byAdding: .day, value: 2, to: .now)!,
                locationName: "Downtown Santa Cruz",
                city: "Santa Cruz",
                state: "CA",
                isUpcoming: true
            ),
            MockEvent(
                image: "MockEventImage",
                title: "Bay Area Food Truck Fest",
                date: Calendar.current.date(byAdding: .day, value: -5, to: .now)!,
                locationName: "Alameda County Fairgrounds",
                city: "Pleasanton",
                state: "CA",
                isUpcoming: false
            ),
            MockEvent(
                image: "MockEventImage",
                title: "Oakland Jazz Night",
                date: Calendar.current.date(byAdding: .hour, value: -12, to: .now)!,
                locationName: "The Sound Room",
                city: "Oakland",
                state: "CA",
                isUpcoming: false
            ),
            MockEvent(
                image: "MockEventImage",
                title: "Silicon Valley Tech Meetup",
                date: Calendar.current.date(byAdding: .day, value: 7, to: .now)!,
                locationName: "San Jose Convention Center",
                city: "San Jose",
                state: "CA",
                isUpcoming: true
            )
        ]
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
            state: "CA",
            isUpcoming: true
        )
    )
}
