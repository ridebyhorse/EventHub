//
//  EventHubApp.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
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
