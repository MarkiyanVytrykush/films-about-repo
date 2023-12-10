//
//  APIClient.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

struct APIClient {
    
    private let networkService = NetworkService()
    private(set) lazy var moviesClient: MoviesClientProtocol = MoviesClient(networkService: networkService)
}
