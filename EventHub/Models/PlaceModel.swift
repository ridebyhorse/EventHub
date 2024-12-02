//
//  PlaceModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 20.11.2024.
//

import Foundation

struct PlaceModel: Decodable, Identifiable {
    let id: Int
    let title: String?
    let slug: String?
    let address: String?
    let phone: String?
    let isStub: Bool?
    let siteUrl: URL?
    let coords: CoordinatesModel?
    let subway: String?
    let images: [ImageModel]?
    let isClosed: Bool?
    let location: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, slug, address, phone, coords, subway, location, images
        case isStub = "is_stub"
        case siteUrl = "site_url"
        case isClosed = "is_closed"
    }
}

struct CoordinatesModel: Decodable {
    let lat: Double
    let lon: Double
}
