//
//  FavoritesViewModel.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/23/24.

import Foundation
import CoreData
import FirebaseAuth
import Firebase

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [EventModel] = []
     var dataController: FavoritesDataController
    @Published var isLoading: Bool = false
    @Published var isSearchTapped: Bool = false
    @Published var errorMessage = ""
     var userEmail: String? {
        Auth.auth().currentUser?.email ?? UserDefaults.standard.string(forKey: "rememberedEmail")
    }

    init(dataController: FavoritesDataController = FavoritesDataController()) {
        self.dataController = dataController
    }

    func setup() async {
        isLoading = true
        await fetchFavorites()
        isLoading = false
    }

    func addToFavorites(event: EventModel) async {
        guard let email = userEmail else {
            print("User is not signed in.")
            return
        }
        dataController.saveEvent(id: event.id, userEmail: email)
        await fetchFavorites()
    }

    func deleteFavorite(event: EventModel) async {
        guard let email = userEmail else {
            print("User is not signed in.")
            return
        }
        dataController.deleteEvent(withId: event.id, for: email)
        await fetchFavorites()
    }

    private func fetchFavorites() async {
        guard let email = userEmail else {
            print("User is not signed in.")
            return
        }
        let ids = dataController.fetchSavedEvents(for: email)
        self.favorites = await fetchEventDetails(for: ids)
    }

    private func fetchEventDetails(for ids: [Int]) async -> [EventModel] {
        do {
            let allEvents = try await NetworkService.shared.getEvents(type: .nearby, location: .msk)
            let filteredEvents = allEvents.results.filter { ids.contains($0.id) }
            return filteredEvents
        } catch {
            print("Failed to fetch events: \(error)")
            return []
        }
    }
}
