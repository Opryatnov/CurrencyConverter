//
//  AllCurrencyTableViewCell.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 6/2/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit

class AllCurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var curencyImage: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyAbbreviationLabel: UILabel!
    @IBOutlet weak var currencyRateLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureTheme()
    }
    
    func configureCell(currency: CurrencyList) {
        curencyImage.image = UIImage(named: currency.currencyAbbreviation!)
        currencyNameLabel.text = currency.currencyAbbreviation
        if let scale = currency.currencyScale, let currencyRate = currency.currencyRate, let currencyName = currency.currencyName {
            currencyAbbreviationLabel.text = "\(String(scale)) \(currencyName)"
            currencyRateLable.text = "\(String(currencyRate)) BYN"
        }
    }
}

extension AllCurrencyTableViewCell: ThemeProtocol {
    func configureTheme() {
        self.theme_backgroundColor = ColorElement.themeGoldCurrecnyPickerBackground
    }
}
