//
//  NSMutableAttributedString+Bankpro.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 4/21/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    
    public func setAsLink(_ textToFind:String, linkURL:String) {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            self.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: foundRange)
        }
    }
    
    func getContactLabel(givenName: String, familyName: String) -> NSAttributedString {
        
        let string = givenName + " " + familyName
        
        let attributed = NSMutableAttributedString(string: string, attributes: [.foregroundColor : UIColor.black, .font: UIFont.systemFont(ofSize: 17, weight: .regular)])
        
        let range = (string as NSString).range(of: familyName)
        
        if range.location != NSNotFound {
            attributed.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .semibold)], range: range)
        }
        
        return attributed
    }
}
