//
//  StorageManager.swift
//  EventHub
//
//  Created by Иван Семикин on 01/12/2024.
//

import Foundation

class FavoriteService {
    static let shared = FavoriteService()

    private let favoritesKey = "favoriteEventIDs"

    private init() {}

    func addFavoriteEventID(_ id: Int) {
        var favorites = getFavoriteEventIDs()
        if !favorites.contains(id) {
            favorites.append(id)
            saveFavoriteEventIDs(favorites)
        }
    }

    func removeFavoriteEventID(_ id: Int) {
        var favorites = getFavoriteEventIDs()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
            saveFavoriteEventIDs(favorites)
        }
    }

    func isEventFavorite(_ id: Int) -> Bool {
        let favorites = getFavoriteEventIDs()
        return favorites.contains(id)
    }

    func getFavoriteEventIDs() -> [Int] {
        let defaults = UserDefaults.standard
        return defaults.array(forKey: favoritesKey) as? [Int] ?? []
    }

    private func saveFavoriteEventIDs(_ ids: [Int]) {
        let defaults = UserDefaults.standard
        defaults.set(ids, forKey: favoritesKey)
    }
    
    func fetchFavoriteEvents() async throws -> [EventModel] {
        let favoriteIDs = FavoriteService.shared.getFavoriteEventIDs()
        var favoriteEvents: [EventModel] = []

        await withTaskGroup(of: EventModel?.self) { group in
            for id in favoriteIDs {
                group.addTask {
                    do {
                        return try await NetworkService.shared.getEventByID(id)
                    } catch {
                        print("Ошибка при загрузке события с ID \(id): \(error)")
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
