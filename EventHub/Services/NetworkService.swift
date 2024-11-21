//
//  NetworkService.swift
//  EventHub
//
//  Created by Мария Нестерова on 20.11.2024.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private enum Constants {
        static let baseUrl = "https://kudago.com/public-api/v1.4/"
        static let language = "?lang=en"
        static let eventCategories = "event-categories/"
        static let locations = "locations/"
        static let search = "search/"
        static let events = "events/"
        static let searchQueryParameter = "&q="
        static let pageParameter = "&page="
        static let pageSizeParameter = "&page_size="
        static let locationParameter = "&location="
        static let expandParameter = "&expand=place,dates"
        static let contentTypeParameter = "&ctype=events"
        static let fieldsEventsParameter = "&fields="
    }
    
    private init() {}
    
    func getEventCategories() async throws -> [EventCategoryModel] {
        let urlString = Constants.baseUrl + Constants.eventCategories + Constants.language
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode([EventCategoryModel].self, from: data)
        
        return response
    }
    
    func getLocations() async throws -> [LocationModel] {
        let urlString = Constants.baseUrl + Constants.locations + Constants.language
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode([LocationModel].self, from: data)
        
        return response
    }
    
    func searchEvents(
        search: String,
        pageNumber: Int? = nil,
        pageSize: Int? = nil
    ) async throws -> SearchEventsModel {
        var urlString = Constants.baseUrl + Constants.search + Constants.language
        urlString += Constants.searchQueryParameter + search
        
        if let pageNumber {
            urlString += Constants.pageParameter + String(pageNumber)
        }
        
        if let pageSize {
            urlString += Constants.pageSizeParameter + String(pageSize)
        }
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(SearchEventsModel.self, from: data)
        
        return response
    }
    
    func getEventsByLocation(
        location: Location,
        pageNumber: Int? = nil,
        pageSize: Int? = nil
    ) async throws -> [EventShortModel] {
        var urlString = Constants.baseUrl + Constants.events + Constants.language
        urlString += Constants.locationParameter + location.rawValue
        
        if let pageNumber {
            urlString += Constants.pageParameter + String(pageNumber)
        }
        
        if let pageSize {
            urlString += Constants.pageSizeParameter + String(pageSize)
        }
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode([EventShortModel].self, from: data)
        
        return response
    }
}
