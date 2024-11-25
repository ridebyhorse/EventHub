//
//  SeeAllEventsScreenView.swift
//  EventHub
//
//  Created by Иван Семикин on 25/11/2024.
//

import SwiftUI

struct SeeAllEventsScreenView: View {
    @State var events: [EventModel]
    
    var body: some View {
        ScrollView {
            ForEach(events, id: \.self) { event in
                EventView(event: event)
            }
        }
    }
}

#Preview {
    SeeAllEventsScreenView(events: [])
}
