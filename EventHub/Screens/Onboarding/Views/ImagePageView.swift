//
//  ImagePageView.swift
//  EventHub
//
//  Created by Roman Golub on 19.11.2024.
//

import SwiftUI

struct ImagePageView: View {
    // MARK: - Properties
    @Binding var currentStep: Int
    @Binding var dragOffset: CGFloat
    
    let itemWidth: CGFloat
    let peekAmount: CGFloat
    let dragThreshold: CGFloat
    
    // MARK: - Body
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: peekAmount - 2) {
                    ForEach(0..<onboardingPageMock.count) { item in
                        VStack {
                            Image(onboardingPageMock[item].image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: itemWidth, height: 475)
                                .padding(.top, 80)
                                .scaleEffect(self.scaleValueForItem(at: item, in: geometry))
                        }
                    }
                    .offset(x: calculateOffset() + dragOffset + 56)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.interactiveSpring()) {
                                    dragOffset = value.translation.width
                                }
                            }
                            .onEnded { value in
                                withAnimation(.interactiveSpring()) {
                                    finalizePosition(dragValue: value)
                                    dragOffset = 0
                                }
                            }
                    )
                }
            }
            
            // BottomRectangle
            VStack {
                Rectangle()
                    .fill(Color.mainBlue)
                    .frame(height: 288)
                    .background(.blue)
                    .cornerRadius(48)
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Methods
    // Function for calculating offset
    func calculateOffset() -> CGFloat {
        let totalWidth = itemWidth + peekAmount
        let baseOffset = -CGFloat(currentStep) * totalWidth
        return baseOffset
    }
    
    // Scale the current element
    func scaleValueForItem(at index: Int, in geometry: GeometryProxy) -> CGFloat {
        let currentItemOffset = calculateOffset() + dragOffset
        let itemPosition = CGFloat(index) * (itemWidth + peekAmount) + currentItemOffset
        let distanceFromCenter = abs(geometry.size.width / 2.7 - itemPosition - itemWidth / 2)
        let scale: CGFloat = 1 + (0.5 * (0.14 - min(1, distanceFromCenter / (itemWidth + peekAmount))))
        return scale
    }
    
    // Finish scrolling
    func finalizePosition(dragValue: DragGesture.Value) {
        if dragValue.predictedEndTranslation.width > dragThreshold && currentStep > 0 {
            currentStep -= 1
        } else if dragValue.predictedEndTranslation.width < -dragThreshold && currentStep < onboardingPageMock.count - 1 {
            currentStep += 1
        }
    }
}
