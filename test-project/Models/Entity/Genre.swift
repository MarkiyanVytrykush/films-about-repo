//
//  Genre.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
