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
//    @State private var annotations: [CustomMapAnnotation] = []
    @State private var mapRegion: MKCoordinateRegion
    
    init(location: Location = .msk) {
        _mapRegion = State(initialValue: MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ))
    }
    
    
    var body: some View {
        
        ZStack {
                        Map(coordinateRegion: $mapRegion)
//            Map(coordinateRegion: $mapRegion, annotationItems: annotations) { annotation in
//                MapAnnotation(coordinate: annotation.coordinate) {
//                    VStack {
//                        Image(systemName: annotation.imageName)
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .background(.red)
//                            .clipShape(Circle())
//                            .shadow(radius: 5)
//                    }
//                }
//            }
//            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    //                    /// SearchBar
                    //                    SearchBarView(searchText: $text)
                    //                        .previewLayout(.sizeThatFits)
                    //                    
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
                
                //                EventView(
                //                    event: MockEvent(
                //                        image: "MockEventImage",
                //                        title: "Jo Malone London’s Mother’s Day Presents ",
                //                        date: .now,
                //                        locationName: "Radius Gallery",
                //                        city: "Santa Cruz, CA",
                //                        state: "CA",
                //                        isUpcoming: true
                //                    )
                //                )
                //                .padding(.bottom, 128)
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
    MapViewScreen()
}
