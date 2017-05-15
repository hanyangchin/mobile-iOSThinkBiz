//
//  SettingsTableSectionHeaderViewModelProtocol.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 11/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

protocol SettingsTableSectionHeaderViewModelProtocol {
    var title: String? { get }
    
    init(withTitle title: String)
}
