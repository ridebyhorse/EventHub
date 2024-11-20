//
//  EventsScreenViewModel.swift
//  EventHub
//
//  Created by Иван Семикин on 19/11/2024.
//

import Foundation

final class EventsScreenViewModel: ObservableObject {
    private let events: [MockEvent]
    
    @Published var selectedMode: ModeEvents = .upcoming
    @Published var filteredEvents: [MockEvent] = []
    
    init(events: [MockEvent]) {
        self.events = events
        filterEvents()
    }
    
    func filterEvents() {
        switch selectedMode {
        case .upcoming:
            filteredEvents = events.filter { $0.isUpcoming }
        case .pastEvents:
            filteredEvents = events.filter { !$0.isUpcoming }
        }
    }
}
