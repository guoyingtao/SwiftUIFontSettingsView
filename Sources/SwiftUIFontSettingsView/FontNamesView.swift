//
//  FontNamesView.swift
//  FontSettingsView
//
//  Created by Yingtao Guo on 4/30/24.
//

import SwiftUI
import UIKit

/// Displays all available fonts in a vertically scrolling view.
struct FontNamesView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var fontName: String
    
    let customFontNames: [String]
    
    private let fontNames: [String] = {
        var names = [String]()
        for familyName in UIFont.familyNames {
            names.append(contentsOf: UIFont.fontNames(forFamilyName: familyName))
        }
        return names.sorted()
    }()
    
    private var nameList: [String] {
        if !customFontNames.isEmpty {
            customFontNames
        } else {
            fontNames
        }
    }
    
    init(fontName: Binding<String>, customFontNames: [String] = []) {
        _fontName = fontName
        self.customFontNames = customFontNames
    }

    var body: some View {
        List(nameList, id: \.self) { fontName in
            HStack {
                Text(fontName)
                    .font(Font.custom(fontName, size: 17))
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                self.fontName = fontName
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    NavigationView {
        FontNamesView(fontName: .constant("Helvetica"))
            .navigationBarTitle("Fonts", displayMode: .inline)
    }
}
