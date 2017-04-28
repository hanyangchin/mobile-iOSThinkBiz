//
//  IdeaForm.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 22/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

struct IdeaForm {
    var nameLabelText: String!
    var namePlaceholderText: String!
    var ideaLabelText: String!
    var ideaPlaceholderText: String!
    var notesLabelText: String!
    var notesPlaceholderText: String!
    
    // MARK: - IdeaForm helper
    static let form: IdeaForm = IdeaForm(nameLabelText: "Name", namePlaceholderText: "e.g ThinkBiz, Google, Starbucks, IKEA", ideaLabelText: "Description", ideaPlaceholderText: "Short description of your business idea. e.g ThinkBiz helps store and manage your business ideas for entrepreneurs", notesLabelText: "Notes", notesPlaceholderText: "Other information such as target audience, busniess model...")
}
