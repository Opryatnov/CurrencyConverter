//
//  CurrencyConverterTableviewCell.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 22.07.24.
//

import UIKit
import SnapKit

protocol CurrencyDataModelDelegate: AnyObject {
    func didChangeAmount(currency: CurrencyData?)
}

final class CurrencyConverterTableviewCell: BaseTableViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        
        enum CurrencyCodeLabel {
            static let insets: CGFloat = 5
            static let topInset: CGFloat = 2
            static let bottomInset: CGFloat = 5
        }
        
        enum CurrencyView {
            static let topBottom: CGFloat = 5
            static let leftInset: CGFloat = 16
            static let height: CGFloat = 64
        }
        
        enum CurrencyImageView {
            static let leftInset: CGFloat = 10
            static let size: CGFloat = 32
        }
        
        enum VerticalView {
            static let width: CGFloat = 1
        }
        
        enum TextField {
            static let leftInset: CGFloat = 5
            static let rightInset: CGFloat = 16
        }
    }
    
    // MARK: UI
    
    private let currencyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .darkGray5)
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private let currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private let currencyIconImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private let verticalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(resource: .darkGray6)
        
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.text = "0.00"
        textField.textColor = .white
        textField.textAlignment = .right
        
        return textField
    }()
    
    // MARK: Internal properties
    
    static let identifier: String = "CurrencyConverterTableviewCell"
    weak var delegate: CurrencyDataModelDelegate?
    
    // MARK: Private properties
    
    private var textFieldCalculatedWidth: CGFloat {
        contentView.frame.width -
        Constants.CurrencyView.leftInset -
        Constants.CurrencyImageView.size -
        Constants.CurrencyImageView.leftInset -
        Constants.CurrencyCodeLabel.insets -
        currencyCodeLabel.intrinsicContentSize.width -
        Constants.TextField.leftInset -
        Constants.TextField.rightInset
    }
    
    private var currency: CurrencyData?
        
    // MARK: Internal methods
    
    func fill(currency: CurrencyData) {
        self.currency = currency
        currencyIconImageView.image = currency.currencyImage
        currencyCodeLabel.text = currency.currencyAbbreviation
        textField.text = currency.writeOfAmount?.description.toAmountFormat() ?? "0.00"
        textField.delegate = self
    }
    
    // MARK: Private methods
    
    override func configureViews() {
        backgroundColor = .clear
        contentView.addSubview(currencyView)
        currencyView.addSubview(currencyIconImageView)
        currencyView.addSubview(currencyCodeLabel)
        currencyView.addSubview(verticalView)
        currencyView.addSubview(textField)
    }
    
    override func setupConstraints() {
        currencyView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Constants.CurrencyView.topBottom)
            $0.leading.trailing.equalToSuperview().inset(Constants.CurrencyView.leftInset)
            $0.height.equalTo(Constants.CurrencyView.height)
        }
        
        currencyIconImageView.snp.makeConstraints {
            $0.size.equalTo(Constants.CurrencyImageView.size)
            $0.leading.equalToSuperview().inset(Constants.CurrencyImageView.leftInset)
            $0.centerY.equalToSuperview()
        }
        
        currencyCodeLabel.snp.makeConstraints {
            $0.leading.equalTo(currencyIconImageView.snp.trailing).inset(-Constants.CurrencyCodeLabel.insets)
            $0.centerY.equalToSuperview()
        }
        
        verticalView.snp.makeConstraints {
            $0.leading.equalTo(currencyCodeLabel.snp.trailing).inset(-Constants.CurrencyView.leftInset)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(Constants.VerticalView.width)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.TextField.rightInset)
            $0.width.equalTo(textFieldCalculatedWidth).priority(.high)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            textField.becomeFirstResponder()
        }
    }
}

