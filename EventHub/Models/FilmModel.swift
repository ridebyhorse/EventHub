//
//  FilmModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 28.11.2024.
//

import Foundation

struct FilmModel: Decodable {
    let id: Int
    let title: String
    let poster: PosterModel
    let description: String
    let country: String
    let director: String
}

struct PosterModel: Decodable {
    let image: URL?
}
