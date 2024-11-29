//
//  ListModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 28.11.2024.
//

import Foundation

struct ListModel: Decodable {
    let id: Int
    let publicationDate: Date
    let title: String
    let slug: String
    let siteUrl: URL
    
    private enum CodingKeys: String, CodingKey {
        case id, title, slug
        case publicationDate = "publication_date"
        case siteUrl = "site_url"
    }
}
