//
//  Formatter+Bankpro.swift
//  Fx_Invest
//
//  Created by Opryatnov Dmitriy on 4/20/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
