//
//  APIConfiguration.swift
//  4 The Festivals
//
//  Created by Rene Gens on 17/07/2019.
//  Copyright © 2019 Rene Gens. All rights reserved.
//
import Foundation

enum Router {
    case getImages
    case loginWithFacebook(body: [String: Any])
    private static let baseURLString = "https://api.forthefestivals.gr/api/"

    private enum HTTPMethod {
        case get
        case post
        case put
        case delete

        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .delete: return "DELETE"
            }
        }
    }

    private var method: HTTPMethod {
        switch self {
        case .getImages: return .get
        case .loginWithFacebook: return .post
        }
    }

    private var path: String {
        switch self {
        case .getImages:
            return "v1/images"
        case .loginWithFacebook:
            return "v1/authenticate/facebook"
        }
    }

    func request() throws -> URLRequest {
        let urlString = "\(Router.baseURLString)\(path)"

        guard let url = URL(string: urlString) else {
            throw APIError.malformedURL
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        switch self {
        case .getImages:
            return request
        case .loginWithFacebook(let body):
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            return request
        }
    }

    func getImages(completion: @escaping (Result<[String], APIError>) -> Void) {
        APIService().perform(router: .getImages, completion: APIService().parseDecodable(completion: completion))
    }

    func loginWithFacebook(token: String, completion: @escaping (Result<User, APIError>) -> Void) {
        APIService().perform(router: .loginWithFacebook(body: ["accessToken": token]), completion: APIService().parseDecodable(completion: completion))
    }
}
