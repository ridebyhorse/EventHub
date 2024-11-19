//
//  EventView.swift
//  EventHub
//
//  Created by Иван Семикин on 19/11/2024.
//

import SwiftUI

struct MockEvent {
    let image: String
    let title: String
    let date: Date
    let locationName: String
    let city: String
    let state: String
    
    func formattedLocation() -> String {
        "\(locationName) • \(city), \(state)"
    }
}

struct EventView: View {
    var body: some View {
        HStack {
            Image(.mockEvent)
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width * 0.2,
                    height: UIScreen.main.bounds.height * 0.1
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    EventView()
}
