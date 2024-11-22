//
//  EventHubApp.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI
import Firebase
@main
struct EventHubApp: App {
    let persistenceController = PersistenceController.shared
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
