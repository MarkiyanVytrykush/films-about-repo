//
//  Extension+Encodable.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

extension Encodable {
    var data: Data? {
        try? CodableService.defaultEncoder.encode(self)
    }
}
