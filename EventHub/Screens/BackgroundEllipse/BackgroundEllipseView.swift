//
//  BackgroundEllipseView.swift
//  EventHub
//
//  Created by Roman Golub on 19.11.2024.
//

import SwiftUI

struct BackgroundEllipseView: View {
    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
            
            EllipseViewTop()
                .offset(x: 80, y: -420)
            
            EllipseViewBottomRight()
                .offset(x: 260, y: 240)
            
            EllipseViewBottomLeft()
                .offset(x: -200, y: 350)
            
        }
    }
}

#Preview {
    BackgroundEllipseView()
}
