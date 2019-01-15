import UIKit

class UserDetailsModel {
    
    func requestUserDetails(user: User?, completion: @escaping (UserDetails?) -> Void) {
        guard let user = user else {
            completion(nil)
            return
        }
        guard let url = URL(string: "https://api.github.com/users/\(user.name)") else { return }
        Loader.fetchEntity(url: url, entity: UserDetails.self) { result in
            completion(result)
        }
    }
    
    func requestOrganizations(_ url: URL?, completion: @escaping ([Organization]?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }
        Loader.fetchEntity(url: url, entity: [Organization].self) { result in
            completion(result)
        }
    }
}
