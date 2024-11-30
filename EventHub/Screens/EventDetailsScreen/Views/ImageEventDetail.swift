//
//  ImageEventDetail.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import SwiftUI

struct ImageEventDetail: View {
    var imageURL: URL?
   
    var body: some View {
        GeometryReader { geometry in
            let imageHeight = geometry.frame(in: .global).minY + UIScreen.main.bounds.height / 3
            let imageOffset = -geometry.frame(in: .global).minY
            
            PreLoadImageView(url: imageURL)
                .offset(y: imageOffset)
                .frame(width: UIScreen.main.bounds.width, height: imageHeight)
        }
        .frame(height: UIScreen.main.bounds.height / 3)
    }
}
