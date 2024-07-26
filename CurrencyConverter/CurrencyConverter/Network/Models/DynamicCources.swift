//
//  DynamicCources.swift
//  CurrencyConverter
//
//  Created by Opryatnov on 26.07.24.
//

import Foundation

struct DynamicCources: Decodable {
    let curID: Int
    let date: String
    let curOfficialRate: Double

    enum CodingKeys: String, CodingKey {
        case curID = "Cur_ID"
        case date = "Date"
        case curOfficialRate = "Cur_OfficialRate"
    }
}
