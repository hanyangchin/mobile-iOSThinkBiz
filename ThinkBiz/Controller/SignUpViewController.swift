//
//  SignUpViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 3/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate, SignUpViewModelControllerDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var haveAccountButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    fileprivate var responderFields: Dictionary! = [Int: UIResponder!]()
    
    fileprivate var signUpViewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Must initialize view model
        self.signUpViewModel = SignUpViewModel(inputValidator: InputValidator())
        self.signUpViewModel.delegate = self
        
        configureViews()
        
        responderFields[emailField.tag] = emailField
        responderFields[passwordField.tag] = passwordField
        
        let attributedString = NSAttributedString(string: (haveAccountButton.titleLabel?.text)!, attributes: [NSForegroundColorAttributeName:UIColor.red, NSUnderlineStyleAttributeName: 1])
        haveAccountButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unRegisterForKeyboardNotifications()
    }
    
    // MARK: - Keyboard Delegates & Handling

    private func registerForKeyboardNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    private func unRegisterForKeyboardNotifications() -> Void {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        // Give room at the bottom of the scroll view
        var userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }
    
    //MARK: - Text Field Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Try find the next responder
        let field = responderFields[textField.tag+1]
        
        if let nextField = field as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // No responder left, dismiss keyboard
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text: NSString = (textField.text ?? "") as NSString
        let textUpdate = text.replacingCharacters(in: range, with: string)
        
        if textField == emailField {
            self.signUpViewModel.emailTextDidChange(text: textUpdate)
        } else if textField == passwordField {
            self.signUpViewModel.passwordTextDidChange(text: textUpdate)
        }
        return true
    }
    
    // MARK: - Button Handling
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
        signUpViewModel.signUpButtonPressed()
    }

    @IBAction func onAccountExistedButtonPressed(_ sender: Any) {
        // Dismiss current VC and launch SignInViewController
        let presentingVC = self.presentingViewController
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: SEGUE_SIGNIN) as! SignInViewController
            self.presentingViewController?.present(vc, animated: true, completion: nil)
            if let pVC = presentingVC {
                pVC.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - SignUpViewModelControllerDelegate methods
    func reloadViews() {
        configureViews()
    }
    
    func signUpSuccess() {
        self.performSegue(withIdentifier: SEGUE_MAINTABBAR, sender: self)
    }
    
    // MARK: - View configuration
    fileprivate func configureViews() {
        configureEmailTextField()
        configurePasswordTextField()
        configureErrorLabel()
        configureSignInButton()
    }
    
    private func configureEmailTextField() {
        emailField.delegate = self
        emailField.placeholder = signUpViewModel.emailPlaceholderText
    }
    
    private func configurePasswordTextField() {
        passwordField.delegate = self
        passwordField.placeholder = signUpViewModel.passwordPlaceholderText
    }
    
    private func configureErrorLabel() {
        errorLabel.text = signUpViewModel.errorText
    }
    
    private func configureSignInButton() {
        signUpButton.isEnabled = signUpViewModel.signUpButtonEnabled
    }
}
