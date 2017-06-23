//
//  IdeaCellDelegate.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 7/06/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import Foundation

protocol IdeaCellDelegate {
    
    // MARK: - Functions
    func onMoreButtonPressed(_ sender: Any, idea: Idea) -> Void
}
