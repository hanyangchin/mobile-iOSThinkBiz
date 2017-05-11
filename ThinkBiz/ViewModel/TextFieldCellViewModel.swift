//
//  TextFieldCellViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 24/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

class TextFieldCellViewModel {
    
    // MARK: - Properties
    
    enum FormModelId: String {
        case Name
        case Text
        case PlaceholderText
    }
    
    var form: FormModel!
    
    var nameLabelText: String!
    var placeholderText: String!
    var text: String!
    
    // MARK: - Functions
    
    init(initWithModel form: FormModel) {
        self.form = form
        
        // Return if data is empty
        guard let formData = form.data else {
            return
        }
        
        if let name: String = formData[FormModelId.Name.rawValue] as? String {
            nameLabelText = name
        }
        
        if let placeholder: String = formData[FormModelId.PlaceholderText.rawValue] as? String {
            self.placeholderText = placeholder
        }
        
        if let t: String = formData[FormModelId.Text.rawValue] as? String {
            self.text = t
        }
    }
}
