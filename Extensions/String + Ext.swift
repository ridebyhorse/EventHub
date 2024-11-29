//
//  String + Ext.swift
//  EventHub
//
//  Created by Roman Golub on 27.11.2024.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        guard let first = self.first else { return self }
        return first.uppercased() + self.dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
