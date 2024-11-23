//
//  HeaderView.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    
    let locations: [Location] = Location.allCases
    @Binding var selectedLocation: Location
    @State private var isFilterViewPresented = false
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 33)
                .fill(Color("MainBlue"))
            
            VStack(alignment: .leading, spacing: 20) {
// MARK: - Location
                HStack {
                    Menu {
                        ForEach(locations, id: \.self) { location in
                            Button(action: {
                                selectedLocation = location
                            }) {
                                Text(location.rawValue)
                            }
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Current Location")
                                .font(.custom(EventHubFont.subtitle3))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 4) {
                                Text(selectedLocation.rawValue.capitalized)
                                    .font(.custom(EventHubFont.body1))
                                    .foregroundColor(.white)
                                
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .frame(width: 10, height: 6)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    Spacer()
                    
// MARK: - Notificztions
                    Button {
                        print("notification pressed")
                    } label: {
                        Image("notification")
                            .frame(width: 36, height: 36)
                    }
                    
                }
                .padding(.horizontal, 24)
                
// MARK: - Search
                HStack {
                    HStack {
                        Image("search")
                            .foregroundColor(.white.opacity(0.6))
                        
                        ZStack(alignment: .leading) {
                            if searchText.isEmpty {
                                Text("| Search...")
                                    .foregroundColor(.white.opacity(0.6))
                                    .font(.system(size: 20))
                            }
                            
                            TextField("", text: $searchText)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .disableAutocorrection(true)
                        }
                    }
                    
                    
                    Spacer()
                    // MARK: - Filter
                    Button(action: {
                        isFilterViewPresented = true
                    }) {
                        HStack(spacing: 8) {
                            Image("filter-circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                            
                            Text("Filters")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.white)
                        }
                        
                        .frame(width: 75, height: 32)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                            
                                .fill(.white.opacity(0.1))
                        )
                    }
                    .sheet(isPresented: $isFilterViewPresented) {
                        FiltersView()
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - временное вью для фильтра
struct FiltersView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Filters Settings")
                    .font(.title2)
                    .padding()
                Spacer()
            }
            .navigationBarTitle("Filters", displayMode: .inline)
            .navigationBarItems(leading: Button("Close") {
                dismiss()
            })
        }
    }
}

//#Preview {
//    HeaderView(selectedLocation: )
//}
