//
//  EventCategoryModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 20.11.2024.
//

import Foundation

struct EventCategoryModel: Decodable {
    let id: Int
    let slug: String
    let name: String
}
