//
//  IdeasViewModelProtocol.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation
import UIKit

protocol IdeasViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: IdeasViewModelControllerDelegate? { get set }
    
    var title: String! { get }
    var numberOfSections: Int! { get }
    var cellWidth: CGFloat? { get }
    var isInstructionBackgroundHidden: Bool { get }
    
    var moreActionSheetAlertResponder: Idea? { get }
    
    // MARK: - Functions
    func numberOfItems(inSection section: Int) -> Int
    func viewModelForCell(at indexPath: IndexPath) -> IdeaCellViewModel
    func viewModelForDetailViewControlller(at indexPath: IndexPath) -> IdeaDetailViewModel
//    func didSelectRow(inSection section: Int, at index: Int)
    
    func fetchData()

    // MARK: - Idea cell actions
    func ideaMoreDeleteAction()
}

protocol IdeasViewModelControllerDelegate: class {
    
    func updateView()
    
    func beginRefreshing()
    func endRefreshing()
    
    func performBatchUpdates(_ batchOperations:(() -> Void)?)
    
    func insertIdea(at indexPath: IndexPath)
    func updateIdea(at indexPath: IndexPath)
    func deleteIdea(at indexPath: IndexPath)
}
