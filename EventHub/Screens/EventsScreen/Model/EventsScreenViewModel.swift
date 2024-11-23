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

final class EventsScreenViewModel: ObservableObject {
    private let networkService = NetworkService.shared
    
    @Published var selectedMode: ModeEvents = .upcoming
    @Published var events: [EventModel] = []
    
    func fetchUpcomingEvents(for location: Location) async {
        do {
            let eventsModel = try await networkService.getEvents(type: .upcoming, location: location)
            events = eventsModel.results
        } catch {
            print("Ошибка при загрузке предстоящих событий: \(error.localizedDescription)")
        }
    }

    func fetchPastEvents(for location: Location) async {
        do {
            let eventsModel = try await networkService.getEvents(type: .past, location: location)
            events = eventsModel.results
        } catch {
            print("Ошибка при загрузке прошедших событий: \(error.localizedDescription)")
        }
    }
}
