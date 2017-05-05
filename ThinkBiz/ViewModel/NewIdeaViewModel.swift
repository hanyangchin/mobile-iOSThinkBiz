//
//  NewIdeaViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 22/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import CoreData

class NewIdeaViewModel: NewIdeaViewModelProtocol {
    
    // MARK: - Properties
    
    var delegate: NewIdeaViewModelControllerDelegate?
    
    var numberOfSections: Int! {
        return form.count
    }
    
    // MARK: - Private
    
    private var form: [Section]! = []
    
    private let ideaForm: IdeaForm!
    
    private var name: String! = ""
    private var idea: String! = ""
    private var notes: String! = ""
    
    // MARK: - Functions
    
    required init(withIdeaForm ideaForm: IdeaForm) {
        
        self.ideaForm = ideaForm
        generateForm()
    }
    
    // Generate form using Idea Form
    private func generateForm() {
        form.append(Section(id: "New Idea", data: "New Idea" as AnyObject, rows: [
            RowItem(id: FormType.FormName.rawValue, data: FormModel(withData: [TextFieldCellViewModel.FormModelId.Name.rawValue: ideaForm.nameLabelText, TextFieldCellViewModel.FormModelId.PlaceholderText.rawValue: ideaForm.namePlaceholderText])),
            RowItem(id: FormType.FormIdea.rawValue, data: FormModel(withData: [TextViewCellViewModel.FormModelId.Name.rawValue: ideaForm.ideaLabelText, TextViewCellViewModel.FormModelId.PlaceholderText.rawValue: ideaForm.ideaPlaceholderText])),
            RowItem(id: FormType.FormNotes.rawValue, data: FormModel(withData: [TextViewCellViewModel.FormModelId.Name.rawValue: ideaForm.notesLabelText, TextViewCellViewModel.FormModelId.PlaceholderText.rawValue: ideaForm.notesPlaceholderText]))
            ]))
    }
    
    // MARK: - NewIdeaViewModelProtocol
    
    func numberOfRows(inSection section: Int) -> Int {
        return form[section].rows.count
    }
    
    // Returns a cell view model depending on the cell type
    func viewModelForCell(inSection section: Int, at index: Int) -> AnyObject? {
        // Check for cell type and generate the appropriate view model for display
        let rowId: String = form[section].rows[index].id
        if let model = form[section].rows[index].data as? FormModel {
            if rowId == FormType.FormName.rawValue {
                return TextFieldCellViewModel(initWithModel: model)
            } else {
                return TextViewCellViewModel(initWithModel: model)
            }
        }
        return nil
    }
    
    func reuseIdentifierForCellItem(inSection section: Int, at index: Int) -> String {
        let rowItem: RowItem = form[section].rows[index]
        
        var reuseIdentifier: String
        
        switch rowItem.id {
        case FormType.FormName.rawValue:
            reuseIdentifier = ID_TEXTFIELDCELL
        case FormType.FormIdea.rawValue, FormType.FormNotes.rawValue:
            reuseIdentifier = ID_TEXTVIEWCELL
        default:
            reuseIdentifier = ""
        }
        return reuseIdentifier
    }
    
    func textDidChange(tag: Int, text: String!) {
        switch tag {
        case 0:
            name = text
        case 1:
            idea = text
        case 2:
            notes = text
        default:
            print("Warning, text input with tag \(tag) change unhandled")
        }
        print("\nName is \(name)\nIdea is \(idea)\nNotes is \(notes)")
    }
    
    func saveIdea(context: NSManagedObjectContext) {
        let ideaObj = Idea(context: context)
        ideaObj.name = name
        ideaObj.idea = idea
        ideaObj.notes = notes
        ideaObj.created = NSDate()
        
        do {
            try context.save()
        } catch let error as NSError {
            print("\(error)")
        }
        
        // TODO: Refactor the saving code to DataService object
        //        DataService.sharedInstance.saveIdea(ideaObj)
    }
}
