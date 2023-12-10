//
//  ErrorResponce.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

struct ErrorResponse: Decodable {
    let code: String
    let message: String

    var apiError: APIError {
        .default(code: code)
    }
}
