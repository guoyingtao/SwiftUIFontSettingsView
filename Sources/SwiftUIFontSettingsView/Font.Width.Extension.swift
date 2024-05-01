//
//  Font.Width.Extension.swift
//  PostAnywhere
//
//  Created by Yingtao Guo on 4/30/24.
//

import SwiftUI

extension Font.Width {
    static var allWidths: [Font.Width] {
        return [.compressed, .condensed, .standard, .expanded]
    }
    
    var description: String {
        switch self {
        case .compressed:
            return "Compressed"
        case .condensed:
            return "Condensed"
        case .standard:
            return "Standard"
        case .expanded:
            return "Expanded"
        default:
            return "Standard"
        }
    }
    
    func getWidth(byDescription description: String) -> Font.Width {
        switch description {
        case "Compressed":
            return .compressed
        case "Condensed":
            return .condensed
        case "Standard":
            return .standard
        case "Expanded":
            return .expanded
        default:
            return .standard
        }
    }
}
