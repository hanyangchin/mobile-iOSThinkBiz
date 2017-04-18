//
//  SettingsItemCell.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 13/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
    var viewModel: SettingsTableViewCellViewModel! {
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
    
    func configureCell(withViewModel viewModel: SettingsTableViewCellViewModel) -> Void {
        self.itemLabel.text = viewModel.itemLabelText
        self.accessoryType = viewModel.accessoryType
    }

}
