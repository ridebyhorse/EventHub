//
//  MapViewScreen.swift
//  EventHub
//
//  Created by Roman Golub on 25.11.2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapViewScreen: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.61662499999999, longitude: 37.68393099999999), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @Binding var text: String
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $mapRegion)
            
            VStack {
                HStack {
                    /// SearchBar
                    SearchBarView()
                        .previewLayout(.sizeThatFits)
                    
                    /// ButtonLocation
                    Button(action: {
                        locationManager.requestLocation()
                        if let location = locationManager.currentLocation {
                            mapRegion.center = location
                        }
                    }) {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .frame(width: 51, height: 51)
                            .shadow(color: Color(red: 0.83, green: 0.82, blue: 0.85).opacity(0.5), radius: 30, x: 0, y: 40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.93, green: 0.93, blue: 0.93), lineWidth: 1)
                            )
                            .overlay(
                                Image("locationMap")
                                    .frame(width: 16, height: 16)
                            )
                    }
                    .padding(.leading, 8)
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 25)
                .padding(.top, 80)
                
                Spacer()
                
                EventView(
                    event: MockEvent(
                        image: "MockEventImage",
                        title: "Jo Malone London’s Mother’s Day Presents ",
                        date: .now,
                        locationName: "Radius Gallery",
                        city: "Santa Cruz, CA",
                        state: "CA",
                        isUpcoming: true
                    )
                )
                .padding(.bottom, 128)
            }
            //            .padding(.top, 45)
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .onReceive(locationManager.$currentLocation) { location in
            if let location = location {
                mapRegion.center = location
            }
        }
    }
}

#Preview {
    MapViewScreen(text: .constant("asdasd"))
}
