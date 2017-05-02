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
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ideaLabel: UILabel!
    
    var viewModel: IdeaCellViewModel! {
        didSet {
            configureCell(withViewModel: self.viewModel)
        }
    }
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Prevent conflicts from arising by modifying cell constraints
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configureCell(withViewModel viewModel: IdeaCellViewModel) {
        
        self.setDate(date: viewModel.date())
        self.setTitle(title: viewModel.title)
        self.setIdea(idea: viewModel.ideaText)
        
        UIView.animate(withDuration: 0.5,
                                   delay: 0.0,
                                   usingSpringWithDamping: 1,
                                   initialSpringVelocity: 0.5,
                                   options: .curveEaseIn,
                                   animations: { () -> Void in
                                    // If performing rotation, width needs to be updated as well
                                    if let cellWidth = viewModel.cellWidth {
                                        self.widthConstraint.constant = cellWidth
                                    }
                                    self.contentView.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setDate(date: String) {
//        self.dateLabel.text = date
        let attributedText = NSMutableAttributedString(string: date, attributes: [
            NSFontAttributeName: dateLabel.font,
            NSKernAttributeName:CGFloat(0)
            ])
        self.dateLabel.attributedText = attributedText
    }
    
    func setTitle(title t: String) {
//        self.titleLabel.text = t
        let attributedText = NSMutableAttributedString(string: t, attributes: [
            NSFontAttributeName: titleLabel.font,
            NSKernAttributeName:CGFloat(0.5)
            ])
        self.titleLabel.attributedText = attributedText
    }
    
    func setIdea(idea: String) {
//        self.ideaLabel.text = idea
        let attributedText = NSMutableAttributedString(string: idea, attributes: [
            NSFontAttributeName: ideaLabel.font,
            NSKernAttributeName:CGFloat(0)
            ])
        ideaLabel.attributedText = attributedText
    }
}
