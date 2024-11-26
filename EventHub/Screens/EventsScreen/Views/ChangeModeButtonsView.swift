//
//  ChangeModeButtonsView.swift
//  EventHub
//
//  Created by Иван Семикин on 18/11/2024.
//

import SwiftUI

struct ChangeModeButtonsView: View {
    @Binding var choosedMode: ModeEvents
    
    var body: some View {
        HStack {
            HStack {
                Button {
                    choosedMode = .upcoming
                } label: {
                    Text("UPCOMING")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(choosedMode == .upcoming ? .white : .clear)
                        .foregroundStyle(choosedMode == .upcoming ? .mainBlue : .gray)
                        .clipShape(.capsule)
                }
                .shadow(color: .gray.opacity(0.2), radius: choosedMode == .upcoming ? 5 : 0)
                .buttonStyle(PlainButtonStyle())
                
                Button {
                    choosedMode = .pastEvents
                } label: {
                    Text("PAST EVENTS")
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(choosedMode == .pastEvents ? .white : .clear)
                        .foregroundStyle(choosedMode == .pastEvents ? .mainBlue : .gray)
                        .clipShape(.capsule)
                }
                .shadow(color: .gray.opacity(0.2), radius: choosedMode == .pastEvents ? 5 : 0)
                .buttonStyle(PlainButtonStyle())
            }
            .padding(5)
        }
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .background(.lightGrey.opacity(0.2))
        .clipShape(.capsule)
    }
}
