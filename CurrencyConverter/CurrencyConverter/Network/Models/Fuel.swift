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
}
