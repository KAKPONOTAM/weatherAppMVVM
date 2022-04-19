import Foundation
import UIKit
import Kingfisher

class CurrentWeatherViewModel {
    var currentWeather = Bindable<CurrentWeatherInfo?>(nil)
    var weatherImageDescription = Bindable<UIImage?>(nil)
    var identifier = Bindable("HourlyWeatherCollectionViewModel")
    var temperature = Bindable<Int?>(nil)
    var temperatureFeelsLike = Bindable<Int?>(nil)
    var maximalTemperature = Bindable<Int?>(nil)
    var minimalTemperature = Bindable<Int?>(nil)
    var windSpeed = Bindable<Int?>(nil)
    var weatherDescription = Bindable<String?>(nil)
    
    func configureCurrentWeatherData(with currentWeatherData: CurrentWeatherInfo) {
        
        guard let weatherDescriptionImageIconId = currentWeatherData.weather?.first?.icon,
              let currentWeatherDescriptionImageURL = URL(string: "https://openweathermap.org/img/wn/\(weatherDescriptionImageIconId)@2x.png"),
              let temperature = currentWeatherData.main?.temp,
              let feelsLikeTemperature = currentWeatherData.main?.feels_like,
              let minimalTemperature = currentWeatherData.main?.temp_min,
              let windSpeed = currentWeatherData.wind?.speed,
              let weatherDescription = currentWeatherData.weather?.first?.description,
              let maximalTemperature = currentWeatherData.main?.temp_max else { return }
        
        KingfisherManager.shared.retrieveImage(with: currentWeatherDescriptionImageURL, options: nil, progressBlock: nil) { result in
               switch result {
               case .success(let retrievedImage):
                   self.weatherImageDescription.value = retrievedImage.image
               case .failure(let error):
                   print(error)
                   self.weatherImageDescription.value = nil
               }
           }
        
        self.temperature.value = (Int(temperature))
        self.temperatureFeelsLike.value = (Int(feelsLikeTemperature))
        self.maximalTemperature.value = Int(maximalTemperature)
        self.minimalTemperature.value = Int(minimalTemperature)
        self.windSpeed.value = Int(windSpeed)
        self.weatherDescription.value = weatherDescription
    }
}
