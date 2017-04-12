//
//  InputTextField.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 4/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

@IBDesignable
class InputTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let border = CALayer()
        let width = CGFloat(1.0)
        
//        border.borderColor = UIColor(white: 231 / 255, alpha: 1).cgColor
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}
