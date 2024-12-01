//
//  StorageManager.swift
//  EventHub
//
//  Created by Иван Семикин on 01/12/2024.
//

import SwiftUI

extension Notification.Name {
    static let favoritesChanged = Notification.Name("favoritesChanged")
}

final class FavoriteService: ObservableObject {
    static let shared = FavoriteService()

    @AppStorage("favoriteEventIDs") private var favoriteEventIDsData: Data = Data()

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
        guard let favorites = try? JSONDecoder().decode([Int].self, from: favoriteEventIDsData) else {
            return []
        }
        return favorites
    }

    private func saveFavoriteEventIDs(_ ids: [Int]) {
        if let data = try? JSONEncoder().encode(ids) {
            favoriteEventIDsData = data
        }
    }
}
