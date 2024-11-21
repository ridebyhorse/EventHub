//
//  EventShortModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 20.11.2024.
//

import Foundation

struct EventShortModel: Decodable {
    let id: UUID
    let dates: DateRangeModel
    let title: String
    let short_title: String
}
