//
//  DataService.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 24/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataService {
    
    // MARK: - Shared Instance
    
    static let sharedInstance: DataService = DataService()
    
    var viewContext: NSManagedObjectContext?
    
    // MARK: - Private
    
    // Singleton
    private init() { }
    
    // MARK: - Functions
    
    // MARK: CRUD Idea
    
    func addIdea(ideaData: Dictionary<String, Any>) -> Void {
        
        if let context = viewContext {
            let idea = Idea(context: context)
            idea.name = ideaData[IdeaKV.Name.rawValue] as? String
            idea.idea = ideaData[IdeaKV.Idea.rawValue] as? String
            idea.notes = ideaData[IdeaKV.Notes.rawValue] as? String
            idea.created = ideaData[IdeaKV.Created.rawValue] as? NSDate
            
            do {
                try context.save()
                print("Added new idea")
            } catch let error as NSError {
                print("\(error)")
            }
        }
    }
    
    func updateIdea(idea: Idea, ideaData: Dictionary<String, Any>) -> Void {

        if let context = viewContext {
            idea.name = ideaData[IdeaKV.Name.rawValue] as? String
            idea.idea = ideaData[IdeaKV.Idea.rawValue] as? String
            idea.notes = ideaData[IdeaKV.Notes.rawValue] as? String
            
            do {
                try context.save()
                print("Updated idea")
            } catch let error as NSError {
                print("\(error)")
            }
        }

    }
    
    func deleteIdea(idea: Idea) -> Void {
        print("Deleting new idea")
        
        if let context = viewContext {
            context.delete(idea)
            do {
                try context.save()
            } catch let error as NSError {
                print("\(error)")
            }
        }
    }
}
