//
//  String+Bankpro.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 4/20/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation
import UIKit
import SwiftTheme

extension String {
    func textFormattingWithSeparator(fontBeforSeparator: UIFont = UIFont(name: "SFProDisplay-Bold", size: 28)!,
                                     colorFontBeforSeparator: UIColor = #colorLiteral(red: 0.1764705882, green: 0.2039215686, blue: 0.2117647059, alpha: 1),
                                     fontAfterSeparator: UIFont = UIFont(name: "SFProDisplay-Bold", size: 24)!,
                                     colorFontAfterSeparator: UIColor = #colorLiteral(red: 0.6980392157, green: 0.7450980392, blue: 0.7647058824, alpha: 1)) -> NSMutableAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: colorFontBeforSeparator, .font: fontBeforSeparator] as [NSAttributedString.Key : Any]
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)
        if self.contains(".") {
            let range: Range<String.Index> = self.range(of: ".", options: .backwards)!
            let index: Int = self.distance(from: self.startIndex, to: range.lowerBound)
            let amountCharAfterPoint = self.count - index
            if self.count > amountCharAfterPoint {
                let substring = self.suffix(amountCharAfterPoint)
                let attributesSmall = [NSAttributedString.Key.foregroundColor: colorFontAfterSeparator, .font: fontAfterSeparator] as [NSAttributedString.Key: Any]
                let range = (self as NSString).range(of: String(substring))
                if range.location != NSNotFound {
                    attributedString.addAttributes(attributesSmall, range: range)
                }
            }
        }
        return attributedString
    }
    
    func textFormattingStringCombinaiton(
        firstPartString: String,
        baseFont: UIFont = UIFont(name: "SFProDisplay-Regular", size: 22)!,
        baseColor: UIColor = .white,
        secondaryFont: UIFont = UIFont(name: "SFProDisplay-Regular", size: 20)!,
        secondaryColor: UIColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9607843137, alpha: 0.3)) -> NSMutableAttributedString {
        let attributes = [.foregroundColor: baseColor, .font: baseFont] as [NSAttributedString.Key : Any]
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)
        let attributesSmall = [.foregroundColor: secondaryColor, .font: secondaryFont] as [NSAttributedString.Key: Any]
        let range = (self as NSString).range(of: firstPartString)
        if range.location != NSNotFound {
            attributedString.addAttributes(attributesSmall, range: range)
        }
        if self.contains(".") {
            let range: Range<String.Index> = self.range(of: ".", options: .backwards)!
            let index: Int = self.distance(from: self.startIndex, to: range.lowerBound)
            let amountCharAfterPoint = self.count - index
            if self.count > amountCharAfterPoint {
                let substring = self.suffix(amountCharAfterPoint)
                let range = (self as NSString).range(of: String(substring))
                let attributesAfterDot = [.foregroundColor: secondaryColor, .font: baseFont] as [NSAttributedString.Key: Any]
                if range.location != NSNotFound {
                    attributedString.addAttributes(attributesAfterDot, range: range)
                }
            }
        }
        return attributedString
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
    
    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
