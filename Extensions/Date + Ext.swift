//
//  Date + Ext.swift
//  EventHub
//
//  Created by Иван Семикин on 19/11/2024.
//

import Foundation

extension Date {
    func formattedForEvent() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E, MMM d"
        let datePart = dateFormatter.string(from: self)
        
        dateFormatter.dateFormat = "h:mm a"
        let timePart = dateFormatter.string(from: self)
        
        return "\(datePart) • \(timePart)"
    }
}
