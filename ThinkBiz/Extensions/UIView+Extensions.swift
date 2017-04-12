//
//  UIView+Shake.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 6/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    func shake() -> Void {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -10.0, 10.0, -7.0, 7.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
