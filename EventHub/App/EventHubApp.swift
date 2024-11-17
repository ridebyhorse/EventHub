//
//  EventHubApp.swift
//  EventHub
//
//  Created by Мария Нестерова on 17.11.2024.
//

import SwiftUI

@main
struct EventHubApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
