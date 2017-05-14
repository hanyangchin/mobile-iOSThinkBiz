//
//  DesignableTextField.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 12/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var bottomBorderWidth: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    var bottomBorder: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    private func initialize() {
        // Setup bottom layer
        bottomBorder = CALayer(layer: layer)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        self.layer.addSublayer(bottomBorder)
    }
    
    func updateView() {
        
        // Image settings
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            
            var width = leftPadding + 20
            
            if borderStyle == UITextBorderStyle.none || borderStyle == UITextBorderStyle.line {
                width = width + 5
            }
            
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            containerView.addSubview(imageView)
            
            leftView = containerView
        } else {
            // Image is nil
            leftViewMode = .never
        }
        
        // Attributed place holder text is the same as tint color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSForegroundColorAttributeName: tintColor])
        
        
        // Border settings
        self.layer.borderColor = borderColor.cgColor
        bottomBorder.backgroundColor = borderColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomBorder.frame = CGRect(x: 0, y: self.frame.size.height - self.bottomBorderWidth, width: self.frame.size.width, height: bottomBorderWidth)
    }

}
