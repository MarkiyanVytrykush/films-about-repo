//
//  XibView.swift
//  test-project
//
//  Created by DS on 10.12.2023.
//

import Foundation
import UIKit

// MARK: - XibView
@IBDesignable
class XibView: UIView {
    
    // MARK: - Properties
    
    private(set) var contentView: UIView?

    @IBInspectable var nibName: String?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    // MARK: - View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        commonInit()
        setup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    // MARK: - Public methods
    
    func commonInit() {
        
        let contentView = loadViewFromNib(name: nibName)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        
        self.contentView = contentView
    }
    
    func setup() {}
}
