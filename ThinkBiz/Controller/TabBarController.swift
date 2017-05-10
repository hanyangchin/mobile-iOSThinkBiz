//
//  TabBarController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 10/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    
    func setupView() {
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Avenir", size: 10)!], for: .normal)
        
        // Tint color of the buttons
        UITabBar.appearance().tintColor = Styles.accentColor
        
        // Tint color of the unselected buttons
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
    }

}
