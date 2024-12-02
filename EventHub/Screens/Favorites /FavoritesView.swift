//
//  FavoritesView.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/23/24.

import SwiftUI
import CoreData

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if viewModel.favorites.isEmpty {
                    FavoritesToolBarView(viewModel: viewModel)
                    FavoriteEmptyView()
                } else {
                    FavoritesToolBarView(viewModel: viewModel)
                    ScrollView {
                        ForEach($viewModel.favorites, id: \.self) { $event in
                            HStack {
                                Image("mockNew")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(event.publicationDate.formattedForEvent())
                                            .font(.custom(EventHubFont.subtitle2))
                                            .foregroundColor(.mainBlue)
                                        Spacer()
                                        
                                        Button(action: {
                                            Task{
                                                viewModel.deleteFavorite(event: event)
                                            }
                                        }) {
                                            Image(Buttons.addFavorite)
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                        }
                                    }
                                    
                                    Text(event.title)
                                        .font(.custom(EventHubFont.body2))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack(spacing: 4) {
                                        Image(AppTexts.Common.locationButton)
                                            .resizable()
                                            .frame(width: 14, height: 14)
                                        Text(event.location.slug.formattedLocation)
                                            .font(.custom(EventHubFont.subtitle2))
                                            .foregroundColor(.gray)
                                    }
                                    .padding(.top, 1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                                Spacer()
                            }
                            .padding(10)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            .padding(.top, 12)
            .onAppear {
                Task {
                    await viewModel.fetchFavorites()
                }
            }
        }
    }
}
