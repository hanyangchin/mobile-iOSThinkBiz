//
//  SettingsViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 13/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController, SettingsTableViewViewModelControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var versionLabel: UILabel!
    var settingsViewModel: SettingsTableViewViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.settingsViewModel = SettingsTableViewViewModel()
        self.settingsViewModel.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.versionLabel.text = settingsViewModel.versionText
        
        setupView()
        configureView()
    }
    
    private func setupView() {

    }
    
    fileprivate func configureView() {
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func navigateToRootView() {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - SettingsTableViewViewModelControllerDelegate
    
    func performLoadURL(title: String, url: String) {
        print("Loading URL \(url)")
        
        if let webViewVC = self.storyboard?.instantiateViewController(withIdentifier: ID_WEBVIEWCONTROLLER) as? WebViewController {
            // Set view model for web view model controller
            let webPage = WebPage(title: title, url: url)
            webViewVC.viewModel = WebViewViewModel(withWebPage: webPage)
            self.navigationController?.pushViewController(webViewVC, animated: true)
        }
    }
    
    func performLogout() {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Logout", message: "Are you sure you wish to logout?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.settingsViewModel.logout()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func performDeleteAccount() {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Delete Account", message: "Are you sure you wish to delete account? All data will be erased. This action irreversible!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                // TODO: Add activity spinner
                self.settingsViewModel.deleteAccount()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

// MARK: - TableView UITableViewDelegate, UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingsViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsViewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.settingsViewModel.settingsTitleTextForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = settingsViewModel.reuseIdentifierForCellItem(inSection: indexPath.section, at: indexPath.row)
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? SettingsTableViewCell {
            
            // Set view model for cell. This will configure cell immediately
            cell.viewModel = settingsViewModel.viewModelForCell(inSection: indexPath.section, at: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ID_SETTINGSSECTIONTITLECELL) as? SettingsTableViewSectionHeaderCell {
            cell.titleLabel.text = self.settingsViewModel.settingsTitleTextForSection(section: section)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.settingsViewModel.didSelectRow(inSection: indexPath.section, at: indexPath.row)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
