//
//  ContentView.swift
//  SwiftUIFontSettingsDemo
//
//  Created by Yingtao Guo on 5/1/24.
//

import SwiftUI
import SwiftUIFontSettingsView

struct ContentView: View {
    @State private var fontSettings: FontSettings = FontSettings()
    
    @State private var showFontSettings = false
    
    var body: some View {
        NavigationStack {
            Text("Font Settings Demo")
                .font(fontSettings.font)
                .foregroundStyle(fontSettings.foregroundColor)
                .background(fontSettings.backgroundColor)
                .navigationBarItems(trailing: Button("Font Settings") {
                    showFontSettings = true
                })
                .sheet(isPresented: $showFontSettings) {
                    NavigationStack {
                        FontSettingsView(fontSettings: $fontSettings).toolbar(content: {
                            Button("Done") {
                                showFontSettings = false
                            }
                        })
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
