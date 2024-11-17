//
//  Font.swift
//  EventHub
//
//  Created by Мария Нестерова on 17.11.2024.
//

import Foundation

struct Font {
    let name: String
    let size: CGFloat
}

enum EventHubFont {
    static let h1 = Font(name: "AirbnbCereal_W_Bd", size: 50)
    static let h2 = Font(name: "AirbnbCereal_W_Bk", size: 35)
    static let h3 = Font(name: "AirbnbCereal_W_Bk", size: 30)
    static let h4 = Font(name: "AirbnbCereal_W_Md", size: 24)
    static let h5 = Font(name: "AirbnbCereal_W_Md", size: 22)
    static let button = Font(name: "AirbnbCereal_W_Md", size: 16)
    static let title1 = Font(name: "AirbnbCereal_W_Md", size: 18)
    static let title2 = Font(name: "AirbnbCereal_W_Md", size: 16)
    static let title3 = Font(name: "AirbnbCereal_W_Md", size: 15)
    static let body1 = Font(name: "AirbnbCereal_W_Bk", size: 16)
    static let body2 = Font(name: "AirbnbCereal_W_Bk", size: 15)
    static let body3 = Font(name: "AirbnbCereal_W_Bk", size: 14)
    static let subtitle2 = Font(name: "AirbnbCereal_W_Bk", size: 13)
    static let subtitle3 = Font(name: "AirbnbCereal_W_Bk", size: 12)
}
