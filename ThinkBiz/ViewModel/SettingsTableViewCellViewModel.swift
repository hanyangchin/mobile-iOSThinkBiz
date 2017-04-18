//
//  SettingsItemViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 14/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableViewCellViewModel {
    var setting: Setting!
    
    var itemLabelText: String?
    
    var accessoryType: UITableViewCellAccessoryType {
        if setting is URLSetting {
            return .disclosureIndicator
        }
        return .none
    }
    
    init(initWithModel setting: Setting) {
        self.setting = setting

        itemLabelText = setting.name
    }
}
