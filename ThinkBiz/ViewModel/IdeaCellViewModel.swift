//
//  IdeaCellViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 21/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation
import UIKit

class IdeaCellViewModel: IdeaCellViewModelProtocol {

    // MARK: - Properties
    
    var title: String! {
        return self.idea.name
    }
    var ideaText: String! {
        return self.idea.idea
    }
    var imagePath: String!
    
    var cellWidth: CGFloat?
    
    // MARK: - Private
    private let idea: Idea!
    
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
