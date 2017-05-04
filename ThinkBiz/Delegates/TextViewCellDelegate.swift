//
//  TextViewCellDelegate.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 4/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation

protocol TextViewCellDelegate {
    
    // MARK: - Functions
    func textViewCellTextDidChange(tag: Int, text: String)
}
