//
//  IndicatorPageView.swift
//  EventHub
//
//  Created by Roman Golub on 19.11.2024.
//

import SwiftUI

struct IndicatorPageView: View {
    // MARK: - Properties
    @Binding var currentStep: Int
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(0..<3) { item in
                if item == currentStep {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.bg)
                    
                } else {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.bg)
                        .opacity(0.2)
                }
            }
        }
    }
}

#Preview {
    IndicatorPageView(currentStep: .constant(0))
}
