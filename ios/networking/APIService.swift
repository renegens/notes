//
//  TopPodcastsAPI.swift
//  PodcastApp
//
//  Created by Ben Scheirman on 4/10/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//

import Foundation

class APIService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getImages(completion: @escaping (Result<[String], APIError>) -> Void) {
        perform(router: Router.getImages, completion: parseDecodable(completion: completion))
    }

    func loginWithFacebook(token: String, completion: @escaping (Result<User, APIError>) -> Void) {
        perform(router: Router.loginWithFacebook(body: ["accessToken": token]), completion: parseDecodable(completion: completion))
    }

    func parseDecodable<T: Decodable>(completion: @escaping (Result<T, APIError>) -> Void) -> (Result<Data, APIError>) -> Void {
        return { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let object = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(object))
                    }
                } catch let decodingError as DecodingError {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError(decodingError)))
                    }
                } catch {
                    fatalError("Unhandled error raised.")
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func perform(router: Router, completion: @escaping (Result<Data, APIError>) -> Void) {
        do {
            let task = try session.dataTask(with: router.request()) { data, response, error in
                if let error = error {
                    completion(.failure(.networkingError(error)))
                    return
                }

                guard let http = response as? HTTPURLResponse, let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }

                switch http.statusCode {
                case 200:
                    completion(.success(data))

                case 400...499:
                    let body = String(data: data, encoding: .utf8)
                    completion(.failure(.requestError(http.statusCode, body ?? "<no body>")))

                case 500...599:
                    completion(.failure(.serverError))

                default:
                    fatalError("Unhandled HTTP status code: \(http.statusCode)")
                }
            }
            task.resume()
        } catch {
            completion(.failure(.malformedURL))
        }
    }
}
