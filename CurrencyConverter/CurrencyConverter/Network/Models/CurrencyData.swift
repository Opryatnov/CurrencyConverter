//
//  CurrencyData.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 29.04.24.
//

import UIKit

final class CurrencyData: Decodable {
    let currencyID: Int?
    let date: String?
    let currencyAbbreviation: String?
    let currencyScale: Int?
    let currencyName: String?
    let currencyOfficialRate: Double?
    
    var currencyImage: UIImage?
    var isSelected: Bool = false
    var name: String?
    var nameBelarusian: String?
    var nameEnglish: String?
    
    var localisedName: String {
        if #available(iOS 16, *) {
            return setCurrencyName(language: Locale.current.language.languageCode?.identifier ?? "")
        } else {
            return setCurrencyName(language: Locale.current.identifier)
        }
    }
    
    func setCurrencyName(language: String) -> String {
        var tempCurrencyName: String?
        switch language {
        case "be":
            tempCurrencyName = nameBelarusian
        case "en":
            tempCurrencyName = nameEnglish
        case "ru":
            tempCurrencyName = name
        default:
            tempCurrencyName = currencyName
        }
        return tempCurrencyName ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case currencyID = "Cur_ID"
        case date = "Date"
        case currencyAbbreviation = "Cur_Abbreviation"
        case currencyScale = "Cur_Scale"
        case currencyName = "Cur_Name"
        case currencyOfficialRate = "Cur_OfficialRate"
    }
}

final class FullCurrencyData: Decodable {
    let id: Int
    let parentID: Int
    let code: String
    let abbreviation: String
    let name: String
    let nameBelarusian: String
    let nameEnglish: String
    let quotName: String
    let quotNameBelarusian: String
    let quotNameEnglish: String
    let nameMulti: String
    let nameBelarusianMulti: String
    let nameEnglishMulti: String
    let scale: Int
    let periodicity: Int
    let dateStart: String
    let dateEnd: String
    
    // Определение ключей кодирования для каждого поля
    enum CodingKeys: String, CodingKey {
        case id = "Cur_ID"
        case parentID = "Cur_ParentID"
        case code = "Cur_Code"
        case abbreviation = "Cur_Abbreviation"
        case name = "Cur_Name"
        case nameBelarusian = "Cur_Name_Bel"
        case nameEnglish = "Cur_Name_Eng"
        case quotName = "Cur_QuotName"
        case quotNameBelarusian = "Cur_QuotName_Bel"
        case quotNameEnglish = "Cur_QuotName_Eng"
        case nameMulti = "Cur_NameMulti"
        case nameBelarusianMulti = "Cur_Name_BelMulti"
        case nameEnglishMulti = "Cur_Name_EngMulti"
        case scale = "Cur_Scale"
        case periodicity = "Cur_Periodicity"
        case dateStart = "Cur_DateStart"
        case dateEnd = "Cur_DateEnd"
    }
}
