//
//  FavoritesHeaderView.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/22/24.
//
import SwiftUI

struct FavoritesToolBarView: View{
    var toolTitle: String = "Favorites"
    var body: some View {
        HStack {
            Text(toolTitle)
                .font(.custom(EventHubFont.body2.name, size: 24))
                .foregroundColor(.mainBlack)
            Button(action:{
            })
            {
                Image(Buttons.search)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 85)
                    .foregroundColor(.mainBlack)
            }
        }
        .padding(.leading, 124)
        .padding(.top, 9)
    }
}
#Preview(){
    FavoritesToolBarView()
}
