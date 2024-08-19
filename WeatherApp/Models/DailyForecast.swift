//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by Melih on 9.08.2024.
//

import Foundation


//MARK: - DailyForecastResponse

struct DailyForecastResponse : Codable{
    let headline: Headline
    let dailyForecasts:[DailyForecast]
    
    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
}

// MARK: - DailyForecast
struct DailyForecast: Codable,Identifiable {
    var id: String = UUID().uuidString
    var date: String?
    var epochDate: Int?
    var temperature: MinMaxTemperature?
    var day, night: Day?
    var sources: [String]?
    var mobileLink, link: String?
    
    var formatteddate:String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM"
        if let dateString = date, let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return "Unknown Date"
    }

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

// MARK: - Day
struct Day: Codable {
    var icon: Int?
    var iconPhrase: String
    var hasPrecipitation: Bool?
    var url: String {
        let formattedIcon = String(format: "%02d", icon ?? 0)
        return "https://developer.accuweather.com/sites/default/files/\(formattedIcon)-s.png"
    }

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
    }
}

// MARK: - Temperature
struct MinMaxTemperature: Codable {
    var minimum, maximum: Imum?
    var daily: String {
        "\(minimum?.format ?? "") - \(maximum?.format ?? "")"
    }

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - Imum
struct Imum: Codable {
    var value: Double?
    var unit: String?
    var unitType: Int?
    var format: String {
        "\(value ?? 0) \(unit ?? "")"
    }

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}


// MARK: - Headline
struct Headline: Codable {
    var effectiveDate: String?
    var effectiveEpochDate, severity: Int?
    var text, category: String?
    var endDate: String?
    var endEpochDate: Int?
    var mobileLink, link: String?

    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

