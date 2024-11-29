//
//  FavoriteItem.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/27/24.
//

import SwiftUI
import RealmSwift
class FavoriteItem: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var eventDate: Date = Date()
    @Persisted var eventLocation: String = ""
    @Persisted var email: String = ""
    @Persisted var eventStatus: EventStatus = .pending
}
enum EventStatus: String, PersistableEnum {
    case missed = "Missed"
    case attended = "Attended"
    case pending = "Pending"
}
