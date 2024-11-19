//
//  EventsScreenView.swift
//  EventHub
//
//  Created by Иван Семикин on 18/11/2024.
//

import SwiftUI

struct EventsScreenView: View {
    @State private var choosedMode: ModeEvents = .upcoming
    
    let events: [MockEvent]
    
    var body: some View {
        ZStack {
            VStack {
                Text("Events")
                    .font(.title)
                
                ChangeModeButtonsView(choosedMode: $choosedMode)
                
                ScrollView {
                    ForEach(events, id: \.self) { event in
                        EventView(event: event)
                    }
                }
                
            }
            
            VStack {
                Spacer()
                
                ExploreEventsButtonView()
            }
        }
    }
}

#Preview {
    EventsScreenView(events: [
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA"
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA"
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA"
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA"
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA"
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA"
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA"
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA"
        )
    ])
}
