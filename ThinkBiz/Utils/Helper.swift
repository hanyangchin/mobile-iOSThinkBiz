//
//  Helper.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 9/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

// MARK: - Styles

struct Styles {
    static let accentColor = UIColor(red: 254/255, green: 108/255, blue: 108/255, alpha: 1)
    static let white = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    
    static let gray = UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1)
}

// MARK: - UITextField Helper

enum InputValidatorError : Error {
    case EmptyUsername
    case EmptyPassword
}

class InputValidator {
    
    func validateEmail(email: String?) throws {
        guard let email = email, !email.isEmpty else {
            throw InputValidatorError.EmptyUsername
        }
    }
    
    func validatePassword(password: String?) throws {
        guard let password = password, !password.isEmpty else {
            throw InputValidatorError.EmptyPassword
        }
    }
}

// MARK: - Data Helper

enum IdeaKV: String {
    case Name = "name"
    case Idea = "idea"
    case Notes = "notes"
    case Created = "created"
}

// MARK: - UITableView Helper

enum SectionType {
    case Settings
    case Form
}

enum FormType: String {
    case FormName
    case FormIdea
    case FormNotes
}

enum SettingType: String {
    case SettingsUserAgreement
    case SettingsContentPolicy
    case SettingsPrivacyPolicy

    case SettingsLogout
    case SettingsDeleteAccount
}

struct RowItem {
    var id: String!
    var data: AnyObject?
}

struct Section {
    var id: String!
    var data: AnyObject?
    var rows: [RowItem]
}
