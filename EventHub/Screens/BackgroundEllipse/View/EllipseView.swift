//
//  EllipseView.swift
//  EventHub
//
//  Created by Roman Golub on 19.11.2024.
//

import SwiftUI

// MARK: - EllipseViewBottomRight
struct EllipseViewBottomRight: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 349, height: 322)
                .background(
                    AngularGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.73, green: 0.85, blue: 0.98).opacity(0.5), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.93, green: 0.67, blue: 0.68).opacity(0.5), location: 0.27),
                            Gradient.Stop(color: Color(red: 0.6, green: 0.58, blue: 0.93).opacity(0.5), location: 0.57),
                            Gradient.Stop(color: Color(red: 0.56, green: 0.64, blue: 0.97).opacity(0.5), location: 0.81),
                            Gradient.Stop(color: Color(red: 0.77, green: 0.33, blue: 0.57).opacity(0.5), location: 1.00),
                        ],
                        center: UnitPoint(x: 0.5, y: 0.5),
                        angle: Angle(degrees: 320)
                    )
                )
                .cornerRadius(349)
                .blur(radius: 50)
                .opacity(0.5)
        }
    }
}

// MARK: - EllipseViewBottomLeft
struct EllipseViewBottomLeft: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 166, height: 153)
                .background(
                    AngularGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.73, green: 0.85, blue: 0.98).opacity(0.5), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.93, green: 0.67, blue: 0.68).opacity(0.5), location: 0.27),
                            Gradient.Stop(color: Color(red: 0.6, green: 0.58, blue: 0.93).opacity(0.5), location: 0.57),
                            Gradient.Stop(color: Color(red: 0.56, green: 0.64, blue: 0.97).opacity(0.5), location: 0.81),
                            Gradient.Stop(color: Color(red: 0.77, green: 0.33, blue: 0.57).opacity(0.5), location: 1.00),
                        ],
                        center: UnitPoint(x: 0.5, y: 0.5),
                        angle: Angle(degrees: 90)
                    )
                )
                .blur(radius: 50)
                .opacity(0.5)
        }
    }
}

// MARK: - EllipseViewTop
struct EllipseViewTop: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 227, height: 209)
                .background(
                    AngularGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.73, green: 0.85, blue: 0.98).opacity(0.4), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.6, green: 0.58, blue: 0.93).opacity(0.4), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.77, green: 0.33, blue: 0.57).opacity(0.4), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.93, green: 0.67, blue: 0.68).opacity(0.4), location: 0.27),
                        ],
                        center: UnitPoint(x: 0.5, y: 0.5),
                        angle: Angle(degrees: 90)
                    )
                )
                .blur(radius: 50)
                .opacity(0.5)
        }
    }
}

#Preview {
    EllipseViewBottomRight()
}
