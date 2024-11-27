//
//  FavoritesViewModel.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/23/24.
//
import Foundation
import CoreData

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Event] = []
    @Published var isSearchTapped: Bool = false
    private var dataController: FavoritesDataController

    init() {
        dataController = FavoritesDataController()
        fetchFavorites()
    }

    func saveFavorite(title: String, date: String, location: String, city: String) {
        dataController.saveEvent(title: title, date: date, location: location, city: city)
        fetchFavorites()
    }

    func deleteFavorite(event: Event) {
        dataController.deleteEvent(event: event)
        fetchFavorites()
    }

    private func fetchFavorites() {
        favorites = dataController.fetchSavedEvents()
    }
}
