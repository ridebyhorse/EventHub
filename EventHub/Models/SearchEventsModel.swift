//
//  SearchEventsModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 20.11.2024.
//

import Foundation

struct SearchEventsModel: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [EventModel]
}
