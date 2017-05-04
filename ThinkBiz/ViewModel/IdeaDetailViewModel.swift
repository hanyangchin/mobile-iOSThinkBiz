//
//  IdeaDetailViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 26/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import CoreData

class IdeaDetailViewModel: IdeaDetailViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: IdeaDetailViewModelControllerDelegate?
    
    var idea: Idea?
    
    var numberOfSections: Int! {
        return form.count
    }
    
    // MARK: - Private
    
    private var form: [Section]! = []
    
    private let ideaForm: IdeaForm!
    
    private var name: String = ""
    private var ideaText: String = ""
    private var notes: String = ""
    
    // MARK: - Functions
    
    required init(withIdeaForm ideaForm: IdeaForm, idea: Idea?) {
        self.idea = idea
        self.ideaForm = ideaForm
        
        generateForm()
        populateFormData()
    }
    
    // Generate form using Idea Form
    private func generateForm() {
        form.append(Section(id: "New Idea", data: "New Idea" as AnyObject, rows: [
            RowItem(id: FormType.FormName.rawValue, data: TextForm(withName: ideaForm.nameLabelText, placeholderText: ideaForm.namePlaceholderText)),
            RowItem(id: FormType.FormIdea.rawValue, data: TextForm(withName: ideaForm.ideaLabelText, placeholderText: ideaForm.ideaPlaceholderText)),
            RowItem(id: FormType.FormNotes.rawValue, data: TextForm(withName: ideaForm.notesLabelText, placeholderText: ideaForm.notesPlaceholderText))
            ]))
    }
    
    private func populateFormData() {
        if let ideaName = idea?.name {
            self.name = ideaName
            
        }
        if let ideaString = idea?.idea {
            self.ideaText = ideaString
            print("\nIdea detail \(self.name) \(ideaString) \(self.notes)")
        }
        if let ideaNotes = idea?.notes {
            self.notes = ideaNotes
        }
        
    }
    
    // MARK: - NewIdeaViewModelProtocol
    
    func numberOfRows(inSection section: Int) -> Int {
        print("Number of rows in section \(section) is \(form[section].rows.count)")
        return form[section].rows.count
    }
    
    // Returns a cell view model depending on the cell type
    func viewModelForCell(inSection section: Int, at index: Int) -> AnyObject? {
        // Check for cell type and generate the appropriate view model for display
        let rowId: String = form[section].rows[index].id
        if let model = form[section].rows[index].data as? TextForm {
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
            ideaText = text
        case 2:
            notes = text
        default:
            print("Warning, text input with tag \(tag) change unhandled")
        }
        print("\nName is \(name)\nIdea is \(ideaText)\nNotes is \(notes)")
    }
    
    func saveIdea(context: NSManagedObjectContext) {
        let ideaObj = Idea(context: context)
        ideaObj.name = name
        ideaObj.idea = ideaText
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
