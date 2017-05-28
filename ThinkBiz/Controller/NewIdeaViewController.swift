//
//  NewIdeaViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class NewIdeaViewController: UIViewController, NewIdeaViewModelControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: NewIdeaViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = NewIdeaViewModel(withIdeaForm: IdeaForm.form)
        
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewIdeaViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewIdeaViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Functions
    
    private func setupView() {
        
        setupNavigationBar()
        
        setupTableView()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = viewModel.title
        
        setupLeftBarButtonItem()
        setupRightBarButtonItem()
    }
    
    private func setupLeftBarButtonItem() {
        
        let cancelImage = UIImage(named: "cancel")
        cancelImage?.withRenderingMode(.alwaysTemplate)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setImage(cancelImage, for: .normal)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        cancelButton.tintColor = Styles.white
        
        cancelButton.addTarget(self, action: #selector(NewIdeaViewController.onCancelButtonPressed(_:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
    
    private func setupRightBarButtonItem() {
        
        let saveImage = UIImage(named: "save")
        saveImage?.withRenderingMode(.alwaysTemplate)
        
        let saveButton = UIButton(type: .system)
        saveButton.setImage(saveImage, for: .normal)
        saveButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        saveButton.tintColor = Styles.white
        
        saveButton.addTarget(self, action: #selector(NewIdeaViewController.onSaveButtonPressed(_:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let textFieldNib = UINib(nibName: "TextFieldCell", bundle: nil)
        tableView.register(textFieldNib, forCellReuseIdentifier: ID_TEXTFIELDCELL)
        
        let textViewNib = UINib(nibName: "TextViewCell", bundle: nil)
        tableView.register(textViewNib, forCellReuseIdentifier: ID_TEXTVIEWCELL)
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: Keyboard Notifications
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        })
    }
    
    // MARK: - Button handler
    
    @IBAction func onCancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSaveButtonPressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        viewModel.saveIdea(context: context)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension NewIdeaViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = viewModel.reuseIdentifierForCellItem(inSection: indexPath.section, at: indexPath.row)
        
        if reuseIdentifier == ID_TEXTFIELDCELL {
            if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TextFieldCell {
                cell.viewModel = viewModel.viewModelForCell(inSection: indexPath.section, at: indexPath.row) as! TextFieldCellViewModel
                cell.delegate = self
                cell.textField.tag = indexPath.row
                return cell
            }
        } else if reuseIdentifier == ID_TEXTVIEWCELL {
            if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TextViewCell {
                cell.viewModel = viewModel.viewModelForCell(inSection: indexPath.section, at: indexPath.row) as! TextViewCellViewModel
                cell.delegate = self
                cell.textView.tag = indexPath.row
                return cell
            }
        }
        
        return tableView.dequeueReusableCell(withIdentifier: ID_TEXTFIELDCELL, for: indexPath)
    }
}

// MARK: - TextFieldCellDelegate, TextViewCellDelegate
extension NewIdeaViewController: TextFieldCellDelegate, TextViewCellDelegate {
    
    func textFieldCellTextDidChange(tag: Int, text: String) {
        viewModel.textDidChange(tag: tag, text: text)
    }
    
    func textViewCellTextDidChange(tag: Int, text: String) {
        viewModel.textDidChange(tag: tag, text: text)
        
        // When text view is editing, .rowHeight and .estimatedRowHeight has no effect.
        // Begin updates and end update is a way to force row height change during editing
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
