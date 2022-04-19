import Foundation
import UIKit
import Kingfisher

class HourlyWeatherCollectionViewModel {
    var identifier = Bindable("HourlyWeatherCollectionViewModel")
    var weatherImageDescription = Bindable<UIImage?>(nil)
    var date = Bindable<Int?>(nil)
    var weatherHour = Bindable<String?>(nil)
    var timeZoneOffset = Bindable<Int?>(nil)
    var hourTemperature = Bindable<Int?>(nil)
    var image = Bindable<UIImage?>(nil)
    
    func configureHourlyWeatherData(hourlyData: WeeklyWeatherData, indexPath: IndexPath) {
        guard let date = hourlyData.hourly?[indexPath.item].dt,
              let hourWeatherIconId = hourlyData.hourly?[indexPath.item].weather?.first?.icon,
              let hourWeatherDescriptionIconIdUrl = URL(string: "https://openweathermap.org/img/wn/\(hourWeatherIconId)@2x.png"),
              let timezoneOffset = hourlyData.timezone_offset,
              let temperature = hourlyData.hourly?[indexPath.item].temp else { return }
        
        let correctHour = Date.getCorrectHour(unixTime: date, timezoneOffset: timezoneOffset)
        
        KingfisherManager.shared.retrieveImage(with: hourWeatherDescriptionIconIdUrl, options: nil, progressBlock: nil) { result in
               switch result {
               case .success(let retrievedImage):
                   self.weatherImageDescription.value = retrievedImage.image
               case .failure(let error):
                   print(error)
                   self.weatherImageDescription.value = nil
               }
           }
       
        hourTemperature.value = (Int(temperature))
        weatherHour.value = correctHour
    }
}
