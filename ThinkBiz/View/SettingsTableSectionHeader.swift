//
//  SettingsTableSectionHeader.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 11/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class SettingsTableSectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!

    var viewModel: SettingsTableSectionHeaderViewModel! {
        didSet {
            configureView(viewModel: viewModel)
        }
    }
    
    func configureView(viewModel: SettingsTableSectionHeaderViewModel) {
        titleLabel.text = viewModel.title
    }
}
