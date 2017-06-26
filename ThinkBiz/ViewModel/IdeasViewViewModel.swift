//
//  IdeasViewViewModel.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import CoreData
import UIKit

class IdeasViewViewModel: NSObject, IdeasViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: IdeasViewModelControllerDelegate?
    
    var title: String! {
        return "Ideas"
    }
    
    var numberOfSections: Int! {
        return fetchResultsController.sections?.count
    }
    
    var isInstructionBackgroundHidden: Bool {
        var hidden = false
        if let ideaObjects = fetchResultsController.fetchedObjects {
            hidden = ideaObjects.count > 0
        }
        return hidden
    }
    
    var isFetchingData: Bool {
        get { return _isFetchingData }
    }
    
    var cellWidth: CGFloat?
    
    var moreActionSheetAlertResponder: Idea?
    
    // MARK: - Private
    
    fileprivate var fetchResultsController: NSFetchedResultsController<Idea>!
    
    fileprivate var blockOperations = [BlockOperation]()
    
    private let context: NSManagedObjectContext!
    
    fileprivate var _isFetchingData: Bool = false
    
    private var userIdeasDataHandle: UInt?
    
    // MARK: - IdeasViewModelProtocol
    
    required init(initWithContext context: NSManagedObjectContext) {
        self.context = context
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        if let count = fetchResultsController.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> IdeaCellViewModel {
        let idea = fetchResultsController.object(at: indexPath)
        let cellVM = IdeaCellViewModel(withIdea: idea)
        return cellVM
    }
    
    func viewModelForDetailViewControlller(at indexPath: IndexPath) -> IdeaDetailViewModel {
        let idea = fetchResultsController.object(at: indexPath)
        let ideaDetailVM = IdeaDetailViewModel(withIdeaForm: IdeaForm.form, idea: idea)
        return ideaDetailVM
    }
    
    func loadLocalData() {
        print("Loading local data...")
        let fetchRequest: NSFetchRequest<Idea> = Idea.fetchRequest()
        
        // Sort by date - newest first
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        
        // Sort by name
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        
        // TODO: Sort ideas by name/date/tag using filter
        fetchRequest.sortDescriptors = [dateSort]
        //        fetchRequest.sortDescriptors = [nameSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        self.fetchResultsController = controller
        
        // Now perform actual fetch
        do {
            try self.fetchResultsController.performFetch()
        } catch let error as NSError {
            print("\(error)")
        }
        
        // First update the view after loading local data
        self.delegate?.updateView()
    }
    
    // Fetch data from cloud, this is only a single fetch action
    func fetchData() {
        print("Fetching data from cloud...")
        
        _isFetchingData = true
        
        self.delegate?.beginRefreshing()
        
        DataService.sharedInstance.fetchIdeas { (result : Result<[String: AnyObject]>) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let data):
                    // Handle data in the main thread
                    print(data)
                case .Error(let message):
                    print(message)
                }
                
                self._isFetchingData = false
                
                // End refresh control
                self.delegate?.endRefreshing()
                self.delegate?.updateView()
            }
        }
    }
    
    func startObservingData() {
        print("Started observing for data changes from the cloud...")
        
        if let _ = userIdeasDataHandle {
            print("Ignoring startObservingData(), it is already observing data changes for this VC")
        } else {
            // UserDataHandle is nil
            
            userIdeasDataHandle = DataService.sharedInstance.fetchAndObserveIdeas(completion: { (result: Result<[String: AnyObject]>) in
                DispatchQueue.main.async {
                    switch result {
                    case .Success(let data):
                        // Handle data in the main thread
                        print(data)
                    case .Error(let message):
                        print(message)
                    }
                    
                    self.delegate?.updateView()
                }
            })
            
            if let handle = userIdeasDataHandle {
                print("Successfully observe cloud data with handle \(handle)")
            }
            
        }
    }
    
    func stopObservingData() {
        if let handle = userIdeasDataHandle {
            DataService.sharedInstance.stopObservingUserIdeas(handle: handle)
            userIdeasDataHandle = nil
        }
    }
    
    func ideaMoreDeleteAction() {
        print("Idea more delete action pressed")
        if let ideaResponder = moreActionSheetAlertResponder {
            DataService.sharedInstance.deleteIdea(idea: ideaResponder)
            
            // TODO: If deletion was sucessful, reset responder back to nil
            moreActionSheetAlertResponder = nil
        }
    }
    
}

extension IdeasViewViewModel: NSFetchedResultsControllerDelegate {
    
    // Whenever the table view is about to update, it will listen for changes and handle the changes for you
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        self.delegate?.performBatchUpdates({
            for operation in self.blockOperations {
                operation.start()
            }
        })
        self.delegate?.updateView()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIP = newIndexPath {
                blockOperations.append(BlockOperation(block: {
                    self.delegate?.insertIdea(at: newIP)
                }))
            }
        case.delete:
            if let ip = indexPath {
                blockOperations.append(BlockOperation(block: {
                    self.delegate?.deleteIdea(at: ip)
                }))
            }
        case.update:
            if let ip = indexPath {
                blockOperations.append(BlockOperation(block: {
                    self.delegate?.updateIdea(at: ip)
                }))
            }
        case.move:
            // Remove at old index path
            if let ip = indexPath {
                blockOperations.append(BlockOperation(block: {
                    self.delegate?.deleteIdea(at: ip)
                }))
            }
            // Insert at new index path
            if let newIP = newIndexPath {
                blockOperations.append(BlockOperation(block: {
                    self.delegate?.insertIdea(at: newIP)
                }))
            }
            
        }
    }
}

