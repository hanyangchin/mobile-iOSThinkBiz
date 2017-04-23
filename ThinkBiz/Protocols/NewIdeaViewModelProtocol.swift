//
//  NewIdeaViewModelProtocol.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 22/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

protocol NewIdeaViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: NewIdeaViewModelControllerDelegate? { get set }
    
    var nameLabelText: String! { get }
    var namePlaceholder: String! { get }
    var numberOfSections: Int! { get }
    
    // MARK: - Functions
    init(withIdeaForm ideaForm: IdeaForm)
    
    //    func settingsTitleTextForSection(section: Int) -> String
    func numberOfRows(inSection section: Int) -> Int
    //    func viewModelForCell(inSection section: Int, at index:Int) -> SettingsTableViewCellViewModel
    //    func reuseIdentifierForCellItem(inSection section: Int, at index: Int) -> String
    //    func didSelectRow(inSection section: Int, at index: Int)
    
    func saveIdea()
}

protocol NewIdeaViewModelControllerDelegate: class {
    
}
