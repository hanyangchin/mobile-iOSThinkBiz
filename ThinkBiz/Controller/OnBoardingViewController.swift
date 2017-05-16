//
//  OnBoardingViewController.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 30/03/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var paddingLeft: NSLayoutConstraint!
    
    @IBOutlet var onBoardingOne: UIView!
    @IBOutlet var onBoardingTwo: UIView!
    @IBOutlet var onBoardingThree: UIView!

    var onBoardingScreens = [UIView]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Due to white background, status bar needs to be .default for this VC
        UIApplication.shared.statusBarStyle = .default

        self.scrollView.delegate = self

        self.pageControl.currentPage = 0
        
        self.loadOnBoardingScreens()
    }

    override func viewDidLayoutSubviews() {
        // Update scroll view content size and its internal UI elements after its frame size has been calculated by Auto Layout
        self.updateUIElements()
    }

    // MARK: - Functions
    
    private func loadOnBoardingScreens() -> Void {
        self.addOnBoardingScreen(screen: onBoardingOne)
        self.addOnBoardingScreen(screen: onBoardingTwo)
        self.addOnBoardingScreen(screen: onBoardingThree)
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
    
    // MARK: - Action Handlers

    @IBAction func onGetStartedButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: SEGUE_SIGNUP) as! SignUpViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func onSignInButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: SEGUE_SIGNIN) as! SignInViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = scrollView.frame.width
        let currentPage: CGFloat = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        
        self.pageControl.currentPage = Int(currentPage)
    }
    
}
