//
//  SettingsTableViewViewModelProtocol.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 13/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation

protocol SettingsTableViewViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: SettingsTableViewViewModelControllerDelegate? { get set }
    
    var numberOfSections: Int! { get }
    var versionText: String? { get }
    
    // MARK: - Functions
    func settingsTitleTextForSection(section: Int) -> String
    func numberOfRows(inSection section: Int) -> Int
    func viewModelForCell(inSection section: Int, at index:Int) -> SettingsTableViewCellViewModel
    func viewModelForSectionHeader(section: Int) -> SettingsTableSectionHeaderViewModel
    func reuseIdentifierForCellItem(inSection section: Int, at index: Int) -> String
    func reuseIdentifierForSectionHeader(section: Int) -> String
    func didSelectRow(inSection section: Int, at index: Int)
    
    func logout()
    func deleteAccount()
}

protocol SettingsTableViewViewModelControllerDelegate: class {
    
    func navigateToRootView()
    func performLoadURL(title: String, url: String)
    func performLogout()
    func performDeleteAccount()
}
