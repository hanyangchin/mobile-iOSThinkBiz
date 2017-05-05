//
//  TextViewCell.swift
//  ThinkBiz
//
//  Created by Han Yang Chin on 3/05/17.
//  Copyright © 2017 Han Yang Chin. All rights reserved.
//

import UIKit

@IBDesignable
class TextViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBInspectable var textViewPlaceholderTextColor: UIColor = UIColor.lightGray
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    var delegate: TextViewCellDelegate?
    
    // MARK: - Private
    
    var minTextViewHeight: CGFloat = 80
    
    fileprivate var textViewTextColor: UIColor?
    
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
        
        // Store original text color from storyboard
        textViewTextColor = textView.textColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(withViewModel viewModel: TextViewCellViewModel) {
        self.nameLabel.text = viewModel.nameLabelText
        
        if viewModel.text == nil {
            showPlaceholderText()
        }
        else if viewModel.text.characters.count > 0 {
            showText()
        } else {
            showPlaceholderText()
        }
    }
    
    func configureTextView() {
        let newTextViewHeight = self.textView.intrinsicContentSize.height
        
        if newTextViewHeight > minTextViewHeight, newTextViewHeight != self.textViewHeightConstraint.constant {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.textViewHeightConstraint.constant = newTextViewHeight
            }, completion: nil)
        }
    }
    
    fileprivate func showText() {
        self.textView.textColor = textViewTextColor
        self.textView.text = viewModel.text
    }
    
    fileprivate func showPlaceholderText() {
        self.textView.textColor = textViewPlaceholderTextColor
        self.textView.text = viewModel.placeholderText
    }
}

extension TextViewCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText string: String) -> Bool {
        let text: NSString = (textView.text ?? "") as NSString
        let textUpdate = text.replacingCharacters(in: range, with: string)
        
        self.viewModel.text = textUpdate
        delegate?.textViewCellTextDidChange(tag: textView.tag, text: textUpdate)
//        self.configureTextView()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if viewModel.text == nil {
            self.textView.textColor = textViewTextColor
            self.textView.text = nil
        }
        else if viewModel.text.characters.count == 0 {
            self.textView.textColor = textViewTextColor
            self.textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.showPlaceholderText()
        }
    }
}
