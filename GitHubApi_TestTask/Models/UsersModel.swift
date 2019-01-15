import Foundation

class UsersModel {
    
    private var users = [User]()
    
    var usersCount: Int {
        return users.count
    }
    
    subscript (_ index: Int) -> User {
        return users[index]
    }
    
    // MARK: - Request users
    
    func requestUsers(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.github.com/users") else {
            completion()
            return
        }
        Loader.fetchEntity(url: url, entity: [User].self) { [weak self] result in
            guard let result = result else {
                completion()
                return
            }
            self?.users = result
            completion()
        }
    }
    
    // MARK: - Request next page users
    
    func requestNextUsers(completion: @escaping () -> Void) {
        guard let id = users.last?.id, let url = URL(string: "https://api.github.com/users?since=\(id)") else {
            completion()
            return
        }
        Loader.fetchEntity(url: url, entity: [User].self) { [weak self] result in
            guard let result = result else {
                completion()
                return
            }
            self?.users.append(contentsOf: result)
            completion()
        }
    }
}
