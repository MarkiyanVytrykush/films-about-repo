//
//  Storyboard+Extension.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

// MARK: - UIStoryboard
extension UIStoryboard {
    
    // MARK: - Types
    
    enum Storyboard: String {
        
        case moviesList = "MoviesList"
        case movieDetails = "MovieDetails"
        case characterList = "CharacterList"
        
        // MARK: - Properties
        
        var name: String {
            return rawValue
        }
    }
    
    // MARK: - Initialization
    
    convenience init(_ storyboard: Storyboard) {
        self.init(name: storyboard.name, bundle: nil)
    }
    
    // MARK: - Public methods
    
    func instantiateViewController<T: UIViewController>() -> T {
        return self.instantiateViewController(withIdentifier: T.identifier) as! T
    }
}

