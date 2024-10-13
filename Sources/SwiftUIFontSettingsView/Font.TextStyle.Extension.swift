//
//  Font.TextStyle.Extension.swift
//  PostAnywhere
//
//  Created by Yingtao Guo on 4/30/24.
//

import SwiftUI

extension Font.TextStyle {
    static var allTextStyles: [Font.TextStyle] {
        return [.largeTitle, .title, .title2, .title3, .headline, .subheadline, .body, .callout, .footnote, .caption, .caption2]
    }

    var description: String {
        switch self {
        case .largeTitle:
            return "Large Title"
        case .title:
            return "Title"
        case .title2:
            return "Title 2"
        case .title3:
            return "Title 3"
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
        case .caption2:
            return "Caption 2"
        default:
            return "Body"
        }
    }
        
    func getTextStyle(byDescription description: String) -> Font.TextStyle {
        switch description {
        case "Large Title":
            return .largeTitle
        case "Title":
            return .title
        case "Title 2":
            return .title2
        case "Title 3":
            return .title3
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
        case "Caption 2":
            return .caption2
        default:
            return .body
        }
    }
}
