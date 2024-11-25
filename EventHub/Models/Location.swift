//
//  Location.swift
//  EventHub
//
//  Created by Мария Нестерова on 21.11.2024.
//

enum Location: String, Codable,  CaseIterable{
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
    
    var displayName: String {
        switch self {
        case .spb: return "Санкт-Петербург"
        case .msk: return "Москва"
        case .nsk: return "Новосибирск"
        case .ekb: return "Екатеринбург"
        case .nnv: return "Нижний Новгород"
        case .kzn: return "Казань"
        case .vbg: return "Выборг"
        case .smr: return "Самара"
        case .krd: return "Краснодар"
        case .sochi: return "Сочи"
        case .ufa: return "Уфа"
        case .krasnoyarsk: return "Красноярск"
        case .kev: return "Киев"
        case .newYork: return "New-York"
        }
    }
}
