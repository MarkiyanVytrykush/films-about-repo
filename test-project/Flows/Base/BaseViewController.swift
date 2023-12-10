//
//  BaseViewController.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

// MARK: - BaseViewController
class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    public func setupUI() {}
    
    func showAlertWithError(message: String, title: String = "Error") {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }

            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )

            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
