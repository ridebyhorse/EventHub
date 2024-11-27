//
//  ExploreViewModel.swift
//  EventHub
//
//  Created by Kate Kashko on 22.11.2024.
//

import SwiftUI
import Combine

class ExploreViewModel: ObservableObject {
    @Published var categories: [EventCategoryModel] = []
    @Published var selectedCategory: EventCategoryModel? = nil
    @Published var filteredUpcomingEvents: [EventModel] = []
    @Published var filteredNearbyEvents: [EventModel] = []
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
                        // Fetch categories
                        let fetchedCategories = try await networkService.getEventCategories()
                        DispatchQueue.main.async {
                            self.categories = fetchedCategories
                            self.selectedCategory = nil
//                            self.selectedCategory = fetchedCategories.first
                        }

                        // Fetch events
                        async let upcoming = networkService.getEvents(type: .upcoming, location: location)
                        async let nearby = networkService.getEvents(type: .nearby, location: location)

                        let (fetchedUpcoming, fetchedNearby) = try await (upcoming, nearby)

                        DispatchQueue.main.async {
                            self.upcomingEvents = fetchedUpcoming.results
                            self.nearbyEvents = fetchedNearby.results
                            self.filterEventsByCategory()
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
    func selectCategory(_ category: EventCategoryModel) {
            selectedCategory = category
            filterEventsByCategory()
        }

        private func filterEventsByCategory() {
            guard let selectedCategory else {
                filteredUpcomingEvents = upcomingEvents
                filteredNearbyEvents = nearbyEvents
                return
            }

            // Filter events by selected category
            filteredUpcomingEvents = upcomingEvents.filter {
                $0.categories.contains(selectedCategory.slug)
            }
            filteredNearbyEvents = nearbyEvents.filter {
                $0.categories.contains(selectedCategory.slug)
            }
            print("Selected Category: \(selectedCategory.name)")
            print("Filtered Upcoming Events: \(filteredUpcomingEvents.count)")
            print("Filtered Nearby Events: \(filteredNearbyEvents.count)")
        }
    }
