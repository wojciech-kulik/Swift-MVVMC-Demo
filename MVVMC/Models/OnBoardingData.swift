import Foundation

struct OnBoardingData: Codable {
    let firstName: String
    let lastName: String
    let notifications: Bool
    let gpsTracking: Bool
}
