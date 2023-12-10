//
//  SpokenLanguage.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName: String
    let iso639_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name = "name"
    }
}
