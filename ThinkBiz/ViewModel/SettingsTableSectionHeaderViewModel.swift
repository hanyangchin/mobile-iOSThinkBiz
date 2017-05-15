//
//  SettingsTableSectionHeaderViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 11/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

class SettingsTableSectionHeaderViewModel: SettingsTableSectionHeaderViewModelProtocol {
    
    var title: String?
    
    required init(withTitle title: String) {
        self.title = title
    }
}
