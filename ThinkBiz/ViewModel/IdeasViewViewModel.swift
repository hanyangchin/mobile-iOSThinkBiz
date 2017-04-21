//
//  IdeasViewViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation

class IdeasViewViewModel: IdeasViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: IdeasViewModelControllerDelegate?
    
    var title: String! {
        return "Ideas"
    }
    
    var numberOfSections: Int! {
        return 1
    }
    
    // MARK: - IdeasViewModelProtocol
    
    func numberOfItems(inSection section: Int) -> Int {
        return 3
    }
    
}
