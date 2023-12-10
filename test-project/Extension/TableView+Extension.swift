//
//  TablewView+Extension.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

extension UITableView {
    
    // MARK: - Public methods
    
    func registerCell<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.identifier)
    }

    func registerCell<T: UITableViewCell>(xib: T.Type) {
        
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.identifier)
    }
    
    func registerHeader<T: UITableViewHeaderFooterView>(headerClass: T.Type) {
        
        let nib = UINib(nibName: T.identifier, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: T.identifier)
    }

    func instiateCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    func instiateCell<T: UITableViewCell>() -> T {
        return dequeueReusableCell(withIdentifier: T.identifier) as! T
    }
    
    func instiateHeader<T: UITableViewHeaderFooterView>() -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
    
    func scrollToBottom() {

        DispatchQueue.main.async {
            
            let indexPath = IndexPath( row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1, section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func scrollToTop() {

        DispatchQueue.main.async {
            self.setContentOffset(.zero, animated: true)
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
          return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
