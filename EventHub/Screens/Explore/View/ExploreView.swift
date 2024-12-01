//
//  ExploreView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//


import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = ExploreViewModel()
    @State private var selectedLocation: Location = .newYork
    @State private var favoriteEventIDs: Set<Int> = []
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10){
                    // MARK: - Header
                    HeaderView(selectedLocation: $locationManager.selectedLocation)
                        .onChange(of: locationManager.selectedLocation) { newLocation in
                            viewModel.fetchData(location: newLocation)
                            locationManager.updateMapRegion(for: newLocation)
                        }
                        .frame(height: 200, alignment: .top)
                        .ignoresSafeArea()
                    
                    // MARK: - Categories
                    CategoriesScrollView(viewModel: viewModel)
                        .padding(.top, -30)
                    
                    // MARK: - Upcoming events
                    ScrollView(.vertical, showsIndicators: false ){
                        SectionView(
                            title: "Upcoming Events",
                            events: viewModel.selectedCategory == nil ? viewModel.upcomingEvents : viewModel.filteredUpcomingEvents,
                            noEventsMessage: viewModel.selectedCategory == nil ? "" : "Sorry, there are no Upcoming Events available in \(viewModel.selectedCategory?.name ?? "") category."
                        )
                        
                        // MARK: - Nearby Events
                        SectionView(
                            title: "Nearby You",
                            events: viewModel.selectedCategory == nil ? viewModel.nearbyEvents : viewModel.filteredNearbyEvents,
                            noEventsMessage: viewModel.selectedCategory == nil ? "" : "Sorry, there are no Nearby Events available in \(viewModel.selectedCategory?.name ?? "") category."
                        )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 10)
                }
            }
            .ignoresSafeArea(edges: .top)
            .onAppear {
                viewModel.fetchData(location: locationManager.selectedLocation)
                locationManager.updateMapRegion(for: locationManager.selectedLocation)
            }
            .onReceive(NotificationCenter.default.publisher(for: .favoritesChanged)) { _ in
                favoriteEventIDs = Set(FavoriteService.shared.getFavoriteEventIDs())
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Section View
import SwiftUI

import SwiftUI

struct SectionView: View {
    let title: String
    let events: [EventModel]
    let noEventsMessage: String
    @State private var showSeeAllScreen: Bool = false
    @State private var refreshToggle = false
    @State private var favoriteEventIDs: Set<Int> = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .font(.title2)
                Spacer()
                Button(action: {
                    print("\(title) See All pressed")
                    showSeeAllScreen = true
                }) {
                    Text("See All")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                }
                .background(
                    NavigationLink(
                        destination: SeeAllEventsScreenView(viewModel: EventsScreenViewModel()),
                        isActive: $showSeeAllScreen,
                        label: { EmptyView() }
                    )
                )
            }
            .padding(.horizontal, 16)
            
            if events.isEmpty {
                Text(noEventsMessage)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(events, id: \.id) { event in
                            NavigationLink(destination: EventDetailsScreen(event: event)) {
                                let isFavorite = favoriteEventIDs.contains(event.id)
                                
                                CardView(
                                    eventTitle: event.title.capitalizingFirstLetter(),
                                    eventDate: formatDate(event.dates.first?.start),
                                    attendees: ["https://example.com/avatar1.jpg", "https://example.com/avatar2.jpg", "https://example.com/avatar3.jpg"],
                                    goingCount: event.favoritesCount,
                                    location: event.location.slug.displayName,
                                    eventImage: event.images.first?.image?.absoluteString ?? "",
                                    isFavorite: isFavorite,
                                    onFavoriteToggle: {
                                        toggleFavorite(for: event)
                                    }
                                )
                            }
                        }
                    }
                }
            }
        }
        .shadow(color: Color(red: 0.31, green: 0.33, blue: 0.53).opacity(0.06), radius: 15, x: 0, y: 8)
        .onAppear {
            favoriteEventIDs = Set(FavoriteService.shared.getFavoriteEventIDs())
        }
        .onReceive(NotificationCenter.default.publisher(for: .favoritesChanged)) { _ in
            favoriteEventIDs = Set(FavoriteService.shared.getFavoriteEventIDs())
        }
        .onChange(of: refreshToggle) { _ in }
    }
    
    private func toggleFavorite(for event: EventModel) {
        if favoriteEventIDs.contains(event.id) {
            FavoriteService.shared.removeFavoriteEventID(event.id)
        } else {
            FavoriteService.shared.addFavoriteEventID(event.id)
        }
    }
    
    // MARK: - Date Formatter
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        
        let monthAbbreviations: [String: String] = [
            "January": "Jan",
            "February": "Feb",
            "March": "Mar",
            "April": "Apr",
            "May": "May",
            "June": "Jun",
            "July": "Jul",
            "August": "Aug",
            "September": "Spt",
            "October": "Oct",
            "November": "Nvm",
            "December": "Dec"
        ]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        let formattedDate = formatter.string(from: date)
        
        for (full, abbreviated) in monthAbbreviations {
            if formattedDate.contains(full) {
                return formattedDate.replacingOccurrences(of: full, with: abbreviated)
            }
        }
        
        return formattedDate
    }
}

#Preview {
    ExploreView()
        .environmentObject(LocationManager.shared)
}
