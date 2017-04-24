//
//  TextForm.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 24/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation

class TextForm: Form {
    var placeholderText: String!
    
    required init(withName name: String, placeholderText: String) {
        super.init(withName: name)
        
        self.placeholderText = placeholderText
    }
}
