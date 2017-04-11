//
//  SignInViewModelProtocol.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 10/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

protocol SignInViewModelProtocol {
    
    // MARK: - Instance variables
    
    weak var delegate: SignInViewModelControllerDelegate? { get set }
    
    var emailPlaceholderText: String? { get }
    var passwordPlaceholderText: String? { get }
    var emailErrorText: String? { get }
    var passwordErrorText: String? { get }
    var signInButtonEnabled: Bool { get }
    
    // MARK: - Protocol functions
    
    func emailTextDidChange(text: String?)
    func passwordTextDidChange(text: String?)
    func signInButtonPressed()
}

protocol SignInViewModelControllerDelegate: class {
    func reloadViews()
    func signInSuccess()
}
