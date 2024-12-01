//
//  SeeAllExploreView.swift
//  EventHub
//
//  Created by Мария Нестерова on 01.12.2024.
//

import SwiftUI

struct SeeAllExploreView: View {
    @ObservedObject var viewModel: SeeAllExploreViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        SeeAllExploreScrollView(viewModel: viewModel)
        
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Events")
                    }
                    .foregroundStyle(.black)
                    .font(.custom(EventHubFont.h4))
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SearchView(viewModel: SearchViewModel(location: .newYork))
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .font(.custom(EventHubFont.h4))
                }
            }
        }
    }
}

private struct SeeAllExploreScrollView: View {
        @ObservedObject var viewModel: SeeAllExploreViewModel
        
        var body: some View {
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                Spacer()
            } else {
                if !viewModel.events.isEmpty {
                    ScrollView(.vertical) {
                        ForEach(viewModel.events, id: \.self) { event in
                            NavigationLink {
                                EventDetailsScreen(event: event)
                            } label: {
                                EventView(event: event)
                            }
                        }
                    }
                } else {
                    EmptySeeAllExploreView(selectedMode: viewModel.mode)
                }
            }
        }
}

private struct EmptySeeAllExploreView: View {
    @State var selectedMode: SeeAllMode
    
    var body: some View {
        VStack(spacing: 10) {
            Image(.emptyEvents)
                .resizable()
                .scaledToFill()
                .padding()
                .frame(width: 200, height: 200)
                .offset(y: 20)
            
            Text("No \(selectedMode == .upcoming ? "Upcoming" : "Nearby") Event")
                .font(.title)
            
            Text("Lorem ipsum dolor sit amet, consectetur")
                .font(.custom(EventHubFont.body1))
                .foregroundStyle(.gray)
                .lineSpacing(5)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(width: UIScreen.main.bounds.width * 0.7)
        .frame(maxHeight: .infinity)
    }
}
