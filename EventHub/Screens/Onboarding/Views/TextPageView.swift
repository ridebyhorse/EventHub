//
//  TextPageView.swift
//  EventHub
//
//  Created by Roman Golub on 19.11.2024.
//

import SwiftUI

struct TextPageView: View {
    // MARK: - Properties
    let title: String
    let description: String
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(title)
                .font(.custom(EventHubFont.h5))
                .multilineTextAlignment(.center)
                .foregroundColor(.bg)
                .frame(width: 295, alignment: .center)
            
            Text(description)
                .font(.custom(EventHubFont.body2))
                .multilineTextAlignment(.center)
                .foregroundColor(.bg)
                .frame(width: 295, alignment: .center)
                .opacity(0.8)
                .padding(.top, 16)
        }
    }
}


#Preview {
    TextPageView(title: "Explore Upcoming and Nearby Events", description: "In publishing and graphic design, Lorem is a placeholder text commonly")
}
