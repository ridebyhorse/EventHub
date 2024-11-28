//
//  PreLoadImageView.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct PreLoadImageView: View {
    var url: URL?
    var scaleEffect: CGFloat = 1
    
    var body: some View {
        if let imageUrl = url {
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
