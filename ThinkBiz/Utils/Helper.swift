//
//  Helper.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 9/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

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
