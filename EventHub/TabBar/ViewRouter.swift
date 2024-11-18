//
//  ViewRouter.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentTab: Tab = .explore
}

enum Tab {
    case explore, events, add, map, profile
}
