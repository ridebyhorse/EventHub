//
//  ExploreViewModel.swift
//  EventHub
//
//  Created by Kate Kashko on 22.11.2024.
//

import SwiftUI
import Combine

class ExploreViewModel: ObservableObject {
    @Published var upcomingEvents: [EventModel] = []
    @Published var nearbyEvents: [EventModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let networkService = NetworkService.shared
    private var cancellables = Set<AnyCancellable>()
    
    func fetchData(location: Location) {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let events = try await networkService.getEvents(type: .upcoming, location: location)
                let nearby = try await networkService.getEvents(type: .nearby, location: location)

                // Переносим публикацию данных на главный поток
                DispatchQueue.main.async {
                    self.upcomingEvents = events.results
                    self.nearbyEvents = nearby.results
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }

}

