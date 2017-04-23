//
//  NewIdeaViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 22/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

class NewIdeaViewModel: NewIdeaViewModelProtocol {
    
    // MARK: - Properties
    
    var delegate: NewIdeaViewModelControllerDelegate?
    
    var nameLabelText: String! = ""
    var namePlaceholder: String! = ""
    
    var numberOfSections: Int! {
        return 0
    }
    
    // MARK: - Private
    
    private var form: [Section]! = []
    
    private var name: String! = ""
    private var idea: String! = ""
    private var notes: String! = ""
    
    // MARK: - Functions
    
    required init(withIdeaForm ideaForm: IdeaForm) {
        name = ideaForm.nameLabelText
        namePlaceholder = ideaForm.ideaPlaceholderText
        
        generateForm()
    }
    
    private func generateForm() {

    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return 0
    }
    
    func saveIdea() {
        
    }
}
