//
//  TextViewCellViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 24/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

class TextViewCellViewModel {
    
    var form: TextForm!
    
    var nameLabelText: String!
    var placeholderText: String!
    
    init(initWithModel form: TextForm) {
        self.form = form
        
        nameLabelText = form.name
        placeholderText = form.placeholderText
    }
}
