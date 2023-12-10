//
//  MovieResult.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

// MARK: MovieResult
struct MovieResult: Codable {
    
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
