//
//  TextViewWithPlacholder.swift
//  Fx_Invest
//
//  Created by Diana Samusenko on 3/31/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation
import UIKit

class TextViewWithPlacholder: UITextView {
    
    var placeholderLabel: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidStartChange), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidEndChange), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    public var placeholder: String? {
        get {
            var placeholderText: String?
            if let placeholderLabel = placeholderLabel {
                placeholderText = placeholderLabel.text
            }
            return placeholderText
        }
        set {
            if let placeholderLabel = placeholderLabel {
                placeholderLabel.text = newValue
                placeholderLabel.textAlignment = .center
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    private func resizePlaceholder() {
        if let placeholderLabel = placeholderLabel {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 10
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height * 3
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    private func addPlaceholder(_ placeholderText: String) {
        if placeholderLabel == nil {
            placeholderLabel = UILabel()
            placeholderLabel?.text = placeholderText
            placeholderLabel?.sizeToFit()
            placeholderLabel?.numberOfLines = 2
            placeholderLabel?.font = self.font
            placeholderLabel?.textColor = #colorLiteral(red: 0.6439912319, green: 0.6439459324, blue: 0.6709995866, alpha: 1)
            placeholderLabel?.textAlignment = .center
            placeholderLabel?.isHidden = self.text.count > 0
            self.addSubview(placeholderLabel!)
        }
        resizePlaceholder()
    }
    
    @objc public func textViewDidStartChange() {
        if let placeholderLabel = placeholderLabel {
            placeholderLabel.isHidden = true
        }
    }
    
    @objc public func textViewDidEndChange() {
        if let placeholderLabel = placeholderLabel {
            placeholderLabel.isHidden = text.count > 0
        }
    }
}
