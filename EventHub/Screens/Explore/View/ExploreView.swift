//
//  ExploreView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//


import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var locationViewModel: LocationManager
    @StateObject var viewModel = ExploreViewModel()
    @State private var selectedLocation: Location = .newYork
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10){
                    // MARK: - Header
                    HeaderView(selectedLocation: $locationViewModel.selectedLocation)
                        .onChange(of: locationViewModel.selectedLocation) { newLocation in
                            viewModel.fetchData(location: newLocation)
                            locationViewModel.updateMapRegion(for: newLocation)
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
                viewModel.fetchData(location: locationViewModel.selectedLocation)
                locationViewModel.updateMapRegion(for: locationViewModel.selectedLocation)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .ignoresSafeArea()
    }
}

// MARK: - Section View
struct SectionView: View {
    let title: String
    let events: [EventModel]
    let noEventsMessage: String
    
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
                                CardView(
                                    eventTitle: event.title.capitalizingFirstLetter(),
                                    eventDate: formatDate(event.dates.first?.start),
                                    attendees: ["https://example.com/avatar1.jpg", "https://example.com/avatar2.jpg", "https://example.com/avatar3.jpg"],
                                    goingCount: event.favoritesCount,
                                    location: event.location.slug.displayName,
                                    eventImage: event.images.first?.image?.absoluteString ?? ""
                                )
                            }
                        }
                    }
                }
            }
        }
        .shadow(color: Color(red: 0.31, green: 0.33, blue: 0.53).opacity(0.06), radius: 15, x: 0, y: 8)
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
        .environmentObject(LocationManager())
}
