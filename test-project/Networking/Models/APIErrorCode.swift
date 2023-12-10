//
//  APIErrorCode.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

enum APIErrorCode: String {
    // MARK: - Default
    case `default` = "Please try again later"

}

extension APIErrorCode {
    var localizedMessage: String {
        rawValue
    }
}
