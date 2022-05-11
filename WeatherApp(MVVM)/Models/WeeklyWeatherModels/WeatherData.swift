import Foundation

struct WeeklyWeatherData: Decodable {
    let timezone_offset: Int?
    let daily: [WeeklyWeatherTemperatureTypes]?
    let wind_speed: Double?
    let hourly: [HourlyWeatherDescription]?
}

struct Temperature: Decodable {
    let min: Double
    let max: Double
    let day: Double
}

struct WeeklyWeatherTemperatureTypes: Decodable {
    let dt: Int
    let temp: Temperature
    let feels_like: TemperatureFeelsLike
    let weather: [WeeklyWeatherDescriptionIcon]
}

struct TemperatureFeelsLike: Decodable {
    let day: Double
}

class WeeklyWeatherDescriptionIcon: Decodable {
    let icon: String
}

