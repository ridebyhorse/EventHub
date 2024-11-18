//
//  ExploreEventsButtonView.swift
//  EventHub
//
//  Created by Иван Семикин on 18/11/2024.
//

import SwiftUI

struct ExploreEventsButtonView: View {
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Text("EXPLORE EVENTS")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.custom(EventHubFont.button))
                
                HStack {
                    Spacer()
                    Image(systemName: "arrow.right")
                        .padding(8)
                        .background(Color.darkMainBlue)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.6)
            .foregroundStyle(.white)
            .padding()
            .background(.mainBlue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ExploreEventsButtonView()
}
