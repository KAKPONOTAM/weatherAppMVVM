import Foundation
import Kingfisher

class DailyWeatherViewModel {
    var weekDay = Bindable<String?>(nil)
    var maximalTemperature = Bindable<Int?>(nil)
    var minimalTemperature = Bindable<Int?>(nil)
    var temperature = Bindable<Int?>(nil)
    var weatherImageDescription = Bindable<UIImage?>(nil)
    
    func configureDailyWeatherData(with weeklyWeatherData: WeeklyWeatherData, indexPath: IndexPath) {
        guard let iconId = weeklyWeatherData.daily?[indexPath.row].weather?.first?.icon,
              let iconUrl = URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png"),
              let weekDay = weeklyWeatherData.daily?[indexPath.row].dt,
              let temperature = weeklyWeatherData.daily?[indexPath.row].temp?.day,
              let maximalTemperature = weeklyWeatherData.daily?[indexPath.row].temp?.max,
              let minimalTemperature = weeklyWeatherData.daily?[indexPath.row].temp?.min else { return }
        
        KingfisherManager.shared.retrieveImage(with: iconUrl, options: nil, progressBlock: nil) { result in
               switch result {
               case .success(let retrievedImage):
                   self.weatherImageDescription.value = retrievedImage.image
               case .failure(let error):
                   print(error)
                   self.weatherImageDescription.value = nil
               }
           }
        
        let correctDay = Date.getCorrectDay(unixTime: weekDay)
        
        self.weekDay.value = correctDay
        self.temperature.value = (Int(temperature))
        self.maximalTemperature.value = (Int(maximalTemperature))
        self.minimalTemperature.value = (Int(minimalTemperature))
    }
}
