//
//  SignUpViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 9/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Firebase

class SignUpViewModel : SignUpViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: SignUpViewModelControllerDelegate?
    
    let emailPlaceholderText: String? = "Email"
    let passwordPlaceholderText: String? = "Password"
    var errorText: String? = ""
    
    var signUpButtonEnabled: Bool {
        return emailValid && passwordValid && !processingSignup
    }
    
    // MARK: - Private
    
    private let inputValidator: InputValidator
    private var emailText: String = ""
    private var passwordText: String = ""
    private var emailValid: Bool = false
    private var passwordValid: Bool = false
    
    private var processingSignup = false
    
    init(inputValidator: InputValidator) {
        self.inputValidator = inputValidator
    }

    // MARK: - Actions
    
    func emailTextDidChange(text: String?) {
        self.emailText = text ?? ""
        self.errorText = ""
        do {
            try inputValidator.validateEmail(email: self.emailText)
            emailValid = true
        } catch {
            emailValid = false
        }
        delegateReloadViews()
    }
    
    func passwordTextDidChange(text: String?) {
        self.passwordText = text ?? ""
        self.errorText = ""
        do {
            try inputValidator.validatePassword(password: self.passwordText)
            passwordValid = true
        } catch {
            passwordValid = false
        }
        delegateReloadViews()
    }
    
    func signUpButtonPressed() {
        processingSignup = true
        AuthService.sharedInstance.signUp(withEmail: emailText, password: passwordText) { (error) in
            // Check if there is an error
            if let errorMessage = error {
                self.errorText = errorMessage
                self.delegateReloadViews()
            } else {
                self.delegateSignUpSuccess()
            }
            
            self.processingSignup = false
        }
        delegateReloadViews()
    }
    
    // MARK: - Delegate Response
    
    private func delegateReloadViews() {
        delegate?.reloadViews()
    }
    
    private func delegateSignUpSuccess() {
        delegate?.signUpSuccess()
    }
}
