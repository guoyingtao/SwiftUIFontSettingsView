//
//  TextSettingsView.swift
//  PostAnywhere
//
//  Created by Yingtao Guo on 4/29/24.
//

import SwiftUI

public struct FontSettings: Equatable {
    public var foregroundColor = Color.black
    public var backgroundColor = Color.clear
    public var textStyle = Font.TextStyle.title
    public var useCustomFont = false
    public var customFont = Font.system(size: 28)
    public var fontWeight = Font.Weight.regular
    public var fontWidth = Font.Width.standard
    public var fontDesign = Font.Design.default
    
    public var customFontSize: CGFloat = 28 {
        didSet {
            setupCustomFont()
        }
    }
    
    public var customFontName = "Helvetica" {
        didSet {
            setupCustomFont()
        }
    }
    
    public var font: Font {
        if useCustomFont {
            return customFont
                .width(fontWidth)
        } else {
            return Font.system(textStyle, design: fontDesign, weight: fontWeight).width(fontWidth)
        }
    }
    
    public init() {}
    
    private mutating func setupCustomFont() {
        customFont = Font.custom(customFontName, size: customFontSize)
    }
}

public struct FontSettingsText {
    var previewText = "Hi"
    var previewSectionTitle = "Font Preview"
    var colorSectionTitle = "Font Colors"
    var fontsSectionTitle = "Font Settings"
    var navigationTitle = "Font Settings"
    
    public init(previewText: String = "Hi", previewSectionTitle: String = "Font Preview", colorSectionTitle: String = "Font Colors", fontsSectionTitle: String = "Font Settings",
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
                            FontNamesView(fontName: $fontSettings.customFontName)
                        } label: {
                            HStack {
                                Text("Font Name")
                                Spacer()
                                Text(fontSettings.customFontName)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    
                    HStack {
                        Text("Font Size: \(Int(fontSettings.customFontSize))")
                        Spacer()
                        Slider(value: $fontSettings.customFontSize, in: 12...200)
                    }
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
    
    private let backgroundColor: Color?
        
    public init(fontSettings: Binding<FontSettings>,
        fontSettingsText: FontSettingsText = FontSettingsText(),
        backgroundColor: Color? = nil,
        showExtraTopContent: Bool = false,
        @ViewBuilder topContentBuilder: () -> ExtraTopContent = (EmptyView.init),
         showExtraBottomContent: Bool = false,
         @ViewBuilder bottomContentBuilder: () -> ExtraBottomContent = (EmptyView.init)) {
        self._fontSettings = fontSettings
        self.fontSettingsText = fontSettingsText
        self.backgroundColor = backgroundColor
        self.showExtraTopContent = showExtraTopContent
        self.extraTopContent = topContentBuilder()
        self.showExtraBottomContent = showExtraBottomContent
        self.extraBottomContent = bottomContentBuilder()
    }
    
    public var body: some View {
        NavigationStack {
            ZStack {
                if let backgroundColor {
                    backgroundColor
                }
                
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
                .modifier(ConditionalBackgroundModifier(backgroundColor: backgroundColor))
            }
        }
    }
}

struct ConditionalBackgroundModifier: ViewModifier {
    let backgroundColor: Color?
    
    func body(content: Content) -> some View {
        Group {
            if let backgroundColor = backgroundColor {
                content
                    .scrollContentBackground(.hidden)
                    .background(backgroundColor)
            } else {
                content
            }
        }
    }
}

#Preview {
    FontSettingsView(fontSettings: .constant(FontSettings()))
}
