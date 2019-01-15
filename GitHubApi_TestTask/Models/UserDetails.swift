import Foundation

struct UserDetails: Codable {
    let name: String
    let avatar: URL?
    let id: Int
    let email: String?
    let organization: URL?
    let following: Int
    let followers: Int
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
        case id
        case email
        case organization = "organizations_url"
        case following
        case followers
        case createdAt = "created_at"
    }
}
