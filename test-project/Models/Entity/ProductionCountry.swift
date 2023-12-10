//
//  ProductionCountry.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name = "name"
    }
}
