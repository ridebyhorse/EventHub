//
//  ActionButtonsShareModel.swift
//  EventHub
//
//  Created by Roman Golub on 22.11.2024.
//

import Foundation

enum ActionButtonsShareModel: String, CaseIterable {
    case copyLink
    case whatsapp
    case facebook
    case messenger
    case twitter
    case instagram
    case skype
    case message
    
    var title: String {
        switch self {
        case .copyLink: return "Copy Link"
        case .whatsapp: return "WhatsApp"
        case .facebook: return "Facebook"
        case .messenger: return "Messenger"
        case .twitter: return "Twitter"
        case .instagram: return "Instagram"
        case .skype: return "Skype"
        case .message: return "Message"
        }
    }
    
    var imageName: String {
        return self.rawValue
    }
}
