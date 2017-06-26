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

    var title: String! { get }
    var numberOfSections: Int! { get }
    
    // MARK: - Protocol Functions
    init(withIdeaForm ideaForm: IdeaForm)
    
    //    func settingsTitleTextForSection(section: Int) -> String
    func numberOfRows(inSection section: Int) -> Int
    func viewModelForCell(inSection section: Int, at index:Int) -> AnyObject?
    func reuseIdentifierForCellItem(inSection section: Int, at index: Int) -> String
    //    func didSelectRow(inSection section: Int, at index: Int)
    
    func textDidChange(tag: Int, text: String!)
    
    func saveIdea()
}

protocol NewIdeaViewModelControllerDelegate: class {
    
}
