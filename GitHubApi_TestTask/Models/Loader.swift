import Foundation

struct Loader {
    
    static func fetchEntity<T: Codable>(url: URL, entity: T.Type, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode(entity, from: data)
                completion(result)
            }
            catch {
                print(error.localizedDescription)
                completion(nil)
            }
            }.resume()
    }
}
