//
//  OnboardingScreen.swift
//  EventHub
//
//  Created by Roman Golub on 19.11.2024.
//

import SwiftUI

struct OnboardingScreen: View {
    // MARK: - Properties
    @State private var currentStep = 0
    @State private var isSignInActive = false
    @State private var isSignIFullScreenActive = false
    @State private var dragOffset: CGFloat = 0
    
    private let itemWidth: CGFloat = 288
    private let peekAmount: CGFloat = 20
    private let dragThreshold: CGFloat = 0
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            
            ZStack {
                // ImagePageView
                ImagePageView(currentStep: $currentStep, dragOffset: $dragOffset, itemWidth: itemWidth, peekAmount: peekAmount, dragThreshold: dragThreshold)
                
                VStack {
                    Spacer()
                    ZStack {
                        VStack {
                            // TextContent
                            TextPageView(
                                title: onboardingPageMock[currentStep].title,
                                description: onboardingPageMock[currentStep].description
                            )
                            .padding(.bottom, 64)
                            
                            // Skip PageIndicator Next
                            HStack(alignment: .center) {
                                // ActionButton Skip
                                ActionButtonPageView(buttonText: "Skip") {
                                    isSignIFullScreenActive = true
                                }
                                .opacity(0.5)
                                .frame(height: 50)
                                .fullScreenCover(isPresented: $isSignIFullScreenActive, content: {
                                    // SignInView
                                })
                                
                                Spacer()
                                
                                // PageIndicator
                                IndicatorPageView(currentStep: $currentStep)
                                    .frame(height: 50)
                                
                                Spacer()
                                
                                // ActionButton Next
                                ActionButtonPageView(buttonText: "Next") {
                                    if currentStep < 2 {
                                        withAnimation(.easeInOut) {
                                            currentStep += 1
                                        }
                                    } else {
                                        isSignInActive = true
                                    }
                                }
                                .frame(height: 50)
                                .background(
                                    NavigationLink(
                                        /// change EventsScreenView on SignIn
                                        destination: EventsScreenView(viewModel: EventsScreenViewModel(events: MockEvent.mockEvents())),
                                        isActive: $isSignInActive,
                                        label: { EmptyView() }
                                    )
                                )
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, 68)
                            .frame(maxHeight: 50)
                            
                        }
                        
                    }
                }
                .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingScreen()
}
