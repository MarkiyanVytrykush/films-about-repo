//
//  Log.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation

final class Log {
    
    // MARK: - Private Static Properties
    private static let isActive = true
    private static let dateFormatter: DateFormatter = {
        $0.dateFormat = "HH:mm:ss.SSS"
        return $0
    }(DateFormatter())
    
    // MARK: - Static Methods
    static func error(_ message: String) {
        Log.aprint(message, emoji: "⛔")
    }
    
    static func atention(_ message: String) {
        Log.aprint(message, emoji: "⚠️")
    }
    
    static func action(_ message: String) {
        Log.aprint(message, emoji: "✅")
    }
    
    static func aprint(_ text: String, emoji: String = "") {
        guard isActive else {
            return
        }

        #if DEBUG
        print("\(emoji) [\(currentDate())]: \(text)")
        print("=============================================================\n")
        #endif
    }
    
    // MARK: - Private Static Methods
    private static func currentDate() -> String {
        dateFormatter.string(from: Date())
    }
}
