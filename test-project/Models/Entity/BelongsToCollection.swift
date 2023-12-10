//
//  BelongsToCollection.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath: String
    let backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
