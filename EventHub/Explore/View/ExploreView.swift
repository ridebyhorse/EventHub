//
//  ExploreView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//


import SwiftUI

struct ExploreView: View {
    
    var body: some View {
//        NavigationView {
            ZStack(alignment: .top) {
                
                    VStack(alignment: .leading, spacing: 10){
                        // MARK: - Header
                        HeaderView()
                            .frame(alignment: .top)
                            .ignoresSafeArea()
                        // MARK: - Categories
                        CategoriesScrollView()
                            .padding(.top, -30)
                        // MARK: - Upcoming events
                        ScrollView(.vertical, showsIndicators: false ){
                        HStack{
                            Text("Upcoming Events")
                                .font(.title2)
                            Spacer()
                            Button(action:{
                                print("see all button pressed")
                            }){
                                Text("See All")
                                    .font(.title2)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.53))
                            }
                        }
                        .padding(.horizontal, 16)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<5, id: \.self) { index in
                                    CardView(
                                        eventTitle: "International Band Music Festival",
                                        eventDate: "10 JUNE",
                                        attendees: ["person1", "person2", "person3", "person4"],
                                        goingCount: 20,
                                        location: "36 Guild Street London, UK",
                                        eventImage: "event_image"
                                    )
                                }
                            }
                        }
                        // MARK: - Nearby you
                        HStack{
                            Text("Nearby you")
                                .font(.title2)
                            Spacer()
                            Button(action:{
                                print("see all button pressed")
                            }){
                                Text("See All")
                                    .font(.title2)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.53))
                            }
                        }
                        .padding(.horizontal, 16)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<5, id: \.self) { index in
                                    CardView(
                                        eventTitle: "International Band Music Festival",
                                        eventDate: "10 JUNE",
                                        attendees: ["person1", "person2", "person3", "person4"],
                                        goingCount: 20,
                                        location: "36 Guild Street London, UK",
                                        eventImage: "event_image"
                                    )
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
//        }
        .ignoresSafeArea()
    }
}
