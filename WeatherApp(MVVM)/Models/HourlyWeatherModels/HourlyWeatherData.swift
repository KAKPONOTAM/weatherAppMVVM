import Foundation

struct HourlyWeatherDescription: Decodable {
    let dt: Int
    let temp: Double
    let weather: [HourlyWeatherImageDescription]
}

struct HourlyWeatherImageDescription: Decodable {
    let icon: String
}

