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
                    SignInView(viewModel: Model)
                        
                case .signUp:
                    SignUpView(Model: Model)
                        
                case .resetPassword:
                    ResetPasswordView(Model: Model)
                    
                case .main:
                    ContentView()
                       
                case .explore:
                    ExploreView()
                
                case .favorites:
                    FavoritesView()
                    
                case .search:
                    SearchView(viewModel: SearchViewModel(location: .msk))
                }
            }
           
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(navigationManager)
    }
}
