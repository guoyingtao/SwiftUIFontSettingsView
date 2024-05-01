//
//  Font.Design.Extension.swift
//  PostAnywhere
//
//  Created by Yingtao Guo on 4/30/24.
//

import SwiftUI

extension Font.Design {
    static var allDesigns: [Font.Design] {
        return [.default, .monospaced, .rounded, .serif]
    }
    
    var description: String {
        switch self {
        case .default:
            return "Default"
        case .monospaced:
            return "Monospaced"
        case .rounded:
            return "Rounded"
        case .serif:
            return "Serif"
        default:
            return "Default"
        }
    }
    
    func getDesign(byDescription description: String) -> Font.Design {
        switch description {
        case "Default":
            return .default
        case "Monospaced":
            return .monospaced
        case "Rounded":
            return .rounded
        case "Serif":
            return .serif
        default:
            return .default
        }
    }
}
