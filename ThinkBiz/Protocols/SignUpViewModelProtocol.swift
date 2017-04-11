//
//  SignUpViewModelProtocol.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 9/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

protocol SignUpViewModelProtocol {
    
    // MARK: - Instance variables
    
    weak var delegate: SignUpViewModelControllerDelegate? { get set }
    
    var emailPlaceholderText: String? { get }
    var passwordPlaceholderText: String? { get }
    var emailErrorText: String? { get }
    var passwordErrorText: String? { get }
    var signUpButtonEnabled: Bool { get }
    
    // MARK: - Protocol functions

    func emailTextDidChange(text: String?)
    func passwordTextDidChange(text: String?)
    func signUpButtonPressed()
}

protocol SignUpViewModelControllerDelegate: class {
    func reloadViews()
    func signUpSuccess()
}
