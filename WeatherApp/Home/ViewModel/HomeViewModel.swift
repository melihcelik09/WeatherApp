//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Melih on 8.08.2024.
//

import Foundation

@Observable
class HomeViewModel {
    private var locationManager = LocationManager()
    private var weatherManager = WeatherManager()
    var daily = [DailyForecast]()
    var hourly: HourlyForecastResponse = []
    var current: HourlyForecast?
    var locationKey: String?
    var locationName: String?
    var searchTerm: String = ""

    init() {
        locationManager.onCityNameUpdate = { cityName in
            Task {
                print("locationManager.cityName => \(cityName)")
                await self.getLocationKey(value: cityName)
            }
        }
        locationManager.manager.requestLocation()
    }

    func getLocationKey(value: String) async {
        do {
            let response = try await weatherManager.getLocationKey(city: value)
            print("Response = \(response)")
            locationKey = response.key
            locationName = response.localizedName
            await getHourly()
            await getDaily()
        } catch {
            print(error)
        }
    }

    func getHourly() async {
        do {
            guard let locationKey = locationKey else { return }
            hourly = try await weatherManager.getHourlyWeather(locationKey: locationKey)
            current = hourly.first
            hourly.removeFirst()
            print("Current =>\(current ?? HourlyForecast())")
            print("Hourly =>\(hourly)")
        } catch {
            print(error.localizedDescription)
        }
    }

    func getDaily() async {
        do {
            guard let locationKey = locationKey else { return }
            let response = try await weatherManager.getDailyWeather(locationKey: locationKey)
            daily = response.dailyForecasts
            print("Daily => \(daily)")
        } catch {
            print(error.localizedDescription)
        }
    }
}
