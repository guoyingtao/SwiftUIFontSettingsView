//
//  TextSettingsView.swift
//  PostAnywhere
//
//  Created by Yingtao Guo on 4/29/24.
//

import SwiftUI

public struct FontSettings {
    public var foregroundColor = Color.black
    public var backgroundColor = Color.clear
    public var textStyle = Font.TextStyle.title
    public var useCustomFont = false
    public var customFont = Font.system(size: 17)
    public var fontWeight = Font.Weight.regular
    public var fontWidth = Font.Width.standard
    public var fontDesign = Font.Design.default
    
    public init() {}
    
    public var font: Font {
        if useCustomFont {
            return customFont
                .width(fontWidth)
        } else {
            return Font.system(textStyle, design: fontDesign, weight: fontWeight).width(fontWidth)
        }
    }
}

public struct FontSettingsText {
    var previewText = "Hello World"
    var previewSectionTitle = "Font Preview"
    var colorSectionTitle = "Font Colors"
    var fontsSectionTitle = "Font Settings"
    var navigationTitle = "Font Settings"
    
    public init(previewText: String = "Hello World", previewSectionTitle: String = "Font Preview", colorSectionTitle: String = "Font Colors", fontsSectionTitle: String = "Font Settings",
        navigationTitle: String = "Font Settings") {
        self.previewText = previewText
        self.previewSectionTitle = previewSectionTitle
        self.colorSectionTitle = colorSectionTitle
        self.fontsSectionTitle = fontsSectionTitle
        self.navigationTitle = navigationTitle
    }
}

public struct FontSettingsView<ExtraTopContent: View, ExtraBottomContent: View>: View {
    @Binding var fontSettings: FontSettings
    
    private let fontSettingsText: FontSettingsText
    private let showExtraTopContent: Bool
    private let extraTopContent: ExtraTopContent?
    private let showExtraBottomContent: Bool
    private let extraBottomContent: ExtraBottomContent?

    @State private var showFontPicker = false
    @State private var customFontName = "Helvetica"
    @State private var customFontSize: CGFloat = 17
    
    var previewFontSection: some View {
        Section(fontSettingsText.previewSectionTitle) {
            Text(fontSettingsText.previewText)
                .font(fontSettings.font)
                .foregroundStyle(fontSettings.foregroundColor)
                .background(fontSettings.backgroundColor)
        }
    }
    
    var colorSettingsSection: some View {
        Section(fontSettingsText.colorSectionTitle) {
            ColorPicker("Set the text foreground color", selection: $fontSettings.foregroundColor)
            ColorPicker("Set the text background color", selection: $fontSettings.backgroundColor)
        }
    }
    
    var fontSettingsSection: some View {
        Section(fontSettingsText.fontsSectionTitle) {
            HStack {
                Text("Use Custom Font")
                Spacer()
                Toggle("", isOn: $fontSettings.useCustomFont.animation())
            }
            if fontSettings.useCustomFont {
                Group {
                    HStack {
                        NavigationLink {
                            FontNamesView(fontName: $customFontName)
                        } label: {
                            HStack {
                                Text("Font Name")
                                Spacer()
                                Text(customFontName)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    
                    Stepper("Font Size: \(Int(customFontSize))", value: $customFontSize, in: 12...72, step: 1.0)
                }
                .onChange(of: customFontName) { old, new in
                    fontSettings.customFont = Font.custom(new, size: customFontSize)
                }
                .onChange(of: customFontSize) { old, new in
                    fontSettings.customFont = Font.custom(customFontName, size: new)
                }
            } else {
                Picker("Text Style", selection: $fontSettings.textStyle) {
                    ForEach(Font.TextStyle.allTextStyles, id: \.self) { style in
                        Text(style.description)
                    }
                }
                
                Picker("Font Weight", selection: $fontSettings.fontWeight) {
                    ForEach(Font.Weight.allWeights, id: \.self) { weight in
                        Text(weight.description)
                    }
                }
                
                Picker("Font Design", selection: $fontSettings.fontDesign) {
                    ForEach(Font.Design.allDesigns, id: \.self) { design in
                        Text(design.description)
                            .fontDesign(design)
                    }
                }
            }
                                
            Picker("Font Width", selection: $fontSettings.fontWidth) {
                ForEach(Font.Width.allWidths, id: \.self) { width in
                    Text(width.description)
                }
            }
        }
    }
        
    public init(fontSettings: Binding<FontSettings>,
        fontSettingsText: FontSettingsText = FontSettingsText(),
        showExtraTopContent: Bool = false,
        @ViewBuilder topContentBuilder: () -> ExtraTopContent = (EmptyView.init),
         showExtraBottomContent: Bool = false,
         @ViewBuilder bottomContentBuilder: () -> ExtraBottomContent = (EmptyView.init)) {
        self._fontSettings = fontSettings
        self.fontSettingsText = fontSettingsText
        self.showExtraTopContent = showExtraTopContent
        self.extraTopContent = topContentBuilder()
        self.showExtraBottomContent = showExtraBottomContent
        self.extraBottomContent = bottomContentBuilder()
    }
    
    public var body: some View {
        NavigationStack {
            Form {
                if showExtraTopContent {
                    extraTopContent
                }
                
                previewFontSection
                
                colorSettingsSection
                
                fontSettingsSection
                
                if showExtraBottomContent {
                    extraBottomContent
                }
            }
        }
    }
}

#Preview {
    FontSettingsView(fontSettings: .constant(FontSettings()))
}
