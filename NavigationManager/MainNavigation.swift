//
//  MainNavigation.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/20/24.
//

import SwiftUI

struct MainNavigation: View {
    @StateObject private var navigationManager = NavigationManager()
    @ObservedObject var Model: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch navigationManager.currentDestination {
                case .signIn:
                    SignInView(Model: Model)
                        .environmentObject(navigationManager)
                case .signUp:
                    SignUpView(Model: Model)
                        .environmentObject(navigationManager)
                case .contentView:
                    ContentView()
                        .environmentObject(navigationManager)
                case .resetPassword:
                    ResetPasswordView(Model: Model)
                        .environmentObject(navigationManager)
                case .main:
                    ContentView()
                        .environmentObject(navigationManager)
//                case .events:
//                    EventView(event: MockEvent())
//                        .environmentObject(navigationManager)
//                case .eventDetail:
//                    EventDetailsScreen(eventID: "1")
//                        .environmentObject(navigationManager)
//                case .search:
//                    SearchView()
//                        .environmentObject(navigationManager)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
