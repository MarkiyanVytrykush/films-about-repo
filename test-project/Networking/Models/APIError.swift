//
//  APIError.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

enum APIError {
    case `default`(code: String = APIErrorCode.default.rawValue)
    case unathorized
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .default(let code):
            return (APIErrorCode(rawValue: code) ?? .default).localizedMessage
        case .unathorized:
            return "Unathorized"
        }
    }
}
