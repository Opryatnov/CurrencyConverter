//
//  UIButton+.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 4/21/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit

open class BPButton: UIButton {

    @IBInspectable var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedTitle(for: .normal) {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
                setTitle(.none, for: .normal)
            }
            
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            
            setAttributedTitle(attributedString, for: .normal)
        }
        
        get {
            if let currentLetterSpace = attributedTitle(for: .normal)?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
    
    func setAttributedColor(_ color: UIColor, for state: UIControl.State) {
        let attributedString: NSMutableAttributedString!
        if let currentAttrString = attributedTitle(for: .normal) {
            attributedString = NSMutableAttributedString(attributedString: currentAttrString)
        }
        else {
            attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
            setTitle(.none, for: state)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: color,
                                      range: NSRange(location: 0, length: attributedString.length))
        
        setAttributedTitle(attributedString, for: state)
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override open func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        if let currentAttrString = self.attributedTitle(for: state), let title = title {
            let mutableAttributedString = NSMutableAttributedString(attributedString: currentAttrString)
            mutableAttributedString.mutableString.setString(title)
            self.setAttributedTitle(mutableAttributedString, for: state)
        }
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
}

open class SubTextButton : UIButton {
    
    @IBInspectable var subTitle: String? {
        set {
            guard let string = self.titleLabel?.text, string.count > 0, let subString = newValue, subString.count > 0 else { return }
            let finalString = string + "\n" + subString
            let titleFont = ConstantFonts.titleFontKeyPadButtons
            let subtutleFont = ConstantFonts.subtutleFontKeyPadButtons
            let titleRange = finalString.range(of: string)!
            let nsTitleRange = NSRange(titleRange, in: finalString)
            let subStringRange = finalString.range(of: subString)!
            let nsSubtitleRange = NSRange(subStringRange, in: finalString)
            let attributedString = NSMutableAttributedString(string: finalString)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.paragraphSpacingBefore = -2
            attributedString.addAttribute(NSAttributedString.Key.font, value: titleFont!, range: nsTitleRange)
            attributedString.addAttribute(NSAttributedString.Key.font, value: subtutleFont!, range: nsSubtitleRange)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: 3, range: nsSubtitleRange)
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, finalString.count))
            self.titleLabel?.numberOfLines = 0
            self.titleLabel?.lineBreakMode = .byWordWrapping
            self.setAttributedTitle(attributedString, for: .normal)
            self.setTitleColor(.black, for: .normal)
        }
        get {
            return ""
        }
    }
}

class CenteredButton: UIButton {
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.titleRect(forContentRect: contentRect)
        let imageRect = super.imageRect(forContentRect: contentRect)
        
        return CGRect(x: 0, y: imageRect.maxY - 8,
                      width: contentRect.width, height: rect.height)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.imageRect(forContentRect: contentRect)
        let titleRect = self.titleRect(forContentRect: contentRect)
        
        return CGRect(x: contentRect.width/2.0 - rect.width/2.0,
                      y: (contentRect.height - titleRect.height)/2.0 - rect.height/2.0,
                      width: rect.width, height: rect.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        centerTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        centerTitleLabel()
    }
    
    private func centerTitleLabel() {
        self.titleLabel?.textAlignment = .center
    }
}

class CenteredCardButton: UIButton {
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.titleRect(forContentRect: contentRect)
        let imageRect = super.imageRect(forContentRect: contentRect)
        
        return CGRect(x: 0, y: imageRect.maxY - 8,
                      width: contentRect.width, height: rect.height)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.imageRect(forContentRect: contentRect)
        return CGRect(x: contentRect.width/2.0 - rect.width/2.0,
                      y: 0,
                      width: rect.width, height: rect.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        centerTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        centerTitleLabel()
    }
    
    private func centerTitleLabel() {
        self.titleLabel?.textAlignment = .center
    }
}
