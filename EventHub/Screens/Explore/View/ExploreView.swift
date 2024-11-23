//
//  ExploreView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//


import SwiftUI

struct ExploreView: View {
    @StateObject var viewModel = ExploreViewModel()
    @State private var selectedLocation: Location = .newYork
    
    var body: some View {
//        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10){
                    // MARK: - Header
                    HeaderView(selectedLocation: $selectedLocation)
                        .onChange(of: selectedLocation) { newLocation in
                            viewModel.fetchData(location: newLocation)
                        }
                        .frame(height: 200, alignment: .top)
                        .ignoresSafeArea()
                    // MARK: - Categories
                    CategoriesScrollView()
                        .padding(.top, -30)
                    // MARK: - Upcoming events
                    ScrollView(.vertical, showsIndicators: false ){
                        SectionView(
                            title: "Upcoming Events",
                            events: viewModel.upcomingEvents
                        )
                        
                        // MARK: - Nearby Events
                        SectionView(
                            title: "Nearby You",
                            events: viewModel.nearbyEvents
                        )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 10)
                }
            }
            .onAppear {
                viewModel.fetchData(location: selectedLocation)
            }
//            .navigationBarHidden(true)
//            .navigationBarTitleDisplayMode(.inline)
//                    }
        .ignoresSafeArea()
        }
    }

    
    struct SectionView: View {
        let title: String
        let events: [EventModel]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(title)
                        .font(.title2)
                    Spacer()
                    Button(action: {
                        print("\(title) See All pressed")
                    }) {
                        Text("See All")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                    }
                }
                .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(events, id: \.id) { event in
                            CardView(
                                eventTitle: event.title,
                                eventDate: formatDate(event.dates.first?.start),
                                attendees: [], // Mock attendees
                                goingCount: event.favoritesCount,
                                location: event.location.slug.rawValue,
                                eventImage: event.images.first?.image?.absoluteString ?? ""
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .shadow(color: Color(red: 0.31, green: 0.33, blue: 0.53).opacity(0.06), radius: 15, x: 0, y: 8)
        }
        private func formatDate(_ date: Date?) -> String {
            guard let date = date else { return "N/A" }
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM" // День и месяц
            return formatter.string(from: date)
        }
    }
