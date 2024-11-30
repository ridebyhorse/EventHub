//
//  CustomMapAnnotation.swift
//  EventHub
//
//  Created by Roman Golub on 26.11.2024.
//

import CoreLocation

struct CustomMapAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let imageName: String
}

struct MockLocationItem: Identifiable {
    var id = UUID()
    var title: String
    var place: String
    var coordinate: CLLocationCoordinate2D
    var photo: String
}

let mockLocations: [MockLocationItem] = [
    // Kyiv
    MockLocationItem(
        title: "Maidan Nezalezhnosti",
        place: "Kyiv Center",
        coordinate: CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234),
        photo: "square.and.pencil"
    ),
    MockLocationItem(
        title: "Kyiv Pechersk Lavra",
        place: "Pechersk",
        coordinate: CLLocationCoordinate2D(latitude: 50.4294, longitude: 30.5193),
        photo: "building.columns"
    ),
    MockLocationItem(
        title: "Andriivskyi Descent",
        place: "Podil",
        coordinate: CLLocationCoordinate2D(latitude: 50.4608, longitude: 30.5114),
        photo: "map.fill"
    ),
    MockLocationItem(
        title: "Golden Gate",
        place: "Kyiv Center",
        coordinate: CLLocationCoordinate2D(latitude: 50.4483, longitude: 30.5167),
        photo: "lock.fill"
    ),
    // New York
    MockLocationItem(
        title: "Statue of Liberty",
        place: "New York",
        coordinate: CLLocationCoordinate2D(latitude: 40.6892, longitude: -74.0445),
        photo: "figure.stand"
    ),
    MockLocationItem(
        title: "Central Park",
        place: "Manhattan",
        coordinate: CLLocationCoordinate2D(latitude: 40.7851, longitude: -73.9683),
        photo: "leaf.fill"
    ),
    MockLocationItem(
        title: "Times Square",
        place: "Manhattan",
        coordinate: CLLocationCoordinate2D(latitude: 40.7580, longitude: -73.9855),
        photo: "sparkles"
    ),
    // Moscow
    MockLocationItem(
        title: "Red Square",
        place: "Moscow",
        coordinate: CLLocationCoordinate2D(latitude: 55.7539, longitude: 37.6208),
        photo: "square.fill"
    ),
    MockLocationItem(
        title: "Bolshoi Theatre",
        place: "Moscow",
        coordinate: CLLocationCoordinate2D(latitude: 55.7601, longitude: 37.6182),
        photo: "music.note.house.fill"
    ),
    MockLocationItem(
        title: "Gorky Park",
        place: "Moscow",
        coordinate: CLLocationCoordinate2D(latitude: 55.7284, longitude: 37.6010),
        photo: "tree.fill"
    ),
    // Saint Petersburg
    MockLocationItem(
        title: "Hermitage Museum",
        place: "Saint Petersburg",
        coordinate: CLLocationCoordinate2D(latitude: 59.9398, longitude: 30.3146),
        photo: "paintpalette.fill"
    ),
    MockLocationItem(
        title: "Saint Isaac's Cathedral",
        place: "Saint Petersburg",
        coordinate: CLLocationCoordinate2D(latitude: 59.9343, longitude: 30.3061),
        photo: "building.fill"
    ),
    MockLocationItem(
        title: "Peter and Paul Fortress",
        place: "Saint Petersburg",
        coordinate: CLLocationCoordinate2D(latitude: 59.9502, longitude: 30.3178),
        photo: "shield.fill"
    ),
    // Yekaterinburg
    MockLocationItem(
        title: "Plotinka",
        place: "Yekaterinburg",
        coordinate: CLLocationCoordinate2D(latitude: 56.8392, longitude: 60.6093),
        photo: "wave.3.forward"
    ),
    MockLocationItem(
        title: "Central Stadium",
        place: "Yekaterinburg",
        coordinate: CLLocationCoordinate2D(latitude: 56.8321, longitude: 60.5736),
        photo: "sportscourt.fill"
    ),
    MockLocationItem(
        title: "Yekaterinburg Circus",
        place: "Yekaterinburg",
        coordinate: CLLocationCoordinate2D(latitude: 56.8362, longitude: 60.6034),
        photo: "tent.fill"
    )
]
