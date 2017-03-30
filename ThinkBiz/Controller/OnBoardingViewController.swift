//
//  OnBoardingViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 30/03/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let scrollViewWidth: CGFloat = self.scrollView.frame.width
        let scrollViewHeight: CGFloat = self.scrollView.frame.height
        
        self.titleTextView.textAlignment = .center
        titleTextView.text = "hahahahah let set this first"
        
        let imageOne = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        imageOne.image = UIImage(named: "lightbulb")
        imageOne.contentMode = .scaleAspectFit
        
        let imageTwo = UIImageView(frame: CGRect(x: scrollViewWidth, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        imageTwo.image = UIImage(named: "lightbulb")
        imageTwo.contentMode = .scaleAspectFit
        
        self.scrollView.addSubview(imageOne)
        self.scrollView.addSubview(imageTwo)
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * 2, height: self.scrollView.frame.height)
        
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onGetStartedButtonPressed(_ sender: UIButton) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = scrollView.frame.width
        let currentPage: CGFloat = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        
        self.pageControl.currentPage = Int(currentPage)
        
        if Int(currentPage) == 0 {
            titleTextView.text = "Brainstorm and plan your business ideas in one place"
        } else if Int(currentPage) == 1 {
            titleTextView.text = "Second page dsfasdfsafdsafds sdfasdfsaf"
        }
    }

}
