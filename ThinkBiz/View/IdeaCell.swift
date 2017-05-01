//
//  IdeaCell.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class IdeaCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel: IdeaCellViewModel! {
        didSet {
            configureCell(withViewModel: self.viewModel)
        }
    }
    
    // MARK: - Private
    
    private let padding = 12
    
    private let headerHeight = 20
    
    // MARK: - Functions
    
    func configureCell(withViewModel viewModel: IdeaCellViewModel) {
        self.setDate(date: viewModel.date())
        self.setTitle(title: viewModel.title)
        self.setIdea(idea: viewModel.ideaText)
    }
    
    override func initCell() {
        
        addSubview(dateLabel)
        addSubview(moreButton)
        addSubview(seperator)
        addSubview(titleLabel)
        addSubview(ideaTextView)
        
        // Horizontal constraints
        addContraintsWithVisualFormat(format: "H:|-12-[v0]-[v1(20)]-12-|", views: dateLabel, moreButton)
        addContraintsWithVisualFormat(format: "H:|-12-[v0]-12-|", views: seperator)
        addContraintsWithVisualFormat(format: "H:|-12-[v0]-12-|", views: titleLabel)
        addContraintsWithVisualFormat(format: "H:|-12-[v0]-12-|", views: ideaTextView)
        
        // Vertical constraints
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .centerY, relatedBy: .equal, toItem: moreButton, attribute: .centerY, multiplier: 1, constant: 0))
        
        addContraintsWithVisualFormat(format: "V:|-12-[v0(20)]-4-[v1(0.5)]-10-[v2(20)]-0-[v3]-12-|", views: moreButton, seperator, titleLabel, ideaTextView)

    }
    
    func setDate(date: String) {
        
        var font = UIFont.systemFont(ofSize: 12)
        if let latoFont = UIFont(name: "Lato-Regular", size: 12) {
            font = latoFont
            self.dateLabel.font = latoFont
        }
        
        let attributedText = NSMutableAttributedString(string: date, attributes: [
            NSFontAttributeName: font,
            NSKernAttributeName:CGFloat(0)
            ])
        self.dateLabel.attributedText = attributedText
    }
    
    func setTitle(title t: String) {
        
        var font = UIFont.boldSystemFont(ofSize: 23)
        if let latoFont = UIFont(name: "Lato-Regular", size: 23) {
            font = latoFont
            self.titleLabel.font = latoFont
        }
        
        let attributedText = NSMutableAttributedString(string: t, attributes: [
            NSFontAttributeName: font,
            NSKernAttributeName:CGFloat(0.5)
            ])
        self.titleLabel.attributedText = attributedText
    }
    
    func setIdea(idea: String) {
        
        var font = UIFont.systemFont(ofSize: 18)
        if let latoFont = UIFont(name: "Lato-Regular", size: 18) {
            font = latoFont
            ideaTextView.font = latoFont
        }
        
        let attributedText = NSMutableAttributedString(string: idea, attributes: [
            NSFontAttributeName: font,
            NSKernAttributeName:CGFloat(0)
            ])
        ideaTextView.attributedText = attributedText
    }
    
    // MARK: UI Components generator
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.lightGray
        
        var font = UIFont.systemFont(ofSize: 12)
        if let latoFont = UIFont(name: "Lato-Regular", size: 12) {
            font = latoFont
            label.font = latoFont
        } else {
            label.font = UIFont.systemFont(ofSize: 12)
        }
        
        let attributedText = NSMutableAttributedString(string: "Date", attributes: [
            NSFontAttributeName: font,
            NSKernAttributeName:CGFloat(0)
            ])
        label.attributedText = attributedText
        
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        var font = UIFont.boldSystemFont(ofSize: 23)
        if let latoFont = UIFont(name: "Lato-Regular", size: 23) {
            font = latoFont
            label.font = latoFont
        } else {
            label.font = UIFont.boldSystemFont(ofSize: 23)
        }
        
        let attributedText = NSMutableAttributedString(string: "Title", attributes: [
            NSFontAttributeName: font,
            NSKernAttributeName:CGFloat(0.5)
            ])
        label.attributedText = attributedText
        
        label.backgroundColor = UIColor.lightGray
        
        return label
        
    }()
    
    let ideaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lightbulb")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let ideaTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.darkGray
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        
        var font = UIFont.systemFont(ofSize: 18)
        if let latoFont = UIFont(name: "Lato-Regular", size: 18) {
            font = latoFont
            textView.font = latoFont
        } else {
            textView.font = UIFont.systemFont(ofSize: 18)
        }
        
        let attributedText = NSMutableAttributedString(string: "Idea", attributes: [
            NSFontAttributeName: font,
            NSKernAttributeName:CGFloat(0)
            ])
        textView.attributedText = attributedText
        
        textView.backgroundColor = UIColor.cyan
        
        return textView
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor.gray
        //        button.backgroundColor = UIColor.lightGray
        
        //        button.addTarget(self, action: #selector(moreButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let seperator: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.lightGray
        return v
    }()
}
