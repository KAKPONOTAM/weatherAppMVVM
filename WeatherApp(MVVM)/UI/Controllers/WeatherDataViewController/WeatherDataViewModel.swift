import Foundation
import UIKit

class WeatherDataViewModel {
    var currentWeatherData = Bindable<CurrentWeatherInfo?>(nil)
    var weeklyWeatherData = Bindable<WeeklyWeatherData?>(nil)
    var cityName = Bindable<String?>(nil)
    var cityListViewController = Bindable<CitiesListViewController>(CitiesListViewController())
    
    var delegate: CitiesViewModelDelegate?
    
    func fetchRequestBy(cityName: String, completion: @escaping () -> ()?) {
        WeatherNetworkManager.shared.fetchRequestDataForCurrentWeather(cityName: cityName) { [weak self] currentWeatherInfo in
            guard let currentWeatherInfo = currentWeatherInfo else { return }
            self?.currentWeatherData.value = currentWeatherInfo
            self?.cityName.value = cityName
            
            guard let lon = self?.currentWeatherData.value?.coord?.lon,
                  let lat = self?.currentWeatherData.value?.coord?.lat else { return }
            
            WeatherNetworkManager.shared.fetchRequestDataForWeeklyWeather(lon: lon, lat: lat) { [weak self] weeklyWeatherInfo in
                guard let weeklyWeatherInfo = weeklyWeatherInfo else { return }
                self?.weeklyWeatherData.value = weeklyWeatherInfo
                
                completion()
            }
        }
    }
    
    func getSectionAmount() -> Int {
        CellDetails.getAmountOfSections()
    }
}

