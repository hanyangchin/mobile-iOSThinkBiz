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
    
    var viewModel: IdeasViewViewModel!
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        viewModel = IdeasViewViewModel(initWithContext: context)
        viewModel.delegate = self
        
        ideasCollectionView.delegate = self
        ideasCollectionView.dataSource = self
        
        configureView()
        
        viewModel.fetchData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        configureLayout()
        ideasCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func configureView() {
        
        self.navigationItem.title = viewModel.title
        ideasCollectionView.alwaysBounceVertical = true
        
        configureLayout()
    }
    
    private func configureLayout() {
        if let flowLayout = ideasCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            // Calculate cell width based on the the section inset
            viewModel.cellWidth = view.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        }
    }
    
    // MARK: - IdeasViewModelControllerDelegate
    
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
}

extension IdeasViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        // If no data, display message
        let emptyMessageLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: ideasCollectionView.bounds.width, height: ideasCollectionView.bounds.height))
        emptyMessageLabel.text = "Plan your new idea by pressing the + button"
        emptyMessageLabel.textColor = UIColor.lightGray
        emptyMessageLabel.textAlignment = .center
        
        ideasCollectionView.backgroundView = emptyMessageLabel
        
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ID_IDEACELL, for: indexPath) as? IdeaCell {
            let ideaCellVM = viewModel.viewModelForCell(at: indexPath)
            
            // This cell have a fixed width
            ideaCellVM.cellWidth = self.viewModel.cellWidth
            cell.viewModel = ideaCellVM
            
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

