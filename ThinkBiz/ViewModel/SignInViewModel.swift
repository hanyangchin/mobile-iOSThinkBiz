//
//  SignInViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 10/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Firebase

class SignInViewModel : SignInViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: SignInViewModelControllerDelegate?
    
    let emailPlaceholderText: String? = "Email"
    let passwordPlaceholderText: String? = "Password"
    var errorText: String? = ""
    
    var signInButtonEnabled: Bool {
        return emailValid && passwordValid && !processingSignin
    }
    
    // MARK: - Private
    
    private let inputValidator: InputValidator
    private var emailText: String = ""
    private var passwordText: String = ""
    private var emailValid: Bool = false
    private var passwordValid: Bool = false
    
    private var processingSignin = false
    
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
    
    func signInButtonPressed() {
        processingSignin = true
        AuthService.sharedInstance.signIn(withEmail: emailText, password: passwordText) { (error) in
            // Check if there is an error
            if let errorMessage = error {
                self.errorText = errorMessage
                self.delegateReloadViews()
            } else {
                self.delegateSignInSuccess()
            }
            
            self.processingSignin = false
        }
        delegateReloadViews()
    }
    
    // MARK: - Delegate Response
    
    private func delegateReloadViews() {
        delegate?.reloadViews()
    }
    
    private func delegateSignInSuccess() {
        delegate?.signInSuccess()
    }
}
