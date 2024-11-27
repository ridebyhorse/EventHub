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
    @StateObject private var dataController = FavoritesDataController()
    let persistenceController = PersistenceController.shared

    init(){
        FirebaseApp.configure()
    }

    
    var body: some Scene {
        WindowGroup {
            MainNavigation(Model: AuthenticationViewModel(favoritesDataController: FavoritesDataController()))
                .environmentObject(navigationManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
