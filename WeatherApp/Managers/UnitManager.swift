//
//  UnitManager.swift
//  WeatherApp
//
//  Created by Melih on 16.08.2024.
//

import Foundation
import SwiftUI

class UnitManager: ObservableObject {
    @AppStorage("selectedUnitTemperature") private var selectedUnitTemperature: String = UnitTemperature.celsius.symbol
    @Published var supportedUnits: [UnitTemperature] = [.celsius, .fahrenheit]
    @Published var selectedUnit: UnitTemperature = .celsius {
        didSet{
            selectedUnitTemperature = selectedUnit.symbol
        }
    }

    func changeUnit(_ unit: UnitTemperature) {
        selectedUnit = unit
    }
}
