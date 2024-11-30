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

struct FavoriteItemModel {
    let id: ObjectId
    let title: String
    let eventDate: Date
    let eventLocation: String
    let email: String
    let eventStatus: EventStatus
}

extension FavoriteItem {
    convenience init(_ dto: FavoriteItemModel) {
        self.init()
        id = dto.id
        title = dto.title
        eventDate = dto.eventDate
        eventLocation = dto.eventLocation
        email = dto.email
        eventStatus = dto.eventStatus
    }
}

extension FavoriteItemModel {
    init(object: FavoriteItem) {
        id = object.id
        title = object.title
        eventDate = object.eventDate
        eventLocation = object.eventLocation
        email = object.email
        eventStatus = object.eventStatus
    }
}
