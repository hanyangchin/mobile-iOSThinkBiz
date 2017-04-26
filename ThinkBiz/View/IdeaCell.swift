//
//  IdeaCell.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 20/04/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class IdeaCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel: IdeaCellViewModel! {
        didSet {
            configureCell(withViewModel: self.viewModel)
        }
    }
    
    // MARK: - Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupViews()
    }
    
    func configureCell(withViewModel viewModel: IdeaCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.ideaTextView.text = viewModel.ideaText
    }
    
    func setupViews() {
//        backgroundColor = UIColor.white
        
        addSubview(ideaImageView)
        addSubview(titleLabel)
        addSubview(ideaTextView)
        
        addContraintsWithVisualFormat(format: "H:|-8-[v0(44)]-8-[v1]-8-|", views: ideaImageView, titleLabel)
        
        addContraintsWithVisualFormat(format: "H:|-4-[v0]-4-|", views: ideaTextView)
        
        addContraintsWithVisualFormat(format: "V:|-12-[v0]", views: titleLabel)
        
        addContraintsWithVisualFormat(format: "V:|-8-[v0(44)]-4-[v1]-8-|", views: ideaImageView, ideaTextView)
        
    }
    
    // MARK: UI Components generator
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "ThinkBiz", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "\n13 January  •  App  •  ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: GlobalVariables.gray]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "lightbulb")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
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
        textView.text = "Sell coffee at Queen Street to people who needs help waking up in the morning Sell coffee at Queen Street to people who needs help waking up in the morning Sell coffee at Queen Street to people who needs help waking up in the morning Sell coffee at Queen Street to people who needs help waking up in the morning"
        textView.font = UIFont.systemFont(ofSize: 28)
        return textView
    }()
    
    let menuButton: UIButton = {
       let button = UIButton()
        return button
    }()
}
