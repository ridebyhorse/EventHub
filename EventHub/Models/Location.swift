//
//  Location.swift
//  EventHub
//
//  Created by Мария Нестерова on 21.11.2024.
//

enum Location: String, Codable, CaseIterable {
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
}
