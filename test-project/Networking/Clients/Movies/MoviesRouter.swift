//
//  CitiesRouter.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

// MARK: - MoviesEndpoint
enum MoviesEndpoint {
    case getMovies(page: String)
}

// MARK: - MoviesRouter
final class MoviesRouter: BaseRouter {
    
    // MARK: - Private Properies
    private let endpoint: MoviesEndpoint
    
    // MARK: - Initialization
    init(endpoint: MoviesEndpoint) {
        self.endpoint = endpoint
    }
    
    // MARK: - Public Properies
    override var path: String {
        switch endpoint {
        case .getMovies:
            return "/3/movie/top_rated"
        }
    }

    override var method: HTTPMethod {
        switch endpoint {
        case .getMovies:
            return .get
        }
    }

    override var queryItems: [URLQueryItem]? {
        switch endpoint {
        case .getMovies(let page):
            return nil
        }
    }
    
    override var body: Data? {
        switch endpoint {
        case .getMovies:
            return nil
        }
    }
}
