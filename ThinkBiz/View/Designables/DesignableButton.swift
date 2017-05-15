//
//  DesignableButton.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 12/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

}
