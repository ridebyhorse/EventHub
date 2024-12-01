//
//  FavoritesViewModel.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/23/24.

import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [EventModel] = []
    @Published var isLoading: Bool = false
    @Published var isSearchTapped: Bool = false
    @Published var errorMessage: String = ""

    func fetchFavorites() async {
        isLoading = true
        defer { isLoading = false }

        let favoriteIDs = FavoriteService.shared.getFavoriteEventIDs()
        if favoriteIDs.isEmpty {
            self.favorites = []
            return
        }

        do {
            self.favorites = try await fetchEventDetails(for: favoriteIDs)
        } catch {
            print("Failed to fetch favorite events: \(error)")
            errorMessage = "Failed to load favorites."
        }
    }

    func deleteFavorite(event: EventModel) {
        FavoriteService.shared.removeFavoriteEventID(event.id)
        if let index = favorites.firstIndex(where: { $0.id == event.id }) {
            favorites.remove(at: index)
        }
    }

    private func fetchEventDetails(for ids: [Int]) async throws -> [EventModel] {
        var favoriteEvents: [EventModel] = []

        await withTaskGroup(of: EventModel?.self) { group in
            for id in ids {
                group.addTask {
                    do {
                        let event = try await NetworkService.shared.getEventByID(id)
                        return event
                    } catch {
                        print("Error fetching event with ID \(id): \(error)")
                        return nil
                    }
                }
            }

            for await event in group {
                if let event = event {
                    favoriteEvents.append(event)
                }
            }
        }

        return favoriteEvents
    }
}
