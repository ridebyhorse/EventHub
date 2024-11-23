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
    
    private var upcomingEvents: [EventModel] = []
    
    @Published var selectedMode: ModeEvents = .upcoming
    
    func fetchUpcomingEvents() async {
        do {
            let eventsModel = try await networkService.getEvents(
                type: .upcoming,
                location: .newYork
            )
            upcomingEvents = eventsModel.results
        } catch {
            print("Ошибка при загрузке предстоящих событий: \(error.localizedDescription)")
        }
    }
}
