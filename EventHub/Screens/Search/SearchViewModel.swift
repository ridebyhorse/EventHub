//
//  SearchViewModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 23.11.2024.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var events: [SearchCardViewItem] = []
    @Published var searchText = "" { didSet { searchRequest() } }
    
    private let location: Location
    private var eventsResponse: [SearchEventModel] = [] { didSet { mapToEventViewItems() } }
    
    init(location: Location) {
        self.location = location
    }
    
    private func searchRequest() {
        Task {
            do {
                eventsResponse = try await NetworkService.shared.searchEvents(location: location, search: searchText).results ?? []
            } catch {
                print(error)
            }
        }
    }
    
    private func mapToEventViewItems() {
        var mappedEvents: [SearchCardViewItem] = []
        for event in eventsResponse {
            if event.daterange?.startDate == nil {
                continue
            }
            mappedEvents.append(
                .init(
                    image: event.firstImage?.image,
                    title: event.title,
                    date: event.daterange?.startDate?.formattedForSearchEvent() ?? ""
                )
            )
        }
        DispatchQueue.main.async { [weak self] in
            self?.events = mappedEvents
        }
    }
}
