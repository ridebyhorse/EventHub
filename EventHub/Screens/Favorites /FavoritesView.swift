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
                                        Text(event.publicationDate.formattedForEvent() ?? "Unknown Date")
                                            .font(.custom(EventHubFont.subtitle2))
                                            .foregroundColor(.mainBlue)
                                        Spacer()

        Button(action: {
            Task{
                await  viewModel.deleteFavorite(event: event)
            }
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
                        Text(event.location.slug.formattedLocation ?? "Unknown Location")
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
    let mockFavoritesDataController = FavoritesDataController()
    let mockFavoritesViewModel = FavoritesViewModel(dataController: mockFavoritesDataController)

    // Create a sample event for testing
    let mockEvent = EventModel(
        id: 1,
        publicationDate: Date(),
        dates: [],
        title: "Sample Event",
        shortTitle: "Sample",
        slug: "sample-event",
        place: nil,
        description: "A sample event for testing.",
        bodyText: "Details about the sample event.",
        location: ShortLocationModel(slug: .krasnoyarsk), // Adjust this to match your model
        categories: ["Music", "Festival"],
        tagline: "Join the fun!",
        price: "Free",
        isFree: true,
        images: [],
        favoritesCount: 10,
        commentsCount: 5,
        siteUrl: URL(string: "https://www.example.com")!,
        tags: ["test", "event"]
    )

    mockFavoritesViewModel.favorites = [mockEvent]

    return FavoritesView()
        .environmentObject(mockFavoritesViewModel)
        .onAppear {
            Task {
                await mockFavoritesViewModel.setup()
            }
        }
}
