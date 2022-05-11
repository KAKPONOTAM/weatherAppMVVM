import Foundation

enum SectionsType: Int, CaseIterable {
    case current
    case hourly
    case weekly
    case sunriseAndSunset
    
    var titleForRow: String {
        switch self {
        case .current:
            return "current weather"
        case .hourly:
            return "hourly weather"
        case .weekly:
            return "weekly weather"
        case .sunriseAndSunset:
            return "sunrise and sunset time"
        }
    }
    
    static func getAmountOfSections() -> Int {
        return allCases.count
    }
    
    static func getRow(index: Int) -> Self {
        return allCases[index]
    }
}
