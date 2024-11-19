//
//  OnboardingPageModel.swift
//  EventHub
//
//  Created by Roman Golub on 19.11.2024.
//

import Foundation

// MARK: - OnboardingPageModel
struct OnboardingPageModel: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var description: String
}

// MARK: - Mock Data
let onboardingPageMock: [OnboardingPageModel] = [
    OnboardingPageModel(image: "1", title: "Explore Upcoming and Nearby Events", description: "In publishing and graphic design, Lorem is a placeholder text commonly"),
    OnboardingPageModel(image: "2", title: "Web Have Modern Events Calendar Feature", description: "In publishing and graphic design, Lorem is a placeholder text commonly"),
    OnboardingPageModel(image: "3", title: "To Look Up More Events or Activities Nearby By Map", description: "In publishing and graphic design, Lorem is a placeholder text commonly")
]
