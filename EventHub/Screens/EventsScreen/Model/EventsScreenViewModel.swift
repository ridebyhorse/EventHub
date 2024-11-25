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
    @Published var events: [EventModel] = []
    @Published var isLoading: Bool = false // Отслеживание загрузки
    
    func fetchUpcomingEvents(for location: Location) async {
        isLoading = true // Начало загрузки
        defer { isLoading = false } // Окончание загрузки
        
        do {
            let eventsModel = try await networkService.getEvents(type: .upcoming, location: location)
            events = eventsModel.results
        } catch {
            print("Ошибка при загрузке предстоящих событий: \(error.localizedDescription)")
            events = [] // Очистка массива в случае ошибки
        }
    }

    func fetchPastEvents(for location: Location) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let eventsModel = try await networkService.getEvents(type: .past, location: location)
            events = eventsModel.results
        } catch {
            print("Ошибка при загрузке прошедших событий: \(error.localizedDescription)")
            events = []
        }
    }
    
    func fetchEvents(for location: Location) async {
        switch selectedMode {
        case .upcoming:
            await fetchUpcomingEvents(for: location)
        case .pastEvents:
            await fetchPastEvents(for: location)
        }
    }
}
