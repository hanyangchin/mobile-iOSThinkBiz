//
//  Helper.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 9/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

// MARK: - Global

struct GlobalVariables {
    static let white = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
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

// MARK: - UITableView Helper

enum SectionType {
    case SettingsAbout
    case SettingsOther
}

enum SectionItem {
    case SettingsUserAgreement
    case SettingsContentPolicy
    case SettingsPrivacyPolicy
    
    case SettingsLogout
    case SettingsDeleteAccount
}

struct Section {
    var name: String
    var type: SectionType
    var items: [SectionItem]
}
