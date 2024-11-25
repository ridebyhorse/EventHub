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
        let event = Event(context: context)
        event.title = title
        event.date = date
        event.location = location
        event.city = city
        
        do {
            try context.save()
        } catch {
            print("Failed to save event: \(error)")
        }
    }

    
    func fetchSavedEvents() -> [Event] {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        
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
