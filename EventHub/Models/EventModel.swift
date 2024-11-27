//
//  EventModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 20.11.2024.
//

import Foundation

struct EventModel: Decodable, Hashable {
    let id: Int
    let publicationDate: Date
    let dates: [ShortDateRangeModel]
    let title: String
    let shortTitle: String
    let slug: String
    let place: ShortPlaceModel?
    let description: String
    let bodyText: String
    let location: ShortLocationModel
    let categories: [String]
    let tagline: String
    let price: String
    let isFree: Bool
    let images: [ImageModel]
    let favoritesCount: Int
    let commentsCount: Int
    let siteUrl: URL
    let tags: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id, dates, title, slug, place, description, location, categories, tagline, price, images, tags
        case publicationDate = "publication_date"
        case shortTitle = "short_title"
        case bodyText = "body_text"
        case isFree = "is_free"
        case favoritesCount = "favorites_count"
        case commentsCount = "comments_count"
        case siteUrl = "site_url"
    }
}

struct ShortDateRangeModel: Decodable, Hashable {
    let start: Date
    let end: Date
}

struct ShortPlaceModel: Decodable, Hashable {
    let id: Int
}

struct ShortLocationModel: Decodable, Hashable {
    let slug: Location
}
