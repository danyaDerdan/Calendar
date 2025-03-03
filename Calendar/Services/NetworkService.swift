import Foundation

protocol NetworkServiceProtocol {
    func fetchImage(stringUrl: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    func fetchImage(stringUrl: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: stringUrl) else {
            completion(.failure(Errors.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error { completion(.failure(error)) }
            guard let data else { completion(.failure(Errors.invalidData)); return }
            completion(.success(data))
        }.resume()
    }
}

private enum Errors: Error {
    case invalidUrl
    case invalidData
}

