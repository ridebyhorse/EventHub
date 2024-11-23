//
//  Location.swift
//  EventHub
//
//  Created by Мария Нестерова on 21.11.2024.
//

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
    
    var formattedLocation: String {
        switch self {
        case .spb:
            return "St. Petersburg • Russia"
        case .msk:
            return "Moscow • Russia"
        case .nsk:
            return "Novosibirsk • Russia"
        case .ekb:
            return "Yekaterinburg • Russia"
        case .nnv:
            return "Nizhny Novgorod • Russia"
        case .kzn:
            return "Kazan • Russia"
        case .vbg:
            return "Vyborg • Russia"
        case .smr:
            return "Samara • Russia"
        case .krd:
            return "Krasnodar • Russia"
        case .sochi:
            return "Sochi • Russia"
        case .ufa:
            return "Ufa • Russia"
        case .krasnoyarsk:
            return "Krasnoyarsk • Russia"
        case .kev:
            return "Kyiv • Ukraine"
        case .newYork:
            return "New York • NY"
        }
    }
}
