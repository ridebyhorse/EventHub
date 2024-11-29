//
//  PlacesModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 28.11.2024.
//

import Foundation

struct PlacesModel: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [PlaceModel]
}
