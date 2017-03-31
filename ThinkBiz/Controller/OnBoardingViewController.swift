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
    
    var onBoardingScreens = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.scrollView.delegate = self

        self.loadOnBoardingScreens()

        self.pageControl.currentPage = 0
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
        let scrollViewWidth: CGFloat = self.scrollView.frame.width
        let scrollViewHeight: CGFloat = self.scrollView.frame.height
        
        print("\n*******************************\(scrollView.frame.width) \(self.view.frame.width)")
        
        self.onBoardingScreens.append(screen)
        
        // Modify screen's frame to include offsets
        screen.frame = CGRect(x: scrollViewWidth * CGFloat(self.onBoardingScreens.count - 1), y: 0, width: scrollViewWidth, height: scrollViewHeight)
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width * CGFloat(onBoardingScreens.count), height: self.scrollView.bounds.height)
        
        self.pageControl.numberOfPages = self.onBoardingScreens.count
        
        self.scrollView.addSubview(screen)
    }

}
