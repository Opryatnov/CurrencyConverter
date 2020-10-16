//
//  CountriesModel.swift
//  Fx_Invest
//
//  Created by Dimon on 4/16/20.
//  Copyright © 2020 Dimon. All rights reserved.
//

import Foundation
import ObjectMapper

class AllCountries: Mappable {
    var countries: [CountriesModel]?
      
       required init?(map: Map){}

       func mapping(map: Map) {
           countries <- map["countries"]
       }
}

class CountriesModel: Mappable {
    var name: String?
    var code: String?

    required init?(map: Map){}

    func mapping(map: Map) {
        name <- map["name"]
        code <- map["code"]
    }
}

class NewCountriesModel {
    var name: String?
    var code: String?
    var choosed: Bool = false
    
    init(countries: CountriesModel) {
        self.code = countries.code
        self.name = countries.name
    }
}
