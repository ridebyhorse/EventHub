//
//  SearchView.swift
//  EventHub
//
//  Created by Мария Нестерова on 24.11.2024.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @EnvironmentObject var navigationManager: NavigationManager
    var body: some View {
        VStack {
            SearchInputView(searchText: $viewModel.searchText)
            
            if $viewModel.events.isEmpty {
                Spacer()
            } else {
                ScrollView {
                    ForEach(viewModel.events, id: \.self) { event in
                        VStack {
                            SearchCardView(event: event)
                        }
                    }
                }
            }
        }
        .navigationTitle("Search")
    }
}

private struct SearchInputView: View {
    @State private var isFilterViewPresented = false
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            HStack {
                Image(.searchViolet)
                
                ZStack(alignment: .leading) {
                    TextField("| Search...", text: $searchText)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .disableAutocorrection(true)
                }
            }
            Spacer()
            Button {
                isFilterViewPresented = true
            } label: {
                HStack(spacing: 3) {
                    Image(.filterCircleWhite)
                        .resizable()
                        .frame(width: 20, height: 20)

                    Text("Filters")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                }
             
                .frame(width: 75, height: 32)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(.primaryBlue)
                )
            }
            .sheet(isPresented: $isFilterViewPresented) {
                FiltersView()
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(location: .msk))
}
