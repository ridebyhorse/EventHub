//
//  ExampleView.swift
//  EventHub
//
//  Created by Roman Golub on 28.11.2024.
//

import SwiftUI

struct ExampleView: View {
    @StateObject var locationManager = LocationManager.shared
    
    var body: some View {
        TabView {
            MapViewScreen()
                .environmentObject(locationManager)
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            
            ExploreView()
                .environmentObject(locationManager)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
        }
    }
}

#Preview {
    ExampleView()
}
