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
    
    func formattedForSearchEvent() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "d MMM"
        let datePart = dateFormatter.string(from: self)
        
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeekPart = dateFormatter.string(from: self)
        
        dateFormatter.dateFormat = "h:mm a"
        let timePart = dateFormatter.string(from: self)
        
        return "\(datePart.capitalized)- \(dayOfWeekPart.prefix(3).capitalized) -\(timePart)"
    }
    
    func formattedForEventDate() -> String {
          let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
          return formatter.string(from: self)
      }
}
