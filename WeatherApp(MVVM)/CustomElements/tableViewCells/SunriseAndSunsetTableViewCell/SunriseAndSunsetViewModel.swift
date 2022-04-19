import Foundation

class SunriseAndSunsetViewModel {
    var sunriseTime = Bindable<String?>(nil)
    var sunsetTime = Bindable<String?>(nil)
    
    func configureSunriseAndSunsetTime(with sunriseAndSunsetTime: CurrentWeatherInfo) {
        guard let sunriseUnixTime = sunriseAndSunsetTime.sys?.sunrise,
              let sunsetUnixTime = sunriseAndSunsetTime.sys?.sunset else { return }
        
        let sunsetTime = Date.getCorrectTimeForSunriseAndSunset(unixTime: sunsetUnixTime)
        let sunriseTime = Date.getCorrectTimeForSunriseAndSunset(unixTime: sunriseUnixTime)
        
        self.sunriseTime.value = sunriseTime
        self.sunsetTime.value = sunsetTime
    }
}
