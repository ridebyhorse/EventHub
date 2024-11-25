//
//  FavoritesModel.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/22/24.
//


import SwiftUI
import CoreData

class FavoritesDataController: ObservableObject {
    let container: NSPersistentContainer
    private var context: NSManagedObjectContext
    @Published var currentUserEmail: String?

    init() {
        container = NSPersistentContainer(name: "Favorites")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }

    func saveEvent(title: String, date: String, location: String, city: String) {
        guard let email = currentUserEmail else {
            print("No user email found. Cannot save event.")
            return
        }
        
        let event = Event(context: context)
        event.title = title
        event.date = date
        event.location = location
        event.city = city
        event.userEmail = email 
        
        do {
            try context.save()
        } catch {
            print("Failed to save event: \(error)")
        }
    }

    func fetchSavedEvents() -> [Event] {
        guard let email = currentUserEmail else {
            print("No user email found. Returning empty list.")
            return []
        }
        
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", email)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch events: \(error)")
            return []
        }
    }

    func deleteEvent(event: Event) {
        context.delete(event)
        do {
            try context.save()
        } catch {
            print("Failed to delete event: \(error)")
        }
    }
}

enum Buttons {
    static let addFavorite: String = "favorite"
    static let search: String = "favoritesSearch"
}
