//
//  IdeasViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class IdeasViewController: UIViewController {

    @IBOutlet weak var ideasCollectionView: UICollectionView!
    @IBOutlet weak var addIdeaButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addIdeaOnButtonPressed(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: ID_NEWIDEAVIEWCONTROLLER) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
