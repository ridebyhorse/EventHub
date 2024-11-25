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
        NavigationView {
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
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

// MARK: - Section View
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
                        NavigationLink(destination: EventDetailsScreen()) {
                            CardView(
                                eventTitle: event.title,
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
        .shadow(color: Color(red: 0.31, green: 0.33, blue: 0.53).opacity(0.06), radius: 15, x: 0, y: 8)
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "N/A" }
        
        // Определяем словарь сокращений месяцев
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
        
        // Форматируем дату
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM" // Пример: 1 January
        let formattedDate = formatter.string(from: date)
        
        // Заменяем месяц на сокращенный
        for (full, abbreviated) in monthAbbreviations {
            if formattedDate.contains(full) {
                return formattedDate.replacingOccurrences(of: full, with: abbreviated)
            }
        }
        
        return formattedDate // Если сокращения не нашлись
    }
}
