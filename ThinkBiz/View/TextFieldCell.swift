//
//  TextFieldCell.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 3/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var delegate: TextFieldCellDelegate?
    
    var viewModel: TextFieldCellViewModel! {
        didSet {
            configureCell(withViewModel: self.viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textField.delegate = self

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        if selected {
            textField.becomeFirstResponder()
        }
    }
    
    func configureCell(withViewModel viewModel: TextFieldCellViewModel) {
        self.nameLabel.text = viewModel.nameLabelText.uppercased()
        self.textField.placeholder = viewModel.placeholderText
        self.textField.text = viewModel.text
    }
    
}

extension TextFieldCell: UITextFieldDelegate {
    
    //MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text: NSString = (textField.text ?? "") as NSString
        let textUpdate = text.replacingCharacters(in: range, with: string)
        
        delegate?.textFieldCellTextDidChange(tag: textField.tag, text: textUpdate)
        
        return true
    }
}
