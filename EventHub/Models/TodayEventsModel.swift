//
//  TodayEventsModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 28.11.2024.
//

import Foundation

struct TodayEventsModel: Decodable {
    let count: Int?
    let next: URL?
    let previous: URL?
    let results: [TodayEventModel]?
}