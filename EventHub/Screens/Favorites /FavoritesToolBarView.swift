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

struct FavoritesToolBarView: View {
    var toolTitle: String = "Favorites"
    var searchTitle: String = "Search"
    @EnvironmentObject var navigationManager: NavigationManager
    @ObservedObject var viewModel: FavoritesViewModel

    var body: some View {
            HStack {
                Spacer()
                Text(viewModel.isSearchTapped ? searchTitle : toolTitle)
                    .font(.custom(EventHubFont.body2.name, size: 24))
                    .foregroundColor(.mainBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading,140)
                
                
                Button(action: {
                    viewModel.isSearchTapped.toggle()
                    navigationManager.currentDestination = .search
                }) {
                    Image(Buttons.search)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.mainBlack)
                        .padding(.leading, 85)
                }
                .padding(.trailing, 29)
            }
            
            .padding(.top, 9)
        
    }
       
}

#Preview {
    FavoritesToolBarView(viewModel: FavoritesViewModel())
}
