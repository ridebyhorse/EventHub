//
//  EventHubApp.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI
import Firebase
import CoreData
@main
struct EventHubApp: App {
    
    var navigationManager = NavigationManager()
    let persistenceController = PersistenceController.shared

    init(){
        FirebaseApp.configure()
    }

    
    var body: some Scene {
        WindowGroup {
            MainNavigation(Model: AuthenticationViewModel(favoritesItem: FavoriteItem()))
                .environmentObject(navigationManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
