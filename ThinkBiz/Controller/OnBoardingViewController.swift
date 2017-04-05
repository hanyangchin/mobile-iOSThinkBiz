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
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var paddingLeft: NSLayoutConstraint!
    
    var onBoardingScreens = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.scrollView.delegate = self

        self.pageControl.currentPage = 0
        
        self.loadOnBoardingScreens()
    }

    override func viewDidLayoutSubviews() {
        // Update scroll view content size and its internal UI elements after its frame size has been calculated by Auto Layout
        self.updateUIElements()
    }

    private func loadOnBoardingScreens() -> Void {
        
        let onBoardingScreen1 = generateView(withText: "This is supposed to be text 1", imageName: "lightbulb")
        let onBoardingScreen2 = generateView(withText: "This is supposed to be text 2", imageName: "lightbulb")
        let onBoardingScreen3 = generateView(withText: "This is supposed to be text 3", imageName: "lightbulb")
        
        self.addOnBoardingScreen(screen: onBoardingScreen1)
        self.addOnBoardingScreen(screen: onBoardingScreen2)
        self.addOnBoardingScreen(screen: onBoardingScreen3)
    }
    
    private func generateView(withText text: String!, imageName: String!) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 30
        
        if text.characters.count > 0 {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.numberOfLines = 3
            titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            titleLabel.textColor = .black
            titleLabel.textAlignment = .center
            titleLabel.text = text
            stackView.addArrangedSubview(titleLabel)
        }
        
        if imageName.characters.count > 0 {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: imageName)
            imageView.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(imageView)
        }
        
        return stackView
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = scrollView.frame.width
        let currentPage: CGFloat = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        
        self.pageControl.currentPage = Int(currentPage)
    }
    
    func addOnBoardingScreen(screen: UIView!) -> Void {
        
        self.onBoardingScreens.append(screen)
        
        self.updateScreenFrame(screen: screen, index: self.onBoardingScreens.count - 1)
        
        // This scrollview content size will be updated after viewDidLayoutSubviews
        self.scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(onBoardingScreens.count), height: scrollView.frame.height)
        
        self.pageControl.numberOfPages = self.onBoardingScreens.count
        
        self.scrollView.addSubview(screen)
    }
    
    private func updateUIElements() {
        
        self.scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(onBoardingScreens.count), height: scrollView.frame.height)
        
        // Update all UI element frames inside the scroll view
        for (index, value) in onBoardingScreens.enumerated() {
            self.updateScreenFrame(screen: value, index: index)
        }
    }
    
    private func updateScreenFrame(screen: UIView!, index: Int!) {
        // Apply padding (using same padding as the bottom) to individual on boarding screens.
        screen.frame = CGRect(x: self.scrollView.frame.width * CGFloat(index) + paddingLeft.constant, y: 0, width: self.scrollView.frame.width - CGFloat(paddingLeft.constant*2), height: scrollView.frame.height)
    }

    @IBAction func onGetStartedButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SEGUE_SIGNUP, sender: self)
    }
    @IBAction func onSignInButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SEGUE_LOGIN, sender: self)
    }
}
