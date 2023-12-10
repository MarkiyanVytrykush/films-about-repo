//
//  MovieDetailsRouter.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

// MARK: - MoviesEndpoint
enum MovieDetailsEndpoint {
    case getMovieDetails(movieId: String)
}

// MARK: - MovieDetailsRouter
final class MovieDetailsRouter: BaseRouter {
    // MARK: - Private Properies
    private let endpoint: MovieDetailsEndpoint
    
    // MARK: - Initialization
    init(endpoint: MovieDetailsEndpoint) {
        self.endpoint = endpoint
    }
    
    // MARK: - Public Properies
    override var path: String {
        switch endpoint {
        case .getMovieDetails(let movieId):
            return "/3/movie/\(movieId)"
        }
    }

    override var method: HTTPMethod {
        switch endpoint {
        case .getMovieDetails:
            return .get
        }
    }

    override var queryItems: [URLQueryItem]? {
        switch endpoint {
        case .getMovieDetails:
            return nil
        }
    }
    
    override var body: Data? {
        switch endpoint {
        case .getMovieDetails:
            return nil
        }
    }
}
