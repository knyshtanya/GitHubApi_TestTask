import Foundation

class UsersModel {
    
    private var users = [User]()
    
    var usersCount: Int {
        return users.count
    }
    
    subscript (_ index: Int) -> User {
        return users[index]
    }
    
    func requestUsers(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.github.com/users") else {
            completion()
            return
        }
        Loader.fetchEntity(url: url, entity: [User].self) { [weak self] result in
            if let result = result {
                self?.users = result
                completion()
            }
        }
    }
    
    func requestNextUsers(completion: @escaping () -> Void) {
        guard let id = users.last?.id, let url = URL(string: "https://api.github.com/users?since=\(id)") else {
            completion()
            return
        }
        Loader.fetchEntity(url: url, entity: [User].self) { [weak self] result in
            if let result = result {
                self?.users.append(contentsOf: result)
                completion()
            }
        }
    }
}
