import Foundation

class HourlyWeatherViewModel {
    var hourlyWeatherData = Bindable<WeeklyWeatherData?>(nil)
    
    func initHourlyWeatherData(with hourlyWeatherData: WeeklyWeatherData?) {
        self.hourlyWeatherData.value = hourlyWeatherData
    }
}
