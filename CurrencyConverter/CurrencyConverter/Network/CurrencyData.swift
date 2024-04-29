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
    
    
    enum CodingKeys: String, CodingKey {
        case currencyID = "Cur_ID"
        case date = "Date"
        case currencyAbbreviation = "Cur_Abbreviation"
        case currencyScale = "Cur_Scale"
        case currencyName = "Cur_Name"
        case currencyOfficialRate = "Cur_OfficialRate"
    }
}
