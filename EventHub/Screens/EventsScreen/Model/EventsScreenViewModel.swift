//
//  EventsScreenViewModel.swift
//  EventHub
//
//  Created by Иван Семикин on 19/11/2024.
//

import Foundation

enum ModeEvents {
    case upcoming
    case pastEvents
}

@MainActor
final class EventsScreenViewModel: ObservableObject {
    private let networkService = NetworkService.shared
    
    @Published var selectedMode: ModeEvents = .upcoming
    @Published var upcomingEvents: [EventModel] = []
    @Published var pastEvents: [EventModel] = []
    @Published var isLoading: Bool = false
    @Published var events: [EventModel] = []
    
    func loadAllEvents(for location: Location) async {
        isLoading = true
        defer { isLoading = false }
        
        await fetchUpcomingEvents(for: location)
        await fetchPastEvents(for: location)
        
        updateDisplayedEvents()
    }
    
    func fetchUpcomingEvents(for location: Location) async {
        do {
            let eventsModel = try await networkService.getEvents(type: .upcoming, location: location)
            upcomingEvents = eventsModel.results
        } catch {
            print("Ошибка при загрузке предстоящих событий: \(error.localizedDescription)")
            upcomingEvents = []
        }
    }

    func fetchPastEvents(for location: Location) async {
        do {
            let eventsModel = try await networkService.getEvents(type: .past, location: location)
            pastEvents = eventsModel.results
        } catch {
            print("Ошибка при загрузке прошедших событий: \(error.localizedDescription)")
            pastEvents = []
        }
    }
    
    func updateDisplayedEvents() {
        switch selectedMode {
        case .upcoming:
            events = upcomingEvents
        case .pastEvents:
            events = pastEvents
        }
    }
}
