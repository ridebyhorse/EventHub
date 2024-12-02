//
//  FavoritesHeaderView.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/22/24.
//
import SwiftUI

enum Buttons {
    static let addFavorite: String = "favorite"
    static let search: String = "favoritesSearch"
}

struct FavoritesToolBarView: View{
    var toolTitle: String = "Favorites"
    var searchTitle: String = "Search"
    @EnvironmentObject var navigationManager: NavigationManager
    @ObservedObject var  viewModel: FavoritesViewModel
    var body: some View {
        HStack(spacing:20){
            Text(viewModel.isSearchTapped ? searchTitle: toolTitle)
                .font(.custom(EventHubFont.body2.name, size: 24))
                .foregroundColor(.mainBlack)
            Button(action:{
                viewModel.isSearchTapped.toggle()
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
    FavoritesToolBarView(viewModel: FavoritesViewModel())
}
