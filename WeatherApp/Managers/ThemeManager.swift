//
//  ThemeManager.swift
//  WeatherApp
//
//  Created by Melih on 16.08.2024.
//

import Foundation
import SwiftUI

class ThemeManager : ObservableObject{
    
    @AppStorage("selectedTheme") private var storedTheme: String = Theme.systemDefault.rawValue
    
    @Published var selectedTheme: Theme = .systemDefault {
        didSet{
            storedTheme = selectedTheme.rawValue
        }
    }
    
    func changeTheme(_ theme : Theme){
        selectedTheme = theme
    }
}

enum Theme : String,CaseIterable{
    case systemDefault = "System"
    case dark = "Dark"
    case light = "Light"
    
    var description: String{
        return self.rawValue
    }
    
    var colorScheme: ColorScheme?{
        switch self {
        case .systemDefault:
            return nil
        case .dark:
            return .dark
        case .light:
            return .light
        }
    }
    
    var displayName: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
