//
//  TabBarDimensions.swift
//  EventHub
//
//  Created by Kate Kashko on 18.11.2024.
//

import SwiftUI

struct TabBarDimensions {
    let geometry: GeometryProxy
    
    var iconWidth: CGFloat {
        geometry.size.width / 5
    }
    
    var iconHeight: CGFloat {
        geometry.size.height / 28
    }
    
    var circleSize: CGFloat {
        geometry.size.width / 7
    }
    
    var circleIconSize: CGFloat {
        geometry.size.width / 28
    }
}
