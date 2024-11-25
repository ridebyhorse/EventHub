//
//  PreLoadImageView.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct PreLoadImageView: View {
    var url: String?
    var scaleEffect: CGFloat = 1
    
    var body: some View {
        if let urlString = url, let imageUrl = URL(string: urlString) {
            AsyncImage(url: imageUrl) { img in
                img
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                DefaultLoadImageView(scaleEffect: scaleEffect)
            }
        } else {
            DefaultLoadImageView(scaleEffect: scaleEffect)
        }
    }
}
