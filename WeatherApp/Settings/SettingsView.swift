//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Melih on 8.08.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var language: LanguageManager
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var unit: UnitManager
    var body: some View {
        Form {
            Section("Settings") {
                Picker("Theme", selection: $theme.selectedTheme) {
                    ForEach(Theme.allCases, id: \.self) {
                        Text($0.displayName)
                    }
                }.onChange(of: theme.selectedTheme) { _, newValue in
                    theme.changeTheme(newValue)
                }
                Picker("Language", selection: $language.selectedLocale) {
                    ForEach(language.languageList, id: \.identifier) {
                        Text("\($0.language.languageCode ?? "")".uppercased())
                            .tag($0)
                    }
                }.onChange(of: language.selectedLocale) { _, newValue in
                    language.setLocale(newValue)
                }
                Picker("Units", selection: $unit.selectedUnit) {
                  
                    ForEach(unit.supportedUnits, id: \.self) {
                        Text($0.symbol).tag($0)
                    }
                }.pickerStyle(.segmented)
                .onChange(of: unit.selectedUnit) { _, newValue in
                    unit.changeUnit(newValue)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(LanguageManager())
        .environmentObject(ThemeManager())
        .environmentObject(UnitManager())
}
