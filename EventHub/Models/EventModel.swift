//
//  EventModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 20.11.2024.
//

import Foundation

struct EventModel: Decodable {
    let id: UUID
    let slug: String
    let title: String
    let favoritesCount: Int
    let commentsCount: Int
    let description: String
    let itemUrl: URL
    let ctype: String
    let place: PlaceModel
    let daterange: DateRangeModel
    let firstImage: ImageModel
    let ageRestriction: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, slug, title, description, ctype, place, daterange
        case favoritesCount = "favorites_count"
        case commentsCount = "comments_count"
        case itemUrl = "item_url"
        case firstImage = "first_image"
        case ageRestriction = "age_restriction"
    }
}

struct DateRangeModel: Decodable {
    let startDate: Date?
    let startTime: Date?
    let start: Date?
    let endDate: Date?
    let endTime: Date?
    let end: Date?
    let isContinuous: Bool
    let isEndless: Bool
    let isStartless: Bool
    let usePlaceSchedule: Bool
    
    private enum CodingKeys: String, CodingKey {
        case start, end
        case startDate = "start_date"
        case startTime = "start_time"
        case endDate = "end_date"
        case endTime = "end_time"
        case isContinuous = "is_continuous"
        case isEndless = "is_endless"
        case isStartless = "is_startless"
        case usePlaceSchedule = "use_place_schedule"
    }
}

struct ImageModel: Decodable {
    let image: URL?
}
