//
//  FavoritesHeaderView.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/22/24.
//
import SwiftUI

struct FavoritesToolBarView: View{
    var toolTitle: String = "Favorites"
    var searchTitle: String = "Search"
    @EnvironmentObject var navigationManager: NavigationManager
    @State var isSearchTapped: Bool = false
    var body: some View {
        HStack(spacing:20){
            Text(isSearchTapped ? searchTitle: toolTitle)
                .font(.custom(EventHubFont.body2.name, size: 24))
                .foregroundColor(.mainBlack)
            Button(action:{
                    isSearchTapped.toggle()
                navigationManager.currentDestination = .search
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
enum Buttons {
    static let deleteFavorite: String = "favorite"
    static let search: String = "favoritesSearch"
}
