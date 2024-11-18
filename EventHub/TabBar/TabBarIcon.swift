//
//  TabBarIcon.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI

struct TabBarIcon: View {
    @ObservedObject var viewRouter: ViewRouter
    let width, height: CGFloat
    let tab: Tab
    let iconName, tabName: String

    var body: some View {
        Button(action: {
            viewRouter.currentTab = tab
        }) {
            VStack {
                Image(iconName)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .padding(.top, 10)
                    .foregroundColor(viewRouter.currentTab == tab ? Color("MainBlue") : Color("LightGrey"))
                
                Text(tabName)
                    .font(.footnote)
                    .foregroundColor(viewRouter.currentTab == tab ? Color("MainBlue") : Color("LightGrey"))
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

