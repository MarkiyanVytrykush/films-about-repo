//
//  CustomNavigationController.swift
//  test-project
//
//  Created by DS on 11.12.2023.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {

    func setupNavigationController() {
        
        if #available(iOS 13.0, *) {
            navigationBar.tintColor = UIColor.black
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.clear
            appearance.backgroundEffect = nil
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            appearance.backgroundImage = UIImage()
            navigationBar.standardAppearance = appearance
            navigationBar.compactAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
    }
}
