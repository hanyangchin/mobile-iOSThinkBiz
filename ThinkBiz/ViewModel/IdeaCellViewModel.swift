//
//  IdeaCellViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 21/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation

class IdeaCellViewModel: IdeaCellViewModelProtocol {
    
    // MARK: - Properties
    
    var title: String!
    var ideaText: String!
    var imagePath: String!
    
    // MARK: - Private
    fileprivate let idea: Idea!
    
    init(withIdea idea: Idea) {
        self.idea = idea
    }
    
    func date() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "d MMMM"
        if let date = idea.created as Date? {
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
