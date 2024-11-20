//
//  Font + Ext.swift
//  EventHub
//
//  Created by Иван Семикин on 18/11/2024.
//

import Foundation
import SwiftUI

extension SwiftUI.Font {
    static func custom(_ font: Font) -> SwiftUI.Font {
        SwiftUI.Font.custom(font.name, size: font.size)
    }
}
