//
//  AddFavorite.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/23/24.
//

import SwiftUI
import CoreData

struct AddFavoriteView: View {
    @EnvironmentObject var favoritesDataController: FavoritesDataController
    @StateObject private var viewModel: FavoritesViewModel

    init() {
        _viewModel = StateObject(wrappedValue: FavoritesViewModel())
    }

    var body: some View {
        VStack {
            Button(action: {
                viewModel.saveFavorite(
                    title: "New Event",
                    date: "2024-11-23",
                    location: "New Location"
                )
            }) {
                Image("favorite")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:30,height: 30)
            }
        }
        .padding()
    }
}

#Preview {
    AddFavoriteView()
}
