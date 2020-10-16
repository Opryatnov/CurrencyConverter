//
//  ConvertTableViewCell.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 6/1/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import UIKit

protocol CalculateDelegate {
    func calculateCurrency(value: String)
}

class ConvertTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyAbbreviationLabel: UILabel!
    
    @IBOutlet weak var currencyValueTextField: UITextField!
    
    @IBOutlet weak var currencyImage: UIImageView!
    @IBOutlet weak var cellSeparatorView: UIView!
    
     var delegate: CalculateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.currencyValueTextField.isUserInteractionEnabled = false
        currencyValueTextField.placeholder = "0.00"
        currencyValueTextField.addTarget(self, action: #selector(calculate), for: .editingChanged)
        configureTheme()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.currencyValueTextField.isUserInteractionEnabled = selected
        
        if selected {
            self.currencyValueTextField.becomeFirstResponder()
            currencyValueTextField.text = ""
        }
    }
    
    @objc func calculate() {
        if let value = currencyValueTextField.text {
            delegate?.calculateCurrency(value: value)
        }
    }
    
    func configureCell(currency: CurrencyList) {
        currencyNameLabel.text = currency.currencyName
        currencyAbbreviationLabel.textAlignment = .left
        
        if let abbreviation = currency.currencyAbbreviation {
            currencyAbbreviationLabel.text = abbreviation
            currencyImage.image = UIImage(named: abbreviation)
        } else {
            currencyImage.image = nil
        }
        currencyValueTextField.placeholder = "0.00"
    }
    
    func configureCell(emptyArray: String) {
        currencyAbbreviationLabel.text = emptyArray
        currencyAbbreviationLabel.textAlignment = .center
        currencyImage.image = nil
        currencyNameLabel.text = nil
        currencyValueTextField.placeholder = nil
        currencyValueTextField.text = nil
    }
}

extension ConvertTableViewCell: ThemeProtocol {
    func configureTheme() {
        self.theme_backgroundColor = ColorElement.themeGoldCurrecnyPickerBackground
        cellSeparatorView.theme_backgroundColor = ColorElement.themeGoldSeparator
    }
}
