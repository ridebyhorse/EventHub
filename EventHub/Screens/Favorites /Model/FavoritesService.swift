//
//  FavoriteViewModel.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/28/24.
//
import SwiftUI
import RealmSwift
import FirebaseAuth


class FavoritesService: ObservableObject {
    private var localRealm: Realm?
    @Published private(set) var favorite: [FavoriteItem] = []
    
    init() {
        openRealm()
        getEvent()
    }
    
    private func openRealm() {
        do {
            let  config = Realm.Configuration(
                schemaVersion: 10
            )
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening realm: \(error.localizedDescription)")
        }
    }
    
    func addEventToFavorites(title: String, eventDate: Date, eventLocation: String, eventStatus: EventStatus) {
        guard let localRealm = localRealm else { return }
        
        do {
            let newEvent = FavoriteItem()
            newEvent.title = title
            newEvent.eventDate = eventDate
            newEvent.eventLocation = eventLocation
            newEvent.eventStatus = eventStatus
            
            try localRealm.write {
                localRealm.add(newEvent)
                print(" Event '\(title)' successfully added.")
                getEvent()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getEvent() {
        guard let localRealm = localRealm else { return }
        
        let allFavorites = localRealm.objects(FavoriteItem.self).sorted(byKeyPath: "eventLocation")
        favorite = Array(allFavorites)
    }
    
    func deleteEvent(id: ObjectId) {
        guard let localRealm = localRealm else { return }
        
        do {
            let eventToDelete = localRealm.objects(FavoriteItem.self).filter(NSPredicate(format: "id == %@", id))
            guard !eventToDelete.isEmpty else { return }
            
            try localRealm.write {
                localRealm.delete(eventToDelete)
                getEvent()
                print("Deleted Event with ID \(id)")
            }
        } catch {
            print(error)
        }
    }
}
