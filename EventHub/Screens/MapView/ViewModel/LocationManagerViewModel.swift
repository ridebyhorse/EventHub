//
//  LocationManagerViewModel.swift
//  EventHub
//
//  Created by Roman Golub on 28.11.2024.
//

import SwiftUI
import CoreLocation
import MapKit

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private let networkService = NetworkService.shared
    
    @Published var selectedEventImage: URL?
    @Published var searchText = ""
    @Published var isLoading: Bool = false
    @Published var places: [PlaceModel] = []
    @Published var searchPlace: [SearchEventModel] = []
    @Published var events: [EventModel] = []
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var mapRegion: MKCoordinateRegion
    @Published var selectedLocation: Location = .spb {
        didSet {
            updateMapRegion(for: selectedLocation)
        }
    }
    
    @Published var selectedPlace: PlaceModel? {
        didSet {
            updateSelectedEventImage()
        }
    }
    
    override init() {
        self.authorizationStatus = locationManager.authorizationStatus
        self.mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        updateMapRegion(for: selectedLocation)
    }
    
    // MARK: - Methods
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            DispatchQueue.main.async {
                self.currentLocation = location.coordinate
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Не удалось получить местоположение: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
        }
    }
    
    func updateMapRegion(for location: Location) {
        mapRegion = MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
    
    func loadAllPlaces(for location: Location) async {
        isLoading = true
        defer { isLoading = false }
        
        await fetchPlaces(for: location)
    }
    
    func fetchPlaces(for location: Location) async {
        do {
            let placesModel = try await networkService.getPlaces(location: location)
            places = placesModel.results
            //            print("Загружено -------------> \(self.places)")
        } catch {
            //            print("Ошибка при загрузке предстоящих событий: \(error.localizedDescription)")
            places = []
        }
    }
    
    func fetchPlacesSearch(for location: Location) async {
        do {
            let searchPlaceModel = try await networkService.searchEvents(location: location, search: searchText)
            if let results = searchPlaceModel.results {
                searchPlace = results
            } else {
                searchPlace = []
            }
        } catch {
            searchPlace = []
        }
    }
    
    func findEvent(for place: PlaceModel, in events: [EventModel]) -> EventModel? {
        return events.first { $0.place?.id == place.id }
    }
    func updateSelectedEventImage() {
        if let selectedPlace = selectedPlace,
           let event = findEvent(for: selectedPlace, in: events),
           let firstImage = event.images.first?.image {
            selectedEventImage = firstImage
        } else {
            selectedEventImage = nil
        }
    }
    func fetchEvent(for location: Location) async {
        do {
            let eventModel = try await networkService.getEvents(type: .upcoming, location: location)
            events = eventModel.results
            //            print("Загружено +++++++++++++++++++> \(self.events)")
        } catch {
            //            print("Ошибка при загрузке предстоящих событий: \(error.localizedDescription)")
            events = []
        }
    }
}
