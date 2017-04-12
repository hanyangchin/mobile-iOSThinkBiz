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
        return emailValid && passwordValid
    }
    
    // MARK: - Private
    
    private let inputValidator: InputValidator
    private var emailText: String = ""
    private var passwordText: String = ""
    private var emailValid: Bool = false
    private var passwordValid: Bool = false
    
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
        createAccount(email: emailText, password: passwordText, { 
            self.delegateSignUpSuccess()
        }) { (error) in
            self.delegateReloadViews()
        }
    }
    
    private func createAccount(email: String, password: String, _ success:(() -> Void)?, failure:((_ errorDescription: String?) -> Void)?) -> Void {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            if error != nil {
                print(error.debugDescription)
                var errorMessage: String = ""
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case .errorCodeInvalidEmail:
                        errorMessage = "Invalid email"
                    case .errorCodeWeakPassword:
                        errorMessage = "Password should be at least 6 characters"
                    case .errorCodeNetworkError:
                        errorMessage = "Network error. Please try again"
                    case .errorCodeEmailAlreadyInUse:
                        errorMessage = "Email already been used"
                    default:
                        errorMessage = error?.localizedDescription ?? "Error occurred"
                    }
                    self.errorText = error?.localizedDescription ?? "Unknown error occurred"
                    failure?(errorMessage)
                }
            } else {
                if let user = user {
                    let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                    success?()
                } else {
                    failure?("Failed to create user")
                }
            }
        })
    }

    private func completeSignIn(id: String, userData: Dictionary<String, String>) -> Void {
        //        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        //
        //        let keyChainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        //        print("Han Social: Data saved to keychain \(keyChainResult) with ID \(id)")
    }
    
    // MARK: - Delegate Response
    
    private func delegateReloadViews() {
        delegate?.reloadViews()
    }
    
    private func delegateSignUpSuccess() {
        delegate?.signUpSuccess()
    }
}
