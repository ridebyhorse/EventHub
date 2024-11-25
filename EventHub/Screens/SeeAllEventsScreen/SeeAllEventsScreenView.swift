//
//  SeeAllEventsScreenView.swift
//  EventHub
//
//  Created by Иван Семикин on 25/11/2024.
//

import SwiftUI

struct SeeAllEventsScreenView: View {
    @ObservedObject var viewModel: EventsScreenViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollEventsView(viewModel: viewModel)
        
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

