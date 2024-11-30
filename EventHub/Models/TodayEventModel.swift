//
//  TodayEventModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 28.11.2024.
//

import Foundation

struct TodayEventModel: Decodable {
    let id: Int?
    let object: ObjectModel?
    let title: String?
}

struct ObjectModel: Decodable {
    let id: Int
    let ctype: String
}
