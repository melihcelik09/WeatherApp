//
//  LocationKey.swift
//  WeatherApp
//
//  Created by Melih on 9.08.2024.
//

import Foundation

// MARK: - LocationKey

struct LocationKey: Codable {
    var key: String?
    var localizedName, englishName: String?
    var country: Country?
    var geoPosition: GeoPosition?

    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case country = "Country"
        case geoPosition = "GeoPosition"
    }
}

// MARK: - Country

struct Country: Codable {
    let id, localizedName, englishName: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - GeoPosition

struct GeoPosition: Codable {
    let latitude, longitude: Double?

    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}

typealias LocationKeyResponse = [LocationKey]
