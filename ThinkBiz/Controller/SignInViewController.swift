//
//  LogInViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 3/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate, SignInViewModelControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signUpView: UIStackView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    private var responderFields: Dictionary! = [Int: UIResponder!]()
    
    fileprivate var signInViewModel: SignInViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        signInViewModel = SignInViewModel(inputValidator: InputValidator())
        signInViewModel.delegate = self
        
        configureViews()
        
        responderFields[emailField.tag] = emailField
        responderFields[passwordField.tag] = passwordField
        
        let attributedString = NSAttributedString(string: "Forgot your password?", attributes: [NSForegroundColorAttributeName:UIColor.red, NSUnderlineStyleAttributeName: 1])
        forgotPasswordButton.setAttributedTitle(attributedString, for: .normal)
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
            self.signInViewModel.emailTextDidChange(text: textUpdate)
        } else if textField == passwordField {
            self.signInViewModel.passwordTextDidChange(text: textUpdate)
        }
        return true
    }

    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onSignUpButtonPressed(_ sender: Any) {
        let presentingVC = self.presentingViewController
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: SEGUE_SIGNUP) as! SignUpViewController
            self.presentingViewController?.present(vc, animated: true, completion: nil)
            if let pVC = presentingVC {
                pVC.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Button Handling
    
    @IBAction func onSignInButtonPressed(_ sender: Any) {
        signInViewModel.signInButtonPressed()
    }
    @IBAction func onForgotPasswordButtonPressed(_ sender: Any) {
    }
    
    // MARK: - SignUpViewModelControllerDelegate methods
    func reloadViews() {
        configureViews()
    }
    
    func signInSuccess() {
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
        emailField.placeholder = signInViewModel.emailPlaceholderText
    }
    
    private func configurePasswordTextField() {
        passwordField.delegate = self
        passwordField.placeholder = signInViewModel.passwordPlaceholderText
    }
    
    private func configureErrorLabel() {
            errorLabel.text = signInViewModel.errorText
        }
    
    private func configureSignInButton() {
        signInButton.isEnabled = signInViewModel.signInButtonEnabled
    }

}
