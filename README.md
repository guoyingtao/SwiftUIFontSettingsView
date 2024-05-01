<p align="center">
    <img src="images/logo.png" height="128" max-width="90%" alt="SwiftUIFontSettingsView" />
</p>

# SwiftUIFontSettingsView
A font settings view made by SwiftUI

## Requirements
* iOS 16.1+

## Install
 ### Swift Packages
* Repository: https://github.com/guoyingtao/SwiftUIFontSettings.git
* Rules: Version - Exact - 1.0.0

## Usage

```Swift
@State private var fontSettings: FontSettings = FontSettings()
...
FontSettingsView(fontSettings: $fontSettings)

...

FontSettingsView(fontSettings: $fontSettings, showExtraTopContent: true, topContentBuilder:  {
    // some view here
})

...
FontSettingsView(fontSettings: $fontSettings, showExtraBottomContent: true, bottomContentBuilder:  {
    // some view here
})
```

## Demos
<p align="center">
    <img src="images/demo.gif" height="600" alt="Demo" /> 
    <img src="images/screenshot1.png" height="500" alt="Font List" /> 
    <img src="images/screenshot2.png" height="500" alt="Font Settings" /> 
</p>

<a href="https://www.flaticon.com/free-icons/font" title="font icons">Font icons created by Vector Clans - Flaticon</a>
