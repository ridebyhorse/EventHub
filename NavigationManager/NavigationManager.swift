//
//  NavigationHandler.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/20/24.


import SwiftUI

enum NavigationDestination {
    case signIn
    case signUp
    case resetPassword
    case main
    case explore
    case favorites
    case search
}

@MainActor
class NavigationManager: ObservableObject {
    
    
    @Published var isPresented: Bool = false
    @Published var currentDestination: NavigationDestination = .signIn
}
