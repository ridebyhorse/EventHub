//
//  EventsScreenView.swift
//  EventHub
//
//  Created by Иван Семикин on 18/11/2024.
//

import SwiftUI

struct EventsScreenView: View {
    @State private var choosedMode: ModeEvents = .upcoming
    
    var body: some View {
        VStack {
            Text("Events")
                .font(.title)
            
            ChangeModeButtonsView(choosedMode: $choosedMode)
            
            // TODO: - To create events' list with ScrollView
            Spacer()
            
            ExploreEventsButtonView()
        }
    }
}

#Preview {
    EventsScreenView()
}
