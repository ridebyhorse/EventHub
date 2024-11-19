//
//  CircleButton.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI

struct CircleButton: View {
    @ObservedObject var viewRouter: ViewRouter
    let width: CGFloat
    let height: CGFloat
    
    private var iconSize: CGFloat {
        min(width, height) * 0.4
    }

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(viewRouter.currentTab == .add ? Color("MainRed") : Color("MainBlue"))
                .frame(width: width, height: height)
                .shadow(color: Color(red: 0.29, green: 0.26, blue: 0.93).opacity(0.25), radius: 10, x: 0, y: 8)
            
            Button(action: {
                viewRouter.currentTab = .add
            }) {
                Image("Vector")
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(.white)
            }
        }
        .offset(y: -height)
    }
}
