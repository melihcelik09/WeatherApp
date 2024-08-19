//
//  LanguageManager.swift
//  WeatherApp
//
//  Created by Melih on 16.08.2024.
//

import Foundation
import SwiftUI

class LanguageManager: ObservableObject {
    @AppStorage("selectedLocaleIdentifier") private var storedLocaleIdentifier: String = Locale(identifier: "en").identifier
    
    @Published var languageList: [Locale] = [.init(identifier: "tr"), .init(identifier: "en")]
    @Published var selectedLocale: Locale = Locale(identifier: "en") {
        didSet {
            storedLocaleIdentifier = selectedLocale.identifier
        }
    }

    func setLocale(_ locale: Locale) {
        selectedLocale = locale
    }
}

