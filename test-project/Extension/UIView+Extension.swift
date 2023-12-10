//
//  UIView+Extension.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {
    
    // MARK: - Static properties
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            } else {
                return .clear
            }
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    // MARK: - Public methods
    
    func loadViewFromNib(name: String?) -> UIView {
        
        let xibName = name ?? Self.identifier
        let bundle = Bundle(for: Self.self)
        
        guard let view = bundle.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView else {
            fatalError()
        }
        
        return view
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    // MARK: - Class properties
    
    class var identifier: String {
        return String(describing: self)
    }
}
