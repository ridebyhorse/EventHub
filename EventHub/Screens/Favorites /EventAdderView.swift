//
//  EventDEtailsSaver.swift
//  EventHub
//
//  Created by Ylyas Abdywahytow on 11/26/24.
//

//import SwiftUI
//
//struct EventAdderView: View {
//    @ObservedObject var viewModel: FavoritesViewModel
//    @State private var eventToAdd: EventModel? = nil
//    let event: EventModel
//
//    var body: some View {
//        VStack {
//            Text("Add Event to Favorites")
//                .font(.largeTitle)
//                .padding()
//
//            
//            Button("Add Mock Event") {
//                let mockEvent = EventModel(
//                    id: 1,
//                    publicationDate: Date(),
//                    dates: [],
//                    title: "Sample Event",
//                    shortTitle: "Sample",
//                    slug: "sample-event",
//                    place: nil,
//                    description: "A sample event for testing.",
//                    bodyText: "Details about the sample event.",
//                    location: ShortLocationModel(slug: .krasnoyarsk),
//                    categories: ["Music", "Festival"],
//                    tagline: "Join the fun!",
//                    price: "Free",
//                    isFree: true,
//                    images: [],
//                    favoritesCount: 10,
//                    commentsCount: 5,
//                    siteUrl: URL(string: "https://www.example.com")!,
//                    tags: ["test", "event"]
//                )
//                Task {
//                    await viewModel.addToFavorites(event: mockEvent)
//                }
//            }
//            .padding()
//        }
//        .onAppear {
//            Task {
//                await viewModel.setup()
//            }
//        }
//    }
//}
//
//struct EventAdderView_Previews: PreviewProvider {
//    static var previews: some View {
//      
//        let mockDataController = FavoritesDataController()
//        let viewModel = FavoritesViewModel(dataController: mockDataController)
//
//       
//        let mockEvent = EventModel(
//            id: 1,
//            publicationDate: Date(),
//            dates: [],
//            title: "Sample Event",
//            shortTitle: "Sample",
//            slug: "sample-event",
//            place: nil,
//            description: "A sample event for testing.",
//            bodyText: "Details about the sample event.",
//            location: ShortLocationModel(slug: .krasnoyarsk),
//            categories: ["Music", "Festival"],
//            tagline: "Join the fun!",
//            price: "Free",
//            isFree: true,
//            images: [],
//            favoritesCount: 10,
//            commentsCount: 5,
//            siteUrl: URL(string: "https://www.example.com")!,
//            tags: ["test", "event"]
//        )
//
//        
//        EventAdderView(viewModel: viewModel,event: mockEvent)
//            .previewDevice("iPhone 16 Pro")
//            .previewDisplayName("Event Adder View Preview")
//    }
//}
