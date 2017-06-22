//
//  IdeasViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit
import CoreData

class IdeasViewController: UIViewController, IdeasViewModelControllerDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var ideasCollectionView: UICollectionView!
    @IBOutlet weak var addIdeaButton: UIBarButtonItem!
    
    @IBOutlet var instructionsView: UIView!
    
    var viewModel: IdeasViewViewModel!
    
    // MARK: - Private Properties
    fileprivate var moreActionSheetAlertController: UIAlertController!
    
    private var refreshControl: UIRefreshControl!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status bar change to white
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Get context
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        viewModel = IdeasViewViewModel(initWithContext: context)
        viewModel.delegate = self
        
        setupView()
        
        viewModel.fetchData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        configureLayout()
        ideasCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Private Functions
    
    func setupView() {
        
        setupNavigationBar()
        
        setupCollectionView()
        
        setupRefreshControl()
        
        configureLayout()
        
        setupMoreActionSheetAlertController()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = viewModel.title
        
        setupLeftBarButtonItem()
    }
    
    private func setupLeftBarButtonItem() {

        let editImage = UIImage(named: "edit")
        editImage?.withRenderingMode(.alwaysTemplate)
        
        let editButton = UIButton(type: .system)
        editButton.setImage(editImage, for: .normal)
        editButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        editButton.tintColor = Styles.white
        
        editButton.addTarget(self, action: #selector(IdeasViewController.addIdeaOnButtonPressed(_:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: editButton)
    }
    
    private func configureLayout() {
        if let flowLayout = ideasCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            // Calculate cell width based on the the section inset
            viewModel.cellWidth = view.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }
    
    private func setupCollectionView() {
        
        ideasCollectionView.delegate = self
        ideasCollectionView.dataSource = self
        
        ideasCollectionView.alwaysBounceVertical = true
        ideasCollectionView.backgroundView = instructionsView
    }
    
    private func setupRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = Styles.gray
        
        refreshControl.addTarget(self, action: #selector(self.refreshControlPulledDown), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            ideasCollectionView.refreshControl = refreshControl
        } else {
            ideasCollectionView.addSubview(refreshControl)
        }
    }
    
    private func setupMoreActionSheetAlertController() {
        moreActionSheetAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: STRING_DELETE, style: .destructive) { (action: UIAlertAction) in
            self.viewModel.ideaMoreDeleteAction()
        }
        
        let cancelAction = UIAlertAction(title: STRING_CANCEL, style: .cancel, handler: nil)
        
        moreActionSheetAlertController.addAction(deleteAction)
        moreActionSheetAlertController.addAction(cancelAction)
    }
    
    // MARK: - IdeasViewModelControllerDelegate
    
    func updateView() {
        ideasCollectionView.backgroundView?.isHidden = viewModel.isInstructionBackgroundHidden
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    // Perform batch operations on ideas collection view from view model
    func performBatchUpdates(_ batchOperations: (() -> Void)?) {
        ideasCollectionView.performBatchUpdates({
            batchOperations?()
        }) { (completed) in
            print("Completed updating batch updates on ideas collection view")
        }
    }
    
    // This function should not be called directly, should be used with batch operations from view model
    func insertIdea(at indexPath: IndexPath) {
        ideasCollectionView.insertItems(at: [indexPath])
    }
    
    // This function should not be called directly, should be used with batch operations from view model
    func updateIdea(at indexPath: IndexPath) {
        if let cell = ideasCollectionView.cellForItem(at: indexPath) as? IdeaCell {
            // This cell have a fixed width
            let ideaCellVM = viewModel.viewModelForCell(at: indexPath)
            ideaCellVM.cellWidth = self.viewModel.cellWidth
            cell.viewModel = ideaCellVM
        }
    }
    
    // This function should not be called directly, should be used with batch operations from view model
    func deleteIdea(at indexPath: IndexPath) {
        ideasCollectionView.deleteItems(at: [indexPath])
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == ID_IDEADETAILVIEWCONTROLLER {
            if let ideaDetailVC = segue.destination as? IdeaDetailViewController {
                if let ideaDetailVM = sender as? IdeaDetailViewModel {
                    ideaDetailVC.viewModel = ideaDetailVM
                }
            }
        }
    }
    
    // MARK: - Action handlers
    @IBAction func addIdeaOnButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SEGUE_NEWIDEA, sender: self)
    }
    
    // Refresh control pull down action
    func refreshControlPulledDown() {
        viewModel.fetchDataFromCloud()
    }
}


// MARK: - UICollectionViewDelegate, DataSource, DelegateFlowLayout
extension IdeasViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID_IDEACELL, for: indexPath) as? IdeaCell {
            let ideaCellVM = viewModel.viewModelForCell(at: indexPath)
            
            // This cell have a fixed width
            ideaCellVM.cellWidth = self.viewModel.cellWidth
            cell.viewModel = ideaCellVM
            cell.delegate = self
            
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: ID_IDEACELL, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ideaDetailVM = viewModel.viewModelForDetailViewControlller(at: indexPath)
        performSegue(withIdentifier: SEGUE_IDEADETAIL, sender: ideaDetailVM)
    }
    
}

// MARK: - IdeaCellDelegate
extension IdeasViewController: IdeaCellDelegate {
    func onMoreButtonPressed(idea: Idea) {
        self.viewModel.moreActionSheetAlertResponder = idea
        self.present(moreActionSheetAlertController, animated: true, completion: nil)
    }
}

