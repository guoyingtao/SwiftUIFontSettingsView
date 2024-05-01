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
    
    private let fontNames: [String] = {
        var names = [String]()
        for familyName in UIFont.familyNames {
            names.append(contentsOf: UIFont.fontNames(forFamilyName: familyName))
        }
        return names.sorted()
    }()

    var body: some View {
        List(fontNames, id: \.self) { fontName in
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
