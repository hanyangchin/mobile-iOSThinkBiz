//
//  SignUpViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 3/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailField: InputTextField!
    @IBOutlet weak var passwordField: InputTextField!
    @IBOutlet weak var haveAccountButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up textfied delegates
        emailField.delegate = self
        passwordField.delegate = self
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try find the next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // No responder left, dismiss keyboard
            textField.resignFirstResponder()
        }
        
        return false
    }
    @IBAction func signUpButtonPressed(_ sender: Any) {
    }

    @IBAction func onAccountExistedButtonPressed(_ sender: Any) {
        let presentingVC = self.presentingViewController
        self.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: SEGUE_LOGIN) as! LogInViewController
            self.presentingViewController?.present(vc, animated: true, completion: nil)
            if let pVC = presentingVC {
                pVC.present(vc, animated: true, completion: nil)
            }
        }
    }
}
