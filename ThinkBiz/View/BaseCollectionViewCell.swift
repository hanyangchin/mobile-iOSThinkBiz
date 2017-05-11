//
//  BaseCollectionViewCell.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 28/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

@IBDesignable
class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Inspectables
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.contentView.layer.cornerRadius = cornerRadius
            self.contentView.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.contentView.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.contentView.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
            
            if shadowOpacity > 0 {
                self.layer.masksToBounds = false
            }
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    // MARK: - Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCell()
    }
    
    // MARK: - Functions
    func initCell() { }
    
}
