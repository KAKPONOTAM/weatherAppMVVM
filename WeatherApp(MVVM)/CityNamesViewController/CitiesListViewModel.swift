import Foundation
protocol CitiesViewModelDelegate: AnyObject {
    func requestForPickedCity(cityName: String)
}

class CitiesListViewModel {
    var cityNamesData = Bindable<[CityNames]?>(nil)
    var citiesList = Bindable<CityNamesData?>(nil)
    var filteredCityNames = Bindable<[String?]>([])
    var cityNames = Bindable<[String]>([])
    
    weak var delegate: CitiesViewModelDelegate?
    
    func getCitiesList() {
        CitiesJSONAutoParts.shared.citiesJSONAutoParts { [weak self] citiesList in
            guard let citiesList = citiesList,
                  let self = self,
                      let cityNames = citiesList.city else  { return }
            
            self.citiesList.value = citiesList
            self.cityNamesData.value = cityNames
        }
        
        guard let citiesListValue = citiesList.value?.city else { return }
        
        for value in citiesListValue {
            guard let cityName = value.name else { return }
            cityNames.value.append(cityName)
        }
        
        filteredCityNames.value = cityNames.value
    }
    
    func changeEditing(textFieldText: String?) {
        guard let textFieldText = textFieldText else { return }
        
        switch textFieldText.isEmpty {
        case true:
            filteredCityNames.value = []
            
        case false:
            filteredCityNames.value = cityNames.value.filter { $0.lowercased().contains(textFieldText.lowercased()) }
        }
    }
    
    func getDataForPickedCityName(with cityName: String) {
        delegate?.requestForPickedCity(cityName: cityName)
    }
}
