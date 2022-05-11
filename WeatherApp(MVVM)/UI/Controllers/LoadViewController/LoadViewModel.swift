import Foundation
import UIKit
import CoreLocation

class LoadViewModel {
    var currentWeatherData = Bindable<CurrentWeatherInfo?>(nil)
    var weeklyWeatherData = Bindable<WeeklyWeatherData?>(nil)
    var isLocationServiceEnabled = Bindable<Bool?>(nil)
    var locationDisabledDescriptionAlert = Bindable<UIAlertController?>(nil)
    var weatherViewController = Bindable<WeatherDataViewController?>(nil)
    var cityName = Bindable<String?>(nil)
    
    func checkGeoDataEnabled(locationManager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            isLocationServiceEnabled.value = true
            checkAuthorizationStatus(locationManager: locationManager)
        }
        
        if !CLLocationManager.locationServicesEnabled() {
            isLocationServiceEnabled.value = false
        }
    }
    
    func checkAuthorizationStatus(locationManager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            guard let lon = locationManager.location?.coordinate.longitude,
                  let lat = locationManager.location?.coordinate.latitude else { return }
            
            WeatherNetworkManager.shared.fetchRequestDataForWeatherWhenUserFirstOpenedApp(lon: lon, lat: lat) { [weak self] currentWeather in
                guard let currentWeather = currentWeather,
                      let self = self else { return }
                
                self.currentWeatherData.value = currentWeather
                
                guard let cityName = self.currentWeatherData.value?.name else { return }
                self.cityName.value = cityName
                
                WeatherNetworkManager.shared.fetchRequestDataForWeeklyWeather(lon: lon, lat: lat) { [weak self] weeklyWeatherInfo in
                    guard let weeklyWeatherInfo = weeklyWeatherInfo,
                          let self = self else { return }
                    self.weeklyWeatherData.value = weeklyWeatherInfo
                    
                    self.weatherViewController.value = WeatherDataViewController(currentWeatherData: self.currentWeatherData.value, weeklyWeatherData: self.weeklyWeatherData.value, cityName: self.cityName.value)
                }
            }
            
        case.denied:
            WeatherNetworkManager.shared.fetchRequestDataForCurrentWeather(cityName: "Москва") { [weak self] currentWeatherInfo in
                guard let currentWeatherInfo = currentWeatherInfo,
                      let self = self else { return }
                self.currentWeatherData.value = currentWeatherInfo
                
                guard let lon = self.currentWeatherData.value?.coord?.lon,
                      let cityName = self.currentWeatherData.value?.name,
                      let lat = self.currentWeatherData.value?.coord?.lat else { return }
                
                self.cityName.value = cityName
                
                WeatherNetworkManager.shared.fetchRequestDataForWeeklyWeather(lon: lon, lat: lat) { [weak self] weeklyWeatherInfo in
                    guard let weeklyWeatherInfo = weeklyWeatherInfo,
                          let self = self else { return }
                    self.weeklyWeatherData.value = weeklyWeatherInfo
                    
                    self.weatherViewController.value = WeatherDataViewController(currentWeatherData: self.currentWeatherData.value, weeklyWeatherData: self.weeklyWeatherData.value, cityName: self.cityName.value)
                    
                }
            }
            
        default:
            break
            
        }
    }
    
    func locationDisabledDescriptionAlertInitialization() {
        switch isLocationServiceEnabled.value {
        case false:
            locationDisabledDescriptionAlert.value = UIAlertController(title: AlertsTitle.descriptionTitle.title, message: AlertsTitle.requestTitle.title, preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: AlertsTitle.settings.title, style: .default) { _ in
                guard let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            let cancelAction = UIAlertAction(title: AlertsTitle.cancel.title, style: .cancel, handler: nil)
            
            locationDisabledDescriptionAlert.value?.addAction(settingsAction)
            locationDisabledDescriptionAlert.value?.addAction(cancelAction)
            
        case true:
            locationDisabledDescriptionAlert.value = nil
            
        default:
            break
        }
    }
}
