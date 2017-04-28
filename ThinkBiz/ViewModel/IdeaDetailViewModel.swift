//
//  IdeaDetailViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 26/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

class IdeaDetailViewModel: IdeaDetailViewModelProtocol {
    
    // MARK: - Properties
    
    var idea: Idea?
    
    // MARK: - Functions
    
    required init(withIdeaForm ideaForm: IdeaForm, idea: Idea) {
        self.idea = idea
    }
}
