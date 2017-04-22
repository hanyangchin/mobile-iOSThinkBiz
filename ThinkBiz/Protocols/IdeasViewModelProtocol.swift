//
//  IdeasViewModelProtocol.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation

protocol IdeasViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: IdeasViewModelControllerDelegate? { get set }
    
    var title: String! { get }
    var numberOfSections: Int! { get }
    
    // MARK: - Functions
//    func settingsTitleTextForSection(section: Int) -> String
    func numberOfItems(inSection section: Int) -> Int
//    func viewModelForCell(inSection section: Int, at index:Int) -> SettingsTableViewCellViewModel
//    func reuseIdentifierForCellItem(inSection section: Int, at index: Int) -> String
//    func didSelectRow(inSection section: Int, at index: Int)

}

protocol IdeasViewModelControllerDelegate: class {
    
}
