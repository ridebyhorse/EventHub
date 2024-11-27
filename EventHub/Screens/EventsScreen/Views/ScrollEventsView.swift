//
//  ScrollEventsView.swift
//  EventHub
//
//  Created by Иван Семикин on 25/11/2024.
//

import SwiftUI

struct ScrollEventsView: View {
    @ObservedObject var viewModel: EventsScreenViewModel
    
    var body: some View {
        if viewModel.isLoading {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(2)
            Spacer()
        } else {
            if !viewModel.events.isEmpty {
                ScrollView(.vertical) {
                    ForEach(viewModel.events, id: \.self) { event in
                        NavigationLink {
                            EventDetailsScreen()
                        } label: {
                            EventView(event: event)
                        }
                    }
                }
            } else {
                EmptyEventsView(selectedMode: viewModel.selectedMode)
            }
        }
    }
}
