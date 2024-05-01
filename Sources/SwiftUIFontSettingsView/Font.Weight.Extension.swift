//
//  Font.Weight.Extension.swift
//  PostAnywhere
//
//  Created by Yingtao Guo on 4/30/24.
//

import SwiftUI

extension Font.Weight {
    static var allWeights: [Font.Weight] {
        return [.black, .bold, .heavy, .light, .medium, .regular, .semibold, .thin, .ultraLight]
    }
    
    var description: String {
        switch self {
        case .black:
            return "Black"
        case .bold:
            return "Bold"
        case .heavy:
            return "Heavy"
        case .light:
            return "Light"
        case .medium:
            return "Medium"
        case .regular:
            return "Regular"
        case .semibold:
            return "Semibold"
        case .thin:
            return "Thin"
        case .ultraLight:
            return "Ultra Light"
        default:
            return "Regular"
        }
    }
    
    func getWeight(byDescription description: String) -> Font.Weight {
        switch description {
        case "Black":
            return .black
        case "Bold":
            return .bold
        case "Heavy":
            return .heavy
        case "Light":
            return .light
        case "Medium":
            return .medium
        case "Regular":
            return .regular
        case "Semibold":
            return .semibold
        case "Thin":
            return .thin
        case "Ultra Light":
            return .ultraLight
        default:
            return .regular
        }
    }
}
