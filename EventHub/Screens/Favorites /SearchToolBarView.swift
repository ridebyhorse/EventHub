//
//  Untitled.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/27/24.
//

import SwiftUI
import SwiftUI

struct SearchToolbarView: View {
    var title: String = "Search"
    var onBack: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                onBack()
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.mainBlack)
            }
            .padding(.leading, 16)

            Spacer()
            
            Text(title)
                .font(.custom(AppTexts.Common.sfPro, size: 24).weight(.medium))
                .foregroundColor(.mainBlack)

            Spacer()
        }
        .frame(height: 44)
        .background(Color.white)
        .padding(.horizontal, 16) 
    }
}
