//
//  SettingsViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 13/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation
import FirebaseAuth

class SettingsTableViewViewModel: SettingsTableViewViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: SettingsTableViewViewModelControllerDelegate?
    
    var numberOfSections: Int! {
        return sections.count
    }
    
    var versionText: String?
    
    // MARK: - Private
    
    private var sections: [Section]! = []
    
    init() {
        sections = [Section]()
        generateStaticSettingsTable()

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionText = "You are using ThinkBiz \(version)"
        }
    }
    
    private func generateStaticSettingsTable() {
        
        sections.append(Section(id: "Terms", data: "Terms" as AnyObject, rows: [
            RowItem(id: SettingType.SettingsUserAgreement.rawValue, data: URLSetting(name: "User Agreement", url: "https://www.google.com")),
            RowItem(id: SettingType.SettingsContentPolicy.rawValue, data: URLSetting(name: "Content Policy", url: "https://www.google.com")),
            RowItem(id: SettingType.SettingsPrivacyPolicy.rawValue, data: URLSetting(name: "Privacy Policy", url: "https://www.google.com"))
        ]))
        sections.append(Section(id: "Accounts", data: "Accounts" as AnyObject, rows: [
            RowItem(id: SettingType.SettingsLogout.rawValue, data: Setting(name: "Logout"))
            // TODO: Implement delete account
//            RowItem(id: SettingType.SettingsDeleteAccount.rawValue, data: Setting(name: "Delete Account"))
            ]))
    }
    
    // MARK: - SettingsTableViewViewModelProtocol
    
    func settingsTitleTextForSection(section: Int) -> String {
        if let title = sections[section].data as? String {
            return title
        }
        return ""
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func reuseIdentifierForCellItem(inSection section: Int, at index: Int) -> String {
        let rowItem: RowItem = sections[section].rows[index]
        
        var reuseIdentifier: String
        
        switch rowItem.id {
        case SettingType.SettingsUserAgreement.rawValue, SettingType.SettingsContentPolicy.rawValue, SettingType.SettingsPrivacyPolicy.rawValue, SettingType.SettingsLogout.rawValue, SettingType.SettingsDeleteAccount.rawValue:
            reuseIdentifier = ID_SETTINGSITEMCELLDISCLOSURE
        default:
            reuseIdentifier = ""
        }
        return reuseIdentifier
    }
    
    func viewModelForCell(inSection section: Int, at index:Int) -> SettingsTableViewCellViewModel {
        let setting = sections[section].rows[index].data as? Setting
        return SettingsTableViewCellViewModel(initWithModel: setting!)
    }
    
    func didSelectRow(inSection section: Int, at index: Int) {
        switch sections[section].rows[index].id {
        case SettingType.SettingsUserAgreement.rawValue, SettingType.SettingsContentPolicy.rawValue, SettingType.SettingsPrivacyPolicy.rawValue:
            if let urlSetting = sections[section].rows[index].data as? URLSetting {
                delegate?.performLoadURL(title: urlSetting.name, url: urlSetting.url)
            }
        case SettingType.SettingsLogout.rawValue:
            delegate?.performLogout()
        case SettingType.SettingsDeleteAccount.rawValue:
            delegate?.performDeleteAccount()
        default:
            print("DidSelectRow unhandled!")
        }
    }
    
    func logout() {
        AuthService.sharedInstance.signOut(completion: { (error: String?) in
            // Check if there is an error
            if let errorMessage = error {
                print("\(errorMessage)")
            } else {
                self.delegate?.navigateToRootView()
            }
        })
    }
    
    func deleteAccount() {
        
    }
}
