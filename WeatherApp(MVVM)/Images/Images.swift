import Foundation
import UIKit

enum Images {
    case presentCityListButtonImage
    case loadViewControllerTitleImage
    case weatherViewControllerTitleImage
    case sunriseImage
    case sunsetImage
    
    var titleImage: UIImage? {
        switch self {
        case .presentCityListButtonImage:
            return UIImage(systemName: "magnifyingglass")
        case .loadViewControllerTitleImage:
            return UIImage(named: "greetingImage")
        case .weatherViewControllerTitleImage:
            return UIImage(named: "backgroundImage")
        case .sunriseImage:
            return UIImage(named: "sunrise")
        case .sunsetImage:
            return UIImage(named: "sunset")
        }
    }
}
