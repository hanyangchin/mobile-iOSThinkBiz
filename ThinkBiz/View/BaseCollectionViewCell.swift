//
//  BaseCollectionViewCell.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 28/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initCell()
    }
    
    // MARK: - Functions
    func initCell() { }
    
}
