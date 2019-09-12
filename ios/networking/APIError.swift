//
//  APIError.swift
//  4 The Festivals
//
//  Created by Rene Gens on 13/07/2019.
//  Copyright © 2019 Rene Gens. All rights reserved.
//

import Foundation

enum APIError: Error {

    case networkingError(Error)
    case serverError // HTTP 5xx
    case requestError(Int, String) // HTTP 4xx
    case invalidResponse
    case decodingError(DecodingError)
    case malformedURL

}
