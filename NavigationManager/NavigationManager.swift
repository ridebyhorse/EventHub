//
//  NavigationHandler.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/20/24.


import SwiftUI

enum NavigationDestination {
    case signIn
    case signUp
    case contentView
    case resetPassword
    case main
//    case eventDetail
//    case events
//    case search
}

@MainActor
class NavigationManager: ObservableObject {
    @Published var currentDestination: NavigationDestination = .signIn
}