//
//  FavoritesView.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/23/24.

import SwiftUI
import CoreData

struct FavoritesView: View {
    @EnvironmentObject var favoritesDataController: FavoritesDataController
    @StateObject private var viewModel: FavoritesViewModel

    init() {
        _viewModel = StateObject(wrappedValue: FavoritesViewModel())
    }

    var body: some View {
        NavigationView {
                VStack(spacing: 16) {
                    if viewModel.favorites.isEmpty {
                        FavoritesToolBarView()
                        FavoriteEmptyView()
                    } else {
                        FavoritesToolBarView()
                        ScrollView {
                        ForEach(viewModel.favorites, id: \.self) { event in
                            HStack {
                               
                                Image("mockNew")
                                    .resizable()
                                    .frame(
                                        width: UIScreen.main.bounds.width * 0.2,
                                        height: UIScreen.main.bounds.height * 0.1
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                                
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(event.date ?? "Unknown Date")
                                            .font(.custom(EventHubFont.subtitle2))
                                .foregroundColor(.mainBlue)
                                        Spacer()

                                     
                                        Button(action: {
                                            viewModel.deleteFavorite(event: event)
                                        }) {
                                            Image(Buttons.addFavorite)
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                        }
                                    }

                                    Text(event.title ?? "Unknown Title")
                                        .font(.custom(EventHubFont.body2))
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    HStack(spacing: 4) {
                                        Image("location")
                                        Text(event.location ?? "Unknown Location")
                                            .font(.custom(EventHubFont.subtitle2))
                                            .foregroundColor(.gray)
                                        
                                        Text(event.city ?? "Unknown City")
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
        }
    }
}

#Preview {
    let previewContext = {
        let container = NSPersistentContainer(name: "Favorites")
        container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load in-memory store: \(error)")
            }
        }
        return container.viewContext
    }()

    FavoritesView()
        .environmentObject(FavoritesDataController())
}
