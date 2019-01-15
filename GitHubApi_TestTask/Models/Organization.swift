import Foundation

struct Organization: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
