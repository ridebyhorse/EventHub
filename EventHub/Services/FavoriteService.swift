//
//  StorageManager.swift
//  EventHub
//
//  Created by Иван Семикин on 01/12/2024.
//

import Foundation

extension Notification.Name {
    static let favoritesChanged = Notification.Name("favoritesChanged")
}

final class FavoriteService {
    static let shared = FavoriteService()

    private let favoritesKey = "favoriteEventIDs"

    private init() {}

    func addFavoriteEventID(_ id: Int) {
        var favorites = getFavoriteEventIDs()
        if !favorites.contains(id) {
            favorites.append(id)
            saveFavoriteEventIDs(favorites)
            NotificationCenter.default.post(name: .favoritesChanged, object: nil)
        }
    }

    func removeFavoriteEventID(_ id: Int) {
        var favorites = getFavoriteEventIDs()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
            saveFavoriteEventIDs(favorites)
            NotificationCenter.default.post(name: .favoritesChanged, object: nil)
        }
    }

    func isEventFavorite(_ id: Int) -> Bool {
        return getFavoriteEventIDs().contains(id)
    }

    func getFavoriteEventIDs() -> [Int] {
        let defaults = UserDefaults.standard
        return defaults.array(forKey: favoritesKey) as? [Int] ?? []
    }

    private func saveFavoriteEventIDs(_ ids: [Int]) {
        let defaults = UserDefaults.standard
        defaults.set(ids, forKey: favoritesKey)
    }
}
