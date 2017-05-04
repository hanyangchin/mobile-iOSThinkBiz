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
    
    var viewModel: TextFieldCellViewModel! {
        didSet {
            configureCell(withViewModel: self.viewModel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(withViewModel viewModel: TextFieldCellViewModel) {
        self.nameLabel.text = viewModel.nameLabelText
        self.textField.placeholder = viewModel.placeholderText
    }
    
}
