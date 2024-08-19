//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Melih on 8.08.2024.
//

import CoreLocation
import Foundation

final class WeatherManager {
    private let apiKey = Bundle.main.infoDictionary?["ACCUWEATHER_API_KEY"] as? String
    private let baseUrl: String = "http://dataservice.accuweather.com"
    var isCelcius: Bool {
        let selectedUnit = UserDefaults.standard.string(forKey: "selectedUnitTemperature") ?? "°C"
        return selectedUnit == "°C"
    }
    let selectedLanguage =  UserDefaults.standard.string(forKey: "selectedLocaleIdentifier")
    
    private func performRequest<T: Decodable>
    (urlString: String, responseType: T.Type, queryItems: [URLQueryItem]? = nil) async throws -> T {
        guard let apiKey = apiKey else {
            throw CustomError.apiKeyNotFound
        }

        guard var urlComponent = URLComponents(string: urlString) else {
            throw CustomError.invalidURL
        }

        urlComponent.queryItems = [URLQueryItem(name: "apikey", value: apiKey)]

        if let additionalQueryItems = queryItems {
            urlComponent.queryItems?.append(contentsOf: additionalQueryItems)
        }

        guard let url = urlComponent.url else {
            throw CustomError.urlConstructionFailed
        }

        let request = URLRequest(url: url)
        print("Request URL => \(url)")

        let session = URLSession.shared
        let (data, _) = try await session.data(for: request)

        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            print("Type => \(T.self) Decoded data =>\(decodedData)")
            return decodedData
        } catch {
            throw CustomError.decodingError(error)
        }
    }

    func getLocationKey(city: String) async throws -> LocationKey {
        let urlString = baseUrl + "/locations/v1/cities/search"
        
        let response: LocationKeyResponse = try await performRequest(
            urlString: urlString, 
            responseType: LocationKeyResponse.self,
            queryItems: [URLQueryItem(name: "q", value: city)]
        )
        
        guard let locationKey = response.first else {
            throw CustomError.locationKeyNotFound(city:city)
        }
        
        return locationKey
    }

    func getDailyWeather(locationKey: String) async throws -> DailyForecastResponse {
        guard !locationKey.isEmpty else {
             throw CustomError.invalidLocationKey
         }
        
        let urlString = baseUrl + "/forecasts/v1/daily/5day/\(locationKey)"
        return try await performRequest(
            urlString: urlString,
            responseType: DailyForecastResponse.self,
            queryItems: [
                URLQueryItem(name: "language", value: selectedLanguage),
                URLQueryItem(name: "metric", value: "\(isCelcius)")
            ]
        )
    }

    func getHourlyWeather(locationKey: String) async throws -> HourlyForecastResponse {
        guard !locationKey.isEmpty else {
             throw CustomError.invalidLocationKey
         }
        
        let urlString = baseUrl + "/forecasts/v1/hourly/12hour/\(locationKey)"
        return try await performRequest(
            urlString: urlString,
            responseType: HourlyForecastResponse.self,
            queryItems: [
                URLQueryItem(name: "language", value: selectedLanguage),
                URLQueryItem(name: "metric", value: "\(isCelcius)")
            ]
        )
    }
}

enum CustomError: LocalizedError {
    case apiKeyNotFound
    case invalidURL
    case urlConstructionFailed
    case locationKeyNotFound(city:String)
    case invalidLocationKey
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .apiKeyNotFound:
            return "API Key not found"
        case .invalidURL:
            return "Invalid URL"
        case .urlConstructionFailed:
            return "Failed to construct URL"
        case let .decodingError(error):
            return "Decoding error: \(error)"
        case let .locationKeyNotFound(city):
            return "Location key not found for city: \(city)"
        case .invalidLocationKey:
            return "Invalid location key provided"
        }
    }
}
