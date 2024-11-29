//
//  FavoriteEventsView.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/27/24.
//
import SwiftUI
import RealmSwift
import FirebaseAuth
struct AddEventView: View {
    @EnvironmentObject var favoritesService: FavoritesService
    @State private var title: String = ""
    let userEmail = Auth.auth().currentUser?.email
    @State private var eventDate: Date = Date()
    @State private var eventLocation: String = ""
    @State private var eventStatus: EventStatus = .pending
    var body: some View {
        
        Form {
            TextField("Event Title", text: $title)
            DatePicker("Event Date", selection: $eventDate, displayedComponents: .date)
            TextField("Event Location", text: $eventLocation)
            Picker("Event Status", selection: $eventStatus) {
                ForEach(EventStatus.allCases, id: \.self) { status in
                    Text(status.rawValue.capitalized)
                }
            }
            Button("Add to Favorites") {
                favoritesService.addEventToFavorites(
                    title: title,
                    eventDate: eventDate,
                    eventLocation: eventLocation,
                    eventStatus: eventStatus
                )
            }
        }
    }
}
#Preview {
    AddEventView()
        .environmentObject(FavoritesService())
}
