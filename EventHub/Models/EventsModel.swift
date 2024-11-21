//
//  EventsModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 21.11.2024.
//

import Foundation

struct EventsModel: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [EventModel]
}
