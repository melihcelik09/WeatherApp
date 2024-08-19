//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Melih on 8.08.2024.
//

import CoreLocation
import Foundation

@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    var location: CLLocationCoordinate2D?
    var status: CLAuthorizationStatus?
    var cityName: String = ""
    var onCityNameUpdate: ((String)->Void)?

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }

    func getCityName(for coordinate: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error{
                print("Geocoding error \(error.localizedDescription)")
                return
            }
            guard let placemark = placemarks?.first else { return }
            DispatchQueue.main.async {
                self.cityName = placemark.locality ?? ""
                print("City Name => \(self.cityName)")
                self.onCityNameUpdate?(self.cityName)
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            status = .authorizedWhenInUse
            manager.requestLocation()
            break
        case .restricted:
            status = .restricted
            break
        case .denied:
            status = .denied
            break
        case .notDetermined:
            status = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else { return }
        location = firstLocation.coordinate
        print("Location Manager => \(location ?? CLLocationCoordinate2D())")
        getCityName(for: firstLocation.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error getting location", error)
    }
}
