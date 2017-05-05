//
//  TextViewCell.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 3/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

class TextViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    var delegate: TextViewCellDelegate?
    
    // MARK: - Private
    
    var minTextViewHeight: CGFloat = 80
    
    var viewModel: TextViewCellViewModel! {
        didSet {
            configureCell(withViewModel: self.viewModel)
        }
    }
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textView.delegate = self
        
        // Store min height from storyboard
        minTextViewHeight = textViewHeightConstraint.constant
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(withViewModel viewModel: TextViewCellViewModel) {
        self.nameLabel.text = viewModel.nameLabelText
        self.textView.text = viewModel.text
        
        // TODO: Add placeholder functionality
    }
    
    func configureTextView() {
        let newTextViewHeight = self.textView.intrinsicContentSize.height
        
        if newTextViewHeight > minTextViewHeight, newTextViewHeight != self.textViewHeightConstraint.constant {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.textViewHeightConstraint.constant = newTextViewHeight
            }, completion: nil)
        }
    }
}

extension TextViewCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText string: String) -> Bool {
        let text: NSString = (textView.text ?? "") as NSString
        let textUpdate = text.replacingCharacters(in: range, with: string)
        
        delegate?.textViewCellTextDidChange(tag: textView.tag, text: textUpdate)
        
        return true
    }
}