extension CurrencyConverterTableviewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        currencyView.layer.borderWidth = 0
        currencyView.layer.borderColor = UIColor.clear.cgColor
        if textField.text?.isEmpty == true {
            textField.text = "0.00"
        } else {
            let receiveAmountString = textField.text?.replacingOccurrences(of: ",", with: "") ?? ""
            textField.text = receiveAmountString.toAmountFormat()
            currency?.writeOfAmount = Double(receiveAmountString)?.round()
            delegate?.didChangeAmount(currency: currency)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currencyView.layer.borderWidth = 1
        currencyView.layer.borderColor = UIColor(resource: .gold1).cgColor
        textField.text = nil
        textField.addDoneButtonOnKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inputValidator = ValidationFieldType.balanceInputTwoNumbersCurrencyAfterPoint
        
        guard let textFieldText = textField.text,
              let range = Range(range, in: textFieldText) else { return true }
        var updatedText = textFieldText.replacingCharacters(in: range, with: string)

        if updatedText.suffix(1) == "," {
            let lastIndex = updatedText.index(before: updatedText.endIndex)
            updatedText.replaceSubrange(lastIndex...lastIndex, with: ["."])
        }
        let balanceString = updatedText.replacingOccurrences(of: ",", with: "")

        let result = Validator.isValid(balanceString, type: inputValidator)

        if result {
            let balance = Decimal(string: balanceString) ?? 0
            let lastDot: String
            if balanceString.suffix(1) == "." {
                lastDot = "."
            } else {
                lastDot = ""
            }
            var minimumFractionDigits = 0
            if let dotRange = balanceString.range(of: ".") {
                let substring = balanceString[dotRange.upperBound...]
                minimumFractionDigits = substring.count
            }
            let finalString = balance.formattedWithSeparator(minimumFractionDigits) + lastDot
            textField.text = finalString
        }
        
        let receiveAmountString = textField.text?.replacingOccurrences(of: ",", with: "") ?? ""
        currency?.writeOfAmount = Double(receiveAmountString)?.round()
        delegate?.didChangeAmount(currency: currency)
        return false
        
        
        
//        let currentText = textField.text ?? ""
//        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
//        
//        if newText.isEmpty {
//            return true
//        }
//        
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 2
//        formatter.decimalSeparator = "."
//        formatter.groupingSeparator = ","
//        formatter.usesGroupingSeparator = true
//        
//        let cleanedText = newText.replacingOccurrences(of: ",", with: "")
//        
//        if let number = Double(cleanedText), number <= 999999.99 {
//            if let dotIndex = cleanedText.firstIndex(of: ".") {
//                let distance = cleanedText.distance(from: dotIndex, to: cleanedText.endIndex)
//                if distance > 3 {
//                    return false
//                }
//            }
//            
//            if let formattedText = formatter.string(from: NSNumber(value: number)) {
//                let oldCursorPosition = textField.offset(from: textField.beginningOfDocument, to: textField.selectedTextRange!.start)
//                let newCursorPosition = calculateNewCursorPosition(oldText: currentText, newText: formattedText, oldCursorPosition: oldCursorPosition, range: range, replacementString: string)
//                
//                textField.text = formattedText
//                
//                if let startPosition = textField.position(from: textField.beginningOfDocument, offset: newCursorPosition) {
//                    textField.selectedTextRange = textField.textRange(from: startPosition, to: startPosition)
//                }
//                
//                let formattedText = textField.text?.replacingOccurrences(of: ",", with: "")
//                currency?.writeOfAmount = Double(formattedText ?? "")
//                delegate?.didChangeAmount(currency: currency)
//                return false
//            }
//        }
//        
//        if let _ = cleanedText.range(of: #"^\d{0,6}(\.\d{0,2})?$"#, options: .regularExpression) {
//            return true
//        }
//        let formattedText = textField.text?.replacingOccurrences(of: ",", with: "")
//        currency?.writeOfAmount = Double(formattedText ?? "")
//        delegate?.didChangeAmount(currency: currency)
//        return false
    }
//    
//    private func calculateNewCursorPosition(oldText: String, newText: String, oldCursorPosition: Int, range: NSRange, replacementString: String) -> Int {
//        let originalText = (oldText as NSString).replacingCharacters(in: range, with: replacementString)
//        let offset = originalText.count - oldText.count
//        
//        var newCursorPosition = oldCursorPosition + offset
//        
//        var oldGroupingSeparatorCount = 0
//        var newGroupingSeparatorCount = 0
//        
//        for (oldChar, newChar) in zip(oldText, newText) {
//            if oldChar == "," { oldGroupingSeparatorCount += 1 }
//            if newChar == "," { newGroupingSeparatorCount += 1 }
//        }
//        
//        newCursorPosition += (newGroupingSeparatorCount - oldGroupingSeparatorCount)
//        
//        return newCursorPosition
//    }
}
