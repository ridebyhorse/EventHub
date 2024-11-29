//
//  EventsScreenView.swift
//  EventHub
//
//  Created by Иван Семикин on 18/11/2024.
//

import SwiftUI

struct EventsScreenView: View {
    @ObservedObject var viewModel = EventsScreenViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("Events")
                        .font(.title)
                    
                    ChangeModeButtonsView(choosedMode: $viewModel.selectedMode)
                        .onChange(of: viewModel.selectedMode) { _ in
                            viewModel.updateDisplayedEvents()
                        }
                    
                    ScrollEventsView(viewModel: viewModel)
                }
                
                ExploreEventsButtonView(viewModel: viewModel)
            }
            .task {
                await viewModel.loadAllEvents(for: .newYork)
            }
        }
    }
}

#Preview {
    EventsScreenView(viewModel: EventsScreenViewModel())
}
