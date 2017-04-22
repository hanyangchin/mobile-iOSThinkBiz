//
//  IdeasViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class IdeasViewController: UIViewController, IdeasViewModelControllerDelegate {

    @IBOutlet weak var ideasCollectionView: UICollectionView!
    @IBOutlet weak var addIdeaButton: UIBarButtonItem!
    
    var viewModel: IdeasViewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = IdeasViewViewModel()
        viewModel.delegate = self
        
        ideasCollectionView.delegate = self
        ideasCollectionView.dataSource = self

        configureView()
    }
    
    func configureView() {
        self.navigationItem.title = viewModel.title
        ideasCollectionView.alwaysBounceVertical = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        return collectionView.dequeueReusableCell(withReuseIdentifier: ID_IDEACELL, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return CGSize(width: view.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right), height: 200)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
}
