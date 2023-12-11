//
//  UIImageView+Exteions.swift
//  test-project
//
//  Created by DS on 11.12.2023.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(from url: String?, placeholder: UIImage? = nil, completion: ((UIImage?) -> Void)? = nil) {
    
        ImageLoader.shared.loadImage(from: url, placeholder: placeholder) { [weak self] (image) in
            self?.image = image
            completion?(image)
        }
    }
}
