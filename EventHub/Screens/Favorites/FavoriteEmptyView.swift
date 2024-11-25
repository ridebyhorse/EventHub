//
//  FavoriteEmptyView.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/23/24.

import SwiftUI
import CoreData


struct FavoriteEmptyView: View {
    // MARK: -Properties
    var emptyIcon: String  = "emptyFavorite"
    var iconNo = "xmark"
    var header: String = "NO FAVORITES"
    
    var body: some View {
        VStack {
            Text(header)
                .font(.custom(EventHubFont.h1.name, size: 24))
                .multilineTextAlignment(.center)
                .foregroundColor(.darkBlack)
                .frame(width: 231, height: 240, alignment: .center)
                .padding(.top, 102)
            
            ZStack {
                Image(emptyIcon)
                    .resizable()
                    .scaledToFit()
                
                Image(systemName:iconNo)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.mainRed)
                    .frame(width: 31, height: 30)
                    .offset(y: -10)
            }
            .frame(width: 137, height: 143)
            .padding(.top, -50)
        
         
        }
        Spacer()
    }
}

#Preview {
    FavoriteEmptyView()
}
