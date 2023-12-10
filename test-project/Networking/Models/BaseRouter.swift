//
//  BaseRouter.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

class BaseRouter {
    
    var imageUploadBaseURL: String {
        return "https://image.tmdb.org/t/p/w500"
    }
    var baseUrl: String {
        "https://api.themoviedb.org/3"
    }

    var method: HTTPMethod {
        fatalError("You have to override method property")
    }

    var apiKey: String {
        return "403358fd328e6cd9874d92e583fe147b"
    }
    
    var path: String {
        return ""
    }

    var headers: [String: String]? {
        return nil
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var body: Data? {
        return nil
    }

    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(string: baseUrl)!

        components.path = path
        components.queryItems = queryItems

        var queryItemsWithApiKey = components.queryItems ?? []
        queryItemsWithApiKey.append(URLQueryItem(name: "api_key", value: apiKey))
        components.queryItems = queryItemsWithApiKey

        guard let url = components.url else {
            throw APIError.default(code: "404")
        }

        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        headers?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}
