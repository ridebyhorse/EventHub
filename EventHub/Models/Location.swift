//
//  Location.swift
//  EventHub
//
//  Created by Мария Нестерова on 21.11.2024.
//

import CoreLocation

enum Location: String, Codable {
    case spb                    // Санкт-Петербург
    case msk                    // Москва
    case nsk                    // Новосибирск
    case ekb                    // Екатеринбург
    case nnv                    // Нижний Новгород
    case kzn                    // Казань
    case vbg                    // Выборг
    case smr                    // Самара
    case krd                    // Краснодар
    case sochi                  // Сочи
    case ufa                    // Уфа
    case krasnoyarsk            // Красноярск
    case kev                    // Киев
    case newYork = "new-york"   // Нью-Йорк
    
    var coordinates: CLLocationCoordinate2D {
        switch self {
        case .spb:
            return CLLocationCoordinate2D(latitude: 59.9342802, longitude: 30.3350986) // Санкт-Петербург
        case .msk:
            return CLLocationCoordinate2D(latitude: 55.7558, longitude: 37.6173) // Москва
        case .nsk:
            return CLLocationCoordinate2D(latitude: 55.0084, longitude: 82.9357) // Новосибирск
        case .ekb:
            return CLLocationCoordinate2D(latitude: 56.8389, longitude: 60.6057) // Екатеринбург
        case .nnv:
            return CLLocationCoordinate2D(latitude: 56.2965, longitude: 43.9361) // Нижний Новгород
        case .kzn:
            return CLLocationCoordinate2D(latitude: 55.7943, longitude: 49.1057) // Казань
        case .vbg:
            return CLLocationCoordinate2D(latitude: 59.9415, longitude: 30.3298) // Выборг
        case .smr:
            return CLLocationCoordinate2D(latitude: 53.1952, longitude: 50.1006) // Самара
        case .krd:
            return CLLocationCoordinate2D(latitude: 45.0355, longitude: 39.0490) // Краснодар
        case .sochi:
            return CLLocationCoordinate2D(latitude: 43.5853, longitude: 39.7202) // Сочи
        case .ufa:
            return CLLocationCoordinate2D(latitude: 54.7388, longitude: 55.9721) // Уфа
        case .krasnoyarsk:
            return CLLocationCoordinate2D(latitude: 56.0153, longitude: 92.8933) // Красноярск
        case .kev:
            return CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5236) // Киев
        case .newYork:
            return CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060) // Нью-Йорк
        }
    }
}
