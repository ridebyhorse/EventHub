//
//  EventsScreenView.swift
//  EventHub
//
//  Created by Иван Семикин on 18/11/2024.
//

import SwiftUI

struct EventsScreenView: View {
    @ObservedObject var viewModel: EventsScreenViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text("Events")
                    .font(.title)
                
                ChangeModeButtonsView(choosedMode: $viewModel.selectedMode)
                    .onChange(of: viewModel.selectedMode) { _ in
                        withAnimation {
                            viewModel.filterEvents()
                        }
                    }
                
                ScrollView {
                    ForEach(viewModel.filteredEvents, id: \.self) { event in
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
    EventsScreenView(viewModel: EventsScreenViewModel(events: [
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA",
            isUpcoming: false
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA",
            isUpcoming: true
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA",
            isUpcoming: true
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA",
            isUpcoming: true
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA",
            isUpcoming: true
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA",
            isUpcoming: true
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA",
            isUpcoming: true
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA",
            isUpcoming: true
        ),
        MockEvent(
            image: "MockEventImage",
            title: "Jo Malone London’s Mother’s Day Presents ",
            date: .now,
            locationName: "Radius Gallery",
            city: "Santa Cruz, CA",
            state: "CA",
            isUpcoming: true
        )
    ]))
}
