import Foundation

struct HourlyForecast: Codable,Identifiable {
    var id: String = UUID().uuidString
    var dateTime: String?
    var epochDateTime, weatherIcon: Int?
    var iconPhrase: String?
    var hasPrecipitation, isDaylight: Bool?
    var temperature: Temperature?
    var precipitationProbability: Int?
    var mobileLink, link: String?
    
    var url: String {
        let formattedIcon = String(format: "%02d", weatherIcon ?? 0)
        return "https://developer.accuweather.com/sites/default/files/\(formattedIcon)-s.png"
    }
    
    var formattedDateTime:String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateStyle = .none
        outputFormatter.timeStyle = .short
        if let dateString = dateTime, let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        return "Unknown Date"
    }

    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case epochDateTime = "EpochDateTime"
        case weatherIcon = "WeatherIcon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case isDaylight = "IsDaylight"
        case temperature = "Temperature"
        case precipitationProbability = "PrecipitationProbability"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}


// MARK: - Temperature
struct Temperature: Codable {
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

typealias HourlyForecastResponse = [HourlyForecast]
