//
//  Pagination.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

struct Pagination<T: Decodable>: Decodable {
    let items: [T]
    let pageNumber: Int
    let totalPages: Int
    let totalCount: Int
}
