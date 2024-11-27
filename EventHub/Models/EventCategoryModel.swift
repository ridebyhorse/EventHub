//
//  EventCategoryModel.swift
//  EventHub
//
//  Created by Мария Нестерова on 20.11.2024.
//

import Foundation

struct EventCategoryModel: Decodable {
    let id: Int
    let slug: String
    let name: String
    
    var systemIcon: String {
            switch slug {
            case "business-events": return "briefcase.fill"
            case "cinema": return "film.fill"
            case "concert": return "music.note"
            case "education": return "graduationcap.fill"
            case "entertainment": return "sparkles"
            case "exhibition": return "paintpalette.fill"
            case "fashion": return "tshirt.fill"
            case "festival": return "party.popper"
            case "holiday": return "sun.max.fill"
            case "kids": return "figure.child"
            case "other": return "questionmark.circle.fill"
            case "party": return "sparkles"
            case "photo": return "camera.fill"
            case "quest": return "magnifyingglass"
            case "recreation": return "leaf.fill"
            case "shopping": return "cart.fill"
            case "social-activity": return "hands.sparkles.fill"
            case "stock": return "tag.fill"
            case "theater": return "theatermasks.fill"
            case "tour": return "map.fill"
            case "yarmarki-razvlecheniya-yarmarki": return "gift.fill"
            default: return "questionmark.circle.fill" // Default fallback icon
            }
        }
    
    func assignedColor(index: Int) -> CategoryColor {
        let colors = CategoryColor.allCases
        return colors[index % colors.count]
    }
}
