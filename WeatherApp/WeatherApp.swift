//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Melih on 8.08.2024.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject var appLanguage = LanguageManager()
    @StateObject var appTheme = ThemeManager()
    @StateObject var appUnit = UnitManager()
    var body: some Scene {
        WindowGroup {
            WeatherTabView()
                .environmentObject(appLanguage)
                .environmentObject(appTheme)
                .environment(\.locale, appLanguage.selectedLocale)
                .preferredColorScheme(appTheme.selectedTheme.colorScheme)
                .environmentObject(appUnit)
        }
    }
}
