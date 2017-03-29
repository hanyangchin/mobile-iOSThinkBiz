//
//  LandingViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 29/03/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            // Existing user
            performSegue(withIdentifier: SEGUE_MAINTABBAR, sender: self)
        } else {
            // Not logged in
            performSegue(withIdentifier: SEGUE_ONBOARDING, sender: self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
