//
//  CurrencyTableViewCell.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 5/29/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyIconImage: UIImageView!
    @IBOutlet weak var isSelectedCurrency: UIImageView!
    
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyAbbreviationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTheme()
    }
    
    func configureCell(currencyModel: CurrencyList) {
        currencyIconImage.image = nil
        isSelectedCurrency.image = nil
        if let currencyImage = currencyModel.currencyAbbreviation {
            currencyIconImage.image = UIImage(named: currencyImage)
        }
        
        if currencyModel.isSelected == true {
            isSelectedCurrency.image = UIImage(named: "check")
        } else {
            isSelectedCurrency.image = nil
        }
        
        currencyAbbreviationLabel.text = currencyModel.currencyAbbreviation
        if let scale = currencyModel.currencyScale, let name = currencyModel.currencyName {
            currencyNameLabel.text = "\(String(scale)) \(name)"
        }
    }
}

extension CurrencyTableViewCell: ThemeProtocol {
    func configureTheme() {
        self.theme_backgroundColor = ColorElement.themeGoldCurrecnyPickerBackground
    }
}
