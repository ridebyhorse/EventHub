//
//  MapViewScreen.swift
//  EventHub
//
//  Created by Roman Golub on 28.11.2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapViewScreen: View {
    // MARK: - Properties
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = ExploreViewModel()
    
    @State private var text: String = ""
    @State private var showWebView = false
    @State private var webViewURL: URL?
    
    let categoryIcons = ["briefcase.fill", "film.fill", "music.note", "graduationcap.fill", "sparkles", "paintpalette.fill", "tshirt.fill", "party.popper", "sun.max.fill", "figure.child", "questionmark.circle.fill", "camera.fill", "magnifyingglass", "leaf.fill", "cart.fill", "hands.sparkles.fill", "tag.fill", "theatermasks.fill", "map.fill", "gift.fill"]
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                /// Map
                Map(coordinateRegion: $locationManager.mapRegion, annotationItems: locationManager.places) { place -> MapAnnotation<AnyView> in
                    guard let latitude = place.coords?.lat,
                          let longitude = place.coords?.lon,
                          latitude != 0, longitude != 0 else {
                        
                        return MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
                            AnyView(EmptyView())
                        }
                    }
                    
                    let index = locationManager.places.firstIndex(where: { $0.id == place.id }) ?? 0
                    let category = CategoryColor.allCases[index % CategoryColor.allCases.count]
                    let categoryColor = category.color
                    let categoryIcon = categoryIcons[index % categoryIcons.count]
                    
                    return MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                        AnyView(
                            ZStack {
                                /// Action on tap Pin on Map
                                Button(action: {
                                    locationManager.selectedPlace = place
                                    
                                }) {
                                    /// Image Pin
                                    Image("Pin123")
                                        .frame(width: 50, height: 50)
                                        .overlay(
                                            Rectangle()
                                                .foregroundColor(.clear)
                                                .frame(width: 30, height: 30)
                                                .background(categoryColor.opacity(0.8))
                                                .cornerRadius(8)
                                                .offset(x: -10, y: -18)
                                        )
                                        .overlay(
                                            /// Icon Pin
                                            Image(systemName: categoryIcon)
                                                .resizable()
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(.white)
                                                .offset(x: -10, y: -18)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        )
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    locationManager.selectedPlace = nil
                }
                
                VStack {
                    HStack {
                        /// SearchBar
                        SearchBarView(searchText: $locationManager.searchText)
                            .previewLayout(.sizeThatFits)
                        //
                        /// ButtonLocation
                        Button(action: {
                            locationManager.requestLocation()
                            if let location = locationManager.currentLocation {
                                locationManager.mapRegion.center = location
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
                    
                    /// CategoryEvent
                    CategoriesScrollView(viewModel: viewModel)
                        .padding(.top, 12)
                        .padding(.leading, 12)
                    
                    Spacer()
                    
                    if let selectedLocation = locationManager.selectedPlace {
                        VStack {
                            Spacer()
                            
                            /// CardView
                            MapCardView(
                                image: selectedLocation.images?.first?.image,
                                date: selectedLocation.phone ?? "",
                                title: selectedLocation.title ?? "",
                                adress: selectedLocation.address ?? ""
                            )
                            .onTapGesture {
                                if let url = selectedLocation.siteUrl {
                                    webViewURL = url
                                    showWebView = true
                                }
                            }
                            .transition(.move(edge: .bottom))
                            .onTapGesture {
                                locationManager.selectedPlace = nil
                            }
                        }
                        .padding(.bottom, 128)
                        .edgesIgnoringSafeArea(.bottom)
                        .background(
                            NavigationLink(
                                destination: WebViewScreen(urlPage: webViewURL),
                                isActive: $showWebView,
                                label: { EmptyView() }
                            )
                        )
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            
        }
        .onReceive(locationManager.$currentLocation) { location in
            if let location = location {
                locationManager.mapRegion.center = location
            }
        }
        .onAppear {
            viewModel.fetchData(location: locationManager.selectedLocation)
            locationManager.updateMapRegion(for: locationManager.selectedLocation)
            
            if let currentLocation = locationManager.currentLocation {
                locationManager.mapRegion.center = currentLocation
            }
        }
        .task {
            await locationManager.loadAllPlaces(for: locationManager.selectedLocation)
        }
    }
}

#Preview {
    MapViewScreen()
        .environmentObject(LocationManager.shared)
}
