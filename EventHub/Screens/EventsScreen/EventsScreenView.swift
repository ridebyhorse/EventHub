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
                            Task {
                                await viewModel.fetchEvents(for: .newYork)
                            }
                        }
                    
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(2)
                        Spacer()
                    } else {
                        if !viewModel.events.isEmpty {
                            ScrollView {
                                ForEach(viewModel.events, id: \.self) { event in
                                    EventView(event: event)
                                }
                            }
                        } else {
                            EmptyEventsView(selectedMode: viewModel.selectedMode)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    
                    NavigationLink {
                        SeeAllEventsScreenView(events: viewModel.events)
                    } label: {
                        ExploreEventsButtonView()
                    }
                    
                }
            }
            .task {
                await viewModel.fetchEvents(for: .newYork)
            }
        }
    }
}
