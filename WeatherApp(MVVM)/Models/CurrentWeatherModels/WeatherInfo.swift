import Foundation

struct CurrentWeatherInfo: Decodable {
    let weather: [Weather]?
    let main: Main?
    let wind: Wind?
    let name: String?
    let coord: CurrentWeatherCoordinates?
    let sys: SunriseAndSunsetTime?
}

struct Wind: Decodable {
    let speed: Double
}

struct SunriseAndSunsetTime: Decodable {
    let sunrise: Int
    let sunset: Int
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

struct CurrentWeatherCoordinates: Decodable {
    let lon: Double
    let lat: Double
}

struct Main: Decodable {
    let temp: Double
    let temp_max: Double
    let temp_min: Double
    let feels_like: Double
}

