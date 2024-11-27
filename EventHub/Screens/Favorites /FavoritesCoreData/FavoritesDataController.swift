//
//  FavoritesModel.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/22/24.
//

import SwiftUI
import CoreData
import CoreData


class FavoritesDataController: ObservableObject {
    let container: NSPersistentContainer
    private var context: NSManagedObjectContext
    @Published var currentUserEmail: String?

    init(){
        container = NSPersistentContainer(name: "Favorites")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }

    func saveEvent(id: Int, userEmail: String) {
        let event = Event(context: context)
        event.id = Int64(id)
        event.userEmail = userEmail
        do {
            try context.save()
        } catch {
            print("Failed to save event: \(error)")
        }
    }

    func fetchSavedEvents(for userEmail: String) -> [Int] {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", userEmail)
        do {
            let savedEvents = try context.fetch(fetchRequest)
            return savedEvents.map { Int($0.id) }
        } catch {
            print("Failed to fetch events: \(error)")
            return []
        }
    }

    func deleteEvent(withId id: Int, for userEmail: String) {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d AND userEmail == %@", id, userEmail)
        do {
            let eventsToDelete = try context.fetch(fetchRequest)
            for event in eventsToDelete {
                context.delete(event)
            }
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
