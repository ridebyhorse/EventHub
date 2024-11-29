//
//  FavoritesView2.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/27/24.
//


import SwiftUI
import RealmSwift
import FirebaseAuth

struct FavoritesView: View {
    @EnvironmentObject var viewModel: FavoritesService
    @ObservedResults(FavoriteItem.self, sortDescriptor: SortDescriptor(keyPath: "eventLocation", ascending: true)) var favorites

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                FavoritesToolBarView()

                if favorites.isEmpty {
                    FavoriteEmptyView()
                } else {
                    ScrollView {
                        ForEach(favorites) { favorite in
                            HStack {
                                Image("mockNew")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                                VStack(alignment: .leading, spacing: 15) {
                                    HStack(){
                                        Text(favorite.eventDate.formattedForEvent())
                                            .foregroundColor(.mainBlue)
                                            .font( .custom(EventHubFont.body2))
                                        Spacer()
                                        Button(action: {
                                            viewModel.deleteEvent(id: favorite.id)
                                        }) {
                                            Image(Buttons.deleteFavorite)
                                                .frame(width: 16, height: 16)
                                        }
                                    }
                                    
                                    HStack {
                                        Text(favorite.title)
                                            .font(.custom(EventHubFont.body2))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    HStack(spacing: 4) {
                                        Image("mapPin")
                                        Text(favorite.eventLocation)
                                            .font(.custom(EventHubFont.subtitle2))
                                            .foregroundColor(.locationGrey)
                                    }
                                    .padding(.top, 1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(.leading,10)

                                Spacer()
                            }
                            .onAppear {
                                print("Favorites count: \(favorites.count)")
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
        .onAppear {
            viewModel.getEvent()
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesService())
}

//enum RealmMigrator {
//    static func configureRealm() -> Realm.Configuration {
//        let config = Realm.Configuration(
//            schemaVersion: 10,
//            migrationBlock: { migration, oldSchemaVersion in
//                if oldSchemaVersion < 10 {
//                    migration.enumerateObjects(ofType: FavoriteItem.className()) { _, newObject in
//                        newObject?["eventStatus"] = EventStatus.attended.rawValue
//                    }
//                }
//            }
//        )
//        return config
//    }
//}
