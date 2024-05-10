//
//  Fuel.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 6.05.24.
//

import Foundation

struct Fuel: Decodable {
    let fuelCode: String?
    let fuelName_RU: String?
    let fuelName_ENG: String?
    let fuelName_BEL: String?
    let cost: Double?
    
    var localisedName: String {
        if #available(iOS 16, *) {
            return setFuelName(language: Locale.current.language.languageCode?.identifier ?? "")
        } else {
            return setFuelName(language: Locale.current.identifier)
        }
    }
    
    func setFuelName(language: String) -> String {
        var tempFuelName: String?
        switch language {
        case "be":
            tempFuelName = fuelName_BEL
        case "en":
            tempFuelName = fuelName_ENG
        case "ru":
            tempFuelName = fuelName_RU
        default:
            tempFuelName = fuelName_ENG
        }
        return tempFuelName ?? ""
    }
}
