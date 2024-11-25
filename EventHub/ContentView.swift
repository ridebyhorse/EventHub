//
//  ContentView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewRouter = ViewRouter()
    
    var body: some View {
        GeometryReader { geometry in
            let dimensions = TabBarDimensions(geometry: geometry)
            
            VStack {
                Spacer()
                
                // Display content based on the selected tab
                switch viewRouter.currentTab {
                case .explore:
                    ExploreView()
                case .events:
                    EventsScreenView(viewModel: EventsScreenViewModel(events: MockEvent.mockEvents()))
                case .add:
                    Text("Favorites")
                case .map:
                    Text("Map View")
                case .profile:
                    Text("Profile View")
                }
                
                Spacer()
                
                // Custom Tab Bar
                HStack {
                    TabBarIcon(viewRouter: viewRouter,
                               width: dimensions.iconWidth,
                               height: dimensions.iconHeight,
                               tab: .explore, iconName: "explore", tabName: "Explore")
                    
                    TabBarIcon(viewRouter: viewRouter,
                               width: dimensions.iconWidth,
                               height: dimensions.iconHeight,
                               tab: .events, iconName: "calendar", tabName: "Events")
                    
                    CircleButton(viewRouter: viewRouter,
                                 width: dimensions.circleSize,
                                 height: dimensions.circleSize)
                    
                    TabBarIcon(viewRouter: viewRouter,
                               width: dimensions.iconWidth,
                               height: dimensions.iconHeight,
                               tab: .map, iconName: "location", tabName: "Map")
                    
                    TabBarIcon(viewRouter: viewRouter,
                               width: dimensions.iconWidth,
                               height: dimensions.iconHeight,
                               tab: .profile, iconName: "profile", tabName: "Profile")
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 8)
                .background(Color("Bg")
                    .shadow(color: Color(red: 0.61, green: 0.7, blue: 0.84).opacity(0.13), radius: 4, x: 0, y: -3))
            }
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.top)
         
        }
        .environmentObject(viewRouter)
        
    }
}


#Preview {
    ContentView()
}

