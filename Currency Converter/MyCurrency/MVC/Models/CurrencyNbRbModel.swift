//
//  CurrencyNbRbModel.swift
//  Currency Converter
//
//  Created by Opryatnov Dmitriy on 5/28/20.
//  Copyright © 2020 Opryatnov Dmitriy. All rights reserved.
//

import Foundation
import ObjectMapper

//{"Cur_ID":170,"Date":"2020-05-28T00:00:00","Cur_Abbreviation":"AUD","Cur_Scale":1,"Cur_Name":"Австралийский доллар","Cur_OfficialRate":1.6082}

class CurrencyNbRbModel: Mappable {
    var currencyID: String?
    var currencyRateDate: String?
    var currencyAbbreviation: String?
    var currencyScale: Int?
    var currencyName: String?
    var currencyRate: Double?

    required init?(map: Map){}

    func mapping(map: Map) {
        currencyID <- map["Cur_ID"]
        currencyRateDate <- map["Date"]
        currencyAbbreviation <- map["Cur_Abbreviation"]
        currencyScale <- map["Cur_Scale"]
        currencyName <- map["Cur_Name"]
        currencyRate <- map["Cur_OfficialRate"]
    }
}

class CurrencyList: Codable {
    var currencyID: String?
    var currencyRateDate: String?
    var currencyAbbreviation: String?
    var currencyScale: Int?
    var currencyName: String?
    var currencyRate: Double?
    var isSelected: Bool = false
    var enteredValue: Double = 0
    var tempResult: String = ""
    
    init(currency: CurrencyNbRbModel) {
        self.currencyID = currency.currencyID
        self.currencyRateDate = currency.currencyRateDate
        self.currencyAbbreviation = currency.currencyAbbreviation
        self.currencyScale = currency.currencyScale
        self.currencyName = currency.currencyName
        self.currencyRate = currency.currencyRate
    }
    
    var result: String {
        guard let cureScale = currencyScale, let rate = currencyRate else { return ""}
        switch currencyScale {
        case 1:
            return "\(String((Double(cureScale) / rate) * enteredValue))"
        default:
            return "\(String((Double(cureScale) / rate * 100) * enteredValue))"
        }
    }
}
