import Foundation

enum SectionsType: CaseIterable {
    case current
    case weekly
    case hourly
    case sunriseAndSunset
    
    static func getAmountOfSections() -> Int {
        return allCases.count
    }
}
