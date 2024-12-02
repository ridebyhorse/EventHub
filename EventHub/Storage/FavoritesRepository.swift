//
//  FavoritesRepository.swift
//  EventHub
//
//  Created by Мария Нестерова on 30.11.2024.
//

import Foundation
import RealmSwift
import FirebaseAuth

protocol FavoritesRepository {
    func getFavoritesList() -> [FavoriteItemModel]
    func saveToFavorites(_ item: FavoriteItemModel)
    func removeFromFavoritesList(_ item: FavoriteItemModel)
}

final class FavoritesRepositoryImpl: FavoritesRepository {
    private let storage: StorageService
    
    init(storage: StorageService = StorageService()) {
        self.storage = storage
    }
    
    func getFavoritesList() -> [FavoriteItemModel] {
        let data = storage.fetch(by: FavoriteItem.self)
        return data.map(FavoriteItemModel.init).filter({ $0.email == Auth.auth().currentUser?.email })
    }
    
    func saveToFavorites(_ item: FavoriteItemModel) {
        var data = getFavoritesList()
        data.append(item)
        let objects = data.map(FavoriteItem.init)
        try? storage.saveOrUpdateAllObjects(objects: objects)
    }
    
    func removeFromFavoritesList(_ item: FavoriteItemModel) {
        let object = FavoriteItem(item)
        try? storage.delete(object: object)
    }
}
