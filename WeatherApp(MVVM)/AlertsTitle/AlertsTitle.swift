import Foundation

enum AlertsTitle {
    case descriptionTitle
    case requestTitle
    case settings
    case cancel
    
    var title: String {
        switch self {
        case .descriptionTitle:
            return "Your location isn't enabled"
        case .requestTitle:
            return "Do you want activate location?"
        case .settings:
            return "Settings"
        case .cancel:
            return "Cancel"
        }
    }
}
