//
//  FormModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 5/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

class FormModel {
    
    // MARK: - Properties
    var data: Dictionary<String, Any>?
    
    // MARK: - Functions
    
    init() {
        data = [String:Any]()
    }
    
    init(withData data: Dictionary<String, Any>) {
        self.data = data
    }
}
