import Foundation

struct CityNamesData: Decodable {
    var city: [CityNames]
}


struct CityNames: Decodable {
    var name: String
}


