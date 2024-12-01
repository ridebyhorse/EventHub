//
//  SeeAllExploreViewModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 01.12.2024.
//

import Foundation

enum SeeAllMode {
    case upcoming
    case nearby
}

@MainActor
final class SeeAllExploreViewModel: ObservableObject {
    private let networkService = NetworkService.shared
    
    @Published var mode: SeeAllMode
    @Published var upcomingEvents: [EventModel] = []
    @Published var nearbyEvents: [EventModel] = []
    @Published var isLoading: Bool = false
    @Published var events: [EventModel] = []
    
    init(mode: SeeAllMode) {
        self.mode = mode
    }
    
    func loadAllEvents(for location: Location) async {
        isLoading = true
        defer { isLoading = false }
        
        switch mode {
        case .upcoming:
            await fetchUpcomingEvents(for: location)
        case .nearby:
            await fetchNearbyEvents(for: location)
        }
        
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

    func fetchNearbyEvents(for location: Location) async {
        do {
            let eventsModel = try await networkService.getEvents(type: .nearby, location: location)
            nearbyEvents = eventsModel.results
        } catch {
            print("Ошибка при загрузке событий рядом: \(error.localizedDescription)")
            nearbyEvents = []
        }
    }
    
    func updateDisplayedEvents() {
        switch mode {
        case .upcoming:
            events = upcomingEvents
        case .nearby:
            events = nearbyEvents
        }
    }
}
