//
//  TextSettingsView.swift
//  PostAnywhere
//
//  Created by Yingtao Guo on 4/29/24.
//

import SwiftUI

public struct FontSettings: Equatable {
    public var showFontPreview = true
    public var foregroundColor = Color.black
    public var backgroundColor = Color.clear
    public var textStyle = Font.TextStyle.title
    public var useCustomFont = false
    public var customFont = Font.system(size: 28)
    public var fontWeight = Font.Weight.regular
    public var fontWidth = Font.Width.standard
    public var fontDesign = Font.Design.default
    
    public var fontSizeMin: CGFloat = 12
    public var fontSizeMax: CGFloat = 200
    
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
    
    public var customFontNames: [String] = [] {
        didSet {
            customFontName = customFontNames.first ?? "Helvetica"
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
    var previewText = NSLocalizedString("fontSettings.previewText", bundle: .module, comment: "")
    var previewSectionTitle = NSLocalizedString("fontSettings.previewSectionTitle", bundle: .module, comment: "")
    var colorSectionTitle = NSLocalizedString("fontSettings.colorSectionTitle", bundle: .module, comment: "")
    var fontsSectionTitle = NSLocalizedString("fontSettings.fontsSectionTitle", bundle: .module, comment: "")
    var navigationTitle = NSLocalizedString("fontSettings.navigationTitle", bundle: .module, comment: "")
    
    public init(previewText: String = "",
                previewSectionTitle: String = "",
                colorSectionTitle: String = "",
                fontsSectionTitle: String = "",
                navigationTitle: String = "") {
        self.previewText = previewText.isEmpty ? NSLocalizedString("fontSettings.previewText", bundle: .module, comment: "") : previewText
        self.previewSectionTitle = previewSectionTitle.isEmpty ? NSLocalizedString("fontSettings.previewSectionTitle", bundle: .module, comment: "") : previewSectionTitle
        self.colorSectionTitle = colorSectionTitle.isEmpty ? NSLocalizedString("fontSettings.colorSectionTitle", bundle: .module, comment: "") : colorSectionTitle
        self.fontsSectionTitle = fontsSectionTitle.isEmpty ? NSLocalizedString("fontSettings.fontsSectionTitle", bundle: .module, comment: "") : fontsSectionTitle
        self.navigationTitle = navigationTitle.isEmpty ? NSLocalizedString("fontSettings.navigationTitle", bundle: .module, comment: "") : navigationTitle
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
            ColorPicker(NSLocalizedString("fontSettings.foregroundColorPicker", bundle: .module, comment: ""), selection: $fontSettings.foregroundColor)
            ColorPicker(NSLocalizedString("fontSettings.backgroundColorPicker", bundle: .module, comment: ""), selection: $fontSettings.backgroundColor)
        }
    }
    
    var fontSettingsSection: some View {
        Section(fontSettingsText.fontsSectionTitle) {
            HStack {
                Text(NSLocalizedString("fontSettings.useCustomFont", bundle: .module, comment: ""))
                Spacer()
                Toggle("", isOn: $fontSettings.useCustomFont.animation())
            }
            if fontSettings.useCustomFont {
                Group {
                    HStack {
                        NavigationLink {
                            FontNamesView(fontName: $fontSettings.customFontName, customFontNames: fontSettings.customFontNames)
                        } label: {
                            HStack {
                                Text(NSLocalizedString("fontSettings.fontName", bundle: .module, comment: ""))
                                Spacer()
                                Text(fontSettings.customFontName)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    
                    HStack {
                        Text(String(format: NSLocalizedString("fontSettings.fontSize", bundle: .module, comment: ""), Int(fontSettings.customFontSize)))
                        Spacer()
                        Slider(value: $fontSettings.customFontSize, in: fontSettings.fontSizeMin...fontSettings.fontSizeMax)
                    }
                }
            } else {
                Picker(NSLocalizedString("fontSettings.textStyle", bundle: .module, comment: ""), selection: $fontSettings.textStyle) {
                    ForEach(Font.TextStyle.allTextStyles, id: \.self) { style in
                        Text(NSLocalizedString("textStyle." + style.description.lowercased(), bundle: .module, comment: ""))
                    }
                }
                
                Picker(NSLocalizedString("fontSettings.fontWeight", bundle: .module, comment: ""), selection: $fontSettings.fontWeight) {
                    ForEach(Font.Weight.allWeights, id: \.self) { weight in
                        Text(NSLocalizedString("fontWeight." + weight.description.lowercased(), bundle: .module, comment: ""))
                    }
                }
                
                Picker(NSLocalizedString("fontSettings.fontDesign", bundle: .module, comment: ""), selection: $fontSettings.fontDesign) {
                    ForEach(Font.Design.allDesigns, id: \.self) { design in
                        Text(NSLocalizedString("fontDesign." + design.description.lowercased(), bundle: .module, comment: ""))
                            .fontDesign(design)
                    }
                }
            }
            
            if !fontSettings.useCustomFont || fontSettings.useCustomFont && fontSettings.customFontNames.isEmpty {
                Picker(NSLocalizedString("fontSettings.fontWidth", bundle: .module, comment: ""), selection: $fontSettings.fontWidth) {
                    ForEach(Font.Width.allWidths, id: \.self) { width in
                        Text(NSLocalizedString("fontWidth." + width.description.lowercased(), bundle: .module, comment: ""))
                    }
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
                    
                    if showFontPreview {
                        previewFontSection
                    }                    
                    
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
