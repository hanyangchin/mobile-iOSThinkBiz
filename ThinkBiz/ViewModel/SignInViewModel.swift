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
    
    func signInButtonPressed() {
        signIn(email: emailText, password: passwordText, {
            self.delegateSignInSuccess()
        }) { (error) in
            self.delegateReloadViews()
        }
    }
    
    private func signIn(email: String, password: String, _ success:(() -> Void)?, failure:((_ errorDescription: String?) -> Void)?) -> Void {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            if error != nil {
                var errorMessage: String = ""
                print(error.debugDescription)
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case .errorCodeInvalidEmail:
                        errorMessage = "Invalid email"
                    case .errorCodeNetworkError:
                        errorMessage = "Network error. Please try again"
                    case .errorCodeWrongPassword:
                        errorMessage = "Sorry, wrong password"
                    case .errorCodeUserNotFound:
                        errorMessage = "Login does not exists"
                    default:
                        errorMessage = "Error occurred"
                    }
                    self.errorText = error?.localizedDescription ?? "Unknown error occurred"
                    failure?(errorMessage)
                }
            } else {
                print("Email user authenticated with Firebase")
                if let user = user {
                    let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                    success?()
                } else {
                    failure?("Failed to sign in.")
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
    
    private func delegateSignInSuccess() {
        delegate?.signInSuccess()
    }
}
