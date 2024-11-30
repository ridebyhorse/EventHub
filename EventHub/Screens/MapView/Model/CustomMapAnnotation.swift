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
