//
//  SeeAllEventsScreenView.swift
//  EventHub
//
//  Created by Иван Семикин on 25/11/2024.
//

import SwiftUI

struct SeeAllEventsScreenView: View {
    @State var events: [EventModel]
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            ForEach(events, id: \.self) { event in
                EventView(event: event)
            }
        }
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
                Button {
                    // go to search
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .font(.custom(EventHubFont.h4))
                }
            }
        }
    }
}

#Preview {
    SeeAllEventsScreenView(events: [])
}
