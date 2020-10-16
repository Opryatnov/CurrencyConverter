//
//  UILabel.swift
//  Fx_Invest
//
//  Created by Diana Samusenko on 3/31/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit

open class BPLabel : UILabel {
    @IBInspectable open var characterSpacing: CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
    }
}

