//
//  Validator.swift
//  Ginger
//
//  Created by Dzionis on 1/3/19.
//  Copyright © 2019 Sahand Edrisian. All rights reserved.
//

import Foundation

final class Validator {
    
    class func isValid(_ value: String, type: ValidationFieldType) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", type.businessRule)
        return predicate.evaluate(with: value)
    }
    
}

enum ValidationFieldType {
    
    case none
    case email
    case phone
    case firstName
    case lastName
    case message
    case passcode
    case amount
    case accountNumber
    case userID
    case paypalID
    case privateKeyCryptoWallet
    
    case password
    case passwordOneLowerCase
    case passwordOneCapitalCase
    case passwordOneNumber
    case passwordOneSpecialSymbol
    case passwordLenght
    
    case balanceInputFourNumbersAfterPoint
    case balanceInputTwoNumbersAfterPoint
    
    var businessRule: String {
        switch self {
        case .none:
            return ".+"
        case .email:
            return "^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-' ']+)+$"
        case .firstName:
            return "^[a-zA-Z ]{2,}$"
        case .lastName:
            return "^[a-zA-Z ]{2,}$"
        case .message:
            return "^[0-9a-zA-Z\\. ]+$"
        case .phone:
            return ".+"
        case .amount:
            return "^\\d+(\\.\\d{1,2})?$"
        case .passcode:
            return "^\\d{1,}$"
        case .accountNumber:
            return "^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})$"
        case .userID:
            return "^[0-9a-zA-Z-]+$"
        case .paypalID:
            return "^[0-9a-zA-Z-_]+$"
        case .privateKeyCryptoWallet:
            return "^(?=.*[A-Z])(.){8,}$"
            
        case .password:
            return "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-=\\[\\]\\;,./~!@#$%^&*()_+{}|:<>?]).{8,}$"
        case .passwordOneCapitalCase:
            return "^.*[A-Z].*"
        case .passwordOneLowerCase:
            return ".*[a-z].*"
        case .passwordOneNumber:
            return ".*[0-9].*"
        case .passwordOneSpecialSymbol:
            return ".*[-=\\[\\]\\;,./~!@#$%^&*()_+{}|:<>?].*"
        case .passwordLenght:
            return "^.{8,}$"
        case .balanceInputFourNumbersAfterPoint:
            return "(^[0-9]{0,16}$|(^[0-9]{0,16}(\\.\\d{0,4})?$))"
        case .balanceInputTwoNumbersAfterPoint:
            return "(^[0-9]{0,16}$|(^[0-9]{0,16}(\\.\\d{0,2})?$))"
        }
    }
}
