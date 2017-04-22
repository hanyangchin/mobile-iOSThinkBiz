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
    
    private var sections: [Section]! = []
    

    private var sectionData: [Int: [Setting]]! = [:]
    
    // MARK: - Private

    private var s1Data: [Setting]
    private var s2Data: [Setting]
    
    init() {
        
        sections = [Section]()

        s1Data = []
        s2Data = []
        generateStaticSettingsTable()

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionText = "You are using ThinkBiz \(version)"
        }
    }
    
    private func generateStaticSettingsTable() {
        
        sections.append(Section(name: "Terms", type: .Settings, items: [.SettingsUserAgreement, .SettingsContentPolicy, .SettingsPrivacyPolicy]))
        sections.append(Section(name: "Accounts", type: .Settings, items: [.SettingsLogout, .SettingsDeleteAccount]))
        
        s1Data.append(URLSetting(name: "User Agreement", url: "https://www.google.com"))
        s1Data.append(URLSetting(name: "Content Policy", url: "https://www.google.com"))
        s1Data.append(URLSetting(name: "Privacy Policy", url: "https://www.google.com"))
        
        s2Data.append(Setting(name: "Logout"))
        s2Data.append(Setting(name: "Delete Account"))

        sectionData = [0: s1Data, 1: s2Data]
    }
    
    // MARK: - SettingsTableViewViewModelProtocol
    
    func settingsTitleTextForSection(section: Int) -> String {
        return sections[section].name
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return sectionData[section]!.count
    }
    
    func reuseIdentifierForCellItem(inSection section: Int, at index: Int) -> String {
        
        let sectionItem: SectionItem = sections[section].items[index]
        
        var reuseIdentifier: String
        
        switch sectionItem {
        case .SettingsUserAgreement, .SettingsContentPolicy, .SettingsPrivacyPolicy, .SettingsLogout, .SettingsDeleteAccount:
            reuseIdentifier = ID_SETTINGSITEMCELLDISCLOSURE
        default:
            reuseIdentifier = ""
        }
        return reuseIdentifier
    }
    
    func viewModelForCell(inSection section: Int, at index:Int) -> SettingsTableViewCellViewModel {
        let setting = sectionData[section]?[index]
        return SettingsTableViewCellViewModel(initWithModel: setting!)
    }
    
    func didSelectRow(inSection section: Int, at index: Int) {
        print("Did select row in section \(section) at index \(index)")
        switch sections[section].items[index] {
        case .SettingsUserAgreement, .SettingsContentPolicy, .SettingsPrivacyPolicy:
            if let urlSetting = sectionData[section]?[index] as? URLSetting {
                delegate?.performLoadURL(title: urlSetting.name, url: urlSetting.url)
            }
        case .SettingsLogout:
            delegate?.performLogout()
        case .SettingsDeleteAccount:
            delegate?.performDeleteAccount()
        default:
            print("DidSelectRow unhandled!")
        }
    }
    
    func logout() {
        AuthService.sharedInstance.signOut(completion: { (error: String?) in
            // Check if there is an error
            if let errorMessage = error {
                
            } else {
                self.delegate?.navigateToRootView()
            }
        })
    }
    
    func deleteAccount() {
        
    }
}
