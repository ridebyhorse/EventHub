//
//  NetworkService.swift
//  EventHub
//
//  Created by Мария Нестерова on 20.11.2024.
//

import Foundation

enum EventsType {
    case upcoming
    case past
    case nearby
}

class NetworkService {
    static let shared = NetworkService()
    
    private enum Constants {
        static let baseUrl = "https://kudago.com/public-api/v1.4/"
        
        static let language = "?lang=en"
        static let eventCategories = "event-categories/"
        static let locations = "locations/"
        static let search = "search/"
        static let events = "events/"
        static let films = "movies/"
        static let todayEvents = "events-of-the-day/"
        static let lists = "lists/"
        static let places = "places/"
        
        static let searchQueryParameter = "&q="
        static let pageParameter = "&page="
        static let pageSizeParameter = "&page_size="
        static let locationParameter = "&location="
        static let expandParameter = "&expand=place,dates"
        static let contentTypeParameter = "&ctype=events"
        
        static let upcomingParameter = "&actual_since="
        static let pastParameter = "&actual_until="
        static let categoriesParameter = "&categories="
        
        static let fieldsEventsParameter = "&fields=id,publication_date,dates,title,short_title,slug,place,description,body_text,location,categories,tagline,price,is_free,images,favorites_count,comments_count,site_url,tags"
        static let fieldsFilmsParameter = "&fields=id,title,poster,description,country,director"
        static let fieldsTodayEventsParameter = "&fields=date,object,location,title&expand=event"
        static let fieldsPlacesParameter = "&fields=id,title,slug,address,phone,isStub,site_url,coords,subway,images,isClosed,location"
    }
    
    private init() {}
    
    func getEventCategories() async throws -> [EventCategoryModel] {
        let urlString = Constants.baseUrl + Constants.eventCategories + Constants.language
        
        return try await request(url: urlString, response: [EventCategoryModel].self)
    }
    
    func getLocations() async throws -> [LocationModel] {
        let urlString = Constants.baseUrl + Constants.locations + Constants.language
        
        return try await request(url: urlString, response: [LocationModel].self)
    }
    
    func searchEvents(
        location: Location,
        search: String,
        pageNumber: Int? = nil,
        pageSize: Int? = nil
    ) async throws -> SearchEventsModel {
        var urlString = Constants.baseUrl + Constants.search + Constants.language
//        urlString += Constants.locationParameter + location.rawValue
        urlString += Constants.searchQueryParameter + search
        
        if let pageNumber {
            urlString += Constants.pageParameter + String(pageNumber)
        }
        
        if let pageSize {
            urlString += Constants.pageSizeParameter + String(pageSize)
        }
        
        return try await request(url: urlString, response: SearchEventsModel.self)
    }
    
    func getEvents(
        type: EventsType,
        location: Location,
        pageNumber: Int? = nil,
        pageSize: Int? = nil
    ) async throws -> EventsModel {
        var urlString = Constants.baseUrl + Constants.events + Constants.language + Constants.fieldsEventsParameter
        urlString += Constants.locationParameter + location.rawValue
        
        switch type {
        case .upcoming:
            urlString += Constants.upcomingParameter + Date.now.ISO8601Format()
        case .past:
            urlString += Constants.pastParameter + Date.now.ISO8601Format()
        case .nearby:
            break
        }
        
        if let pageNumber {
            urlString += Constants.pageParameter + String(pageNumber)
        }
        
        if let pageSize {
            urlString += Constants.pageSizeParameter + String(pageSize)
        }
        
        return try await request(url: urlString, response: EventsModel.self)
    }
    
    func getEventsByCategory(
        category: EventCategoryModel,
        location: Location,
        pageNumber: Int? = nil,
        pageSize: Int? = nil
    ) async throws -> EventsModel {
        var urlString = Constants.baseUrl + Constants.events + Constants.language + Constants.fieldsEventsParameter
        urlString += Constants.locationParameter + location.rawValue
        urlString += Constants.categoriesParameter + category.slug
        
        if let pageNumber {
            urlString += Constants.pageParameter + String(pageNumber)
        }
        
        if let pageSize {
            urlString += Constants.pageSizeParameter + String(pageSize)
        }
        
        return try await request(url: urlString, response: EventsModel.self)
    }
    
    func getTodayEvents(
        pageNumber: Int? = nil,
        pageSize: Int? = nil
    ) async throws -> TodayEventsModel {
        var urlString = Constants.baseUrl + Constants.events + Constants.language + Constants.fieldsTodayEventsParameter
        
        if let pageNumber {
            urlString += Constants.pageParameter + String(pageNumber)
        }
        
        if let pageSize {
            urlString += Constants.pageSizeParameter + String(pageSize)
        }
        
        return try await request(url: urlString, response: TodayEventsModel.self)
    }
    
    func getFilms(
        pageNumber: Int? = nil,
        pageSize: Int? = nil
    ) async throws -> FilmsModel {
        var urlString = Constants.baseUrl + Constants.films + Constants.language + Constants.fieldsFilmsParameter
        
        if let pageNumber {
            urlString += Constants.pageParameter + String(pageNumber)
        }
        
        if let pageSize {
            urlString += Constants.pageSizeParameter + String(pageSize)
        }
        
        return try await request(url: urlString, response: FilmsModel.self)
    }
    
    func getLists(
        pageNumber: Int? = nil,
        pageSize: Int? = nil
    ) async throws -> ListsModel {
        var urlString = Constants.baseUrl + Constants.lists + Constants.language
        
        if let pageNumber {
            urlString += Constants.pageParameter + String(pageNumber)
        }
        
        if let pageSize {
            urlString += Constants.pageSizeParameter + String(pageSize)
        }
        
        return try await request(url: urlString, response: ListsModel.self)
    }
    
    func getPlaces(
        location: Location? = nil,
        pageNumber: Int? = nil,
        pageSize: Int? = nil
    ) async throws -> PlacesModel {
        var urlString = Constants.baseUrl + Constants.places + Constants.language + Constants.fieldsPlacesParameter
        
        if let location {
            urlString += Constants.locationParameter + location.rawValue
        }
        
        if let pageNumber {
            urlString += Constants.pageParameter + String(pageNumber)
        }
        
        if let pageSize {
            urlString += Constants.pageSizeParameter + String(pageSize)
        }
        
        return try await request(url: urlString, response: PlacesModel.self)
    }
    
    func getEventByID(_ id: Int) async throws -> EventModel {
        let urlString = Constants.baseUrl + Constants.events + "\(id)/" + Constants.language + Constants.fieldsEventsParameter
        return try await request(url: urlString, response: EventModel.self)
    }
    
    private func request<T: Decodable>(url: String, response: T.Type) async throws -> T {
        print(url)
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(T.self, from: data)
        
        return response
    }
    
}
