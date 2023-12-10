//
//  CitiesClient.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

// MARK: - MoviesClientProtocol
protocol MoviesClientProtocol {
    @discardableResult
    func getMovies(page: Int, completion: @escaping NetworkCompletionBlock<MovieResult>) -> URLSessionDataTask?
    @discardableResult
    func getMovieDetails(movieId: String, completion: @escaping NetworkCompletionBlock<MovieDetailsResult>) -> URLSessionDataTask?
}

// MARK: - CitiesClient
final class MoviesClient: MoviesClientProtocol {
    
    // MARK: - Private Properies
    private let networkService: NetworkService
    
    // MARK: - Initialization
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Public Methods
    @discardableResult
    func getMovies(page: Int, completion: @escaping NetworkCompletionBlock<MovieResult>) -> URLSessionDataTask? {
        let route = MoviesRouter(endpoint: .getMovies(page: "\(page)"))
        return networkService.performRequest(route: route, completion: completion)
    }
    
    func getMovieDetails(movieId: String, completion: @escaping NetworkCompletionBlock<MovieDetailsResult>) -> URLSessionDataTask? {
        let route = MovieDetailsRouter.init(endpoint: .getMovieDetails(movieId: movieId))
        return networkService.performRequest(route: route, completion: completion)
    }
}
