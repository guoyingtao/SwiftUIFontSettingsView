//
//  Font.extension.swift
//  PostAnywhere
//
//  Created by Yingtao Guo on 4/30/24.
//

import SwiftUI

extension Font {
    static var allPresetFonts: [Font] {
        return [.largeTitle, .title, .headline, .subheadline, .body, .callout, .footnote, .caption]
    }
    
    var description: String {
        switch self {
        case .largeTitle:
            return "Large Title"
        case .title:
            return "Title"
        case .headline:
            return "Headline"
        case .subheadline:
            return "Subheadline"
        case .body:
            return "Body"
        case .callout:
            return "Callout"
        case .footnote:
            return "Footnote"
        case .caption:
            return "Caption"
        default:
            return "Body"
        }
    }
    
    func getFont(byDescription description: String) -> Font {
        switch description {
        case "Large Title":
            return .largeTitle
        case "Title":
            return .title
        case "Headline":
            return .headline
        case "Subheadline":
            return .subheadline
        case "Body":
            return .body
        case "Callout":
            return .callout
        case "Footnote":
            return .footnote
        case "Caption":
            return .caption
        default:
            return .body
        }
    }
}
