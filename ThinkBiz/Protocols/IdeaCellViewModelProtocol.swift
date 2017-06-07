//
//  IdeaCellViewModelProtocol.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 21/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

protocol IdeaCellViewModelProtocol {
    
    // MARK: - Properties
    var title: String! { get }
    var ideaText: String! { get }
    var imagePath: String! { get }
    
    var cellWidth: CGFloat? { get }
    
    var idea: Idea! { get }
    
    // MARK: - Functions
    func date() -> String
}
