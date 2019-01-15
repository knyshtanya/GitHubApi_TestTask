import Foundation

struct User: Codable {
    let name: String
    let avatar: URL?
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
        case id
    }
}
