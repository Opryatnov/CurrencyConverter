//
//  CountryModel.swift
//  Country
//
//  Created by Maksim Akalakulak on 5/14/19.
//  Copyright © 2019 Maksim Akalakulak. All rights reserved.
//

import Foundation
import ObjectMapper

class CountryModal: Mappable {
    var name: String?
    var dialCode: String?
    var code: String?
    var format: String?
    var residence: Bool = false
    var imageURLString: String?
    var placeOfBirth: Bool = false
    
    var choosed: Bool = false

    required init?(map: Map){}
    required init(){}

    func mapping(map: Map) {
        name <- map["name_en"]
        dialCode <- map["code"]
        code <- map["cc"]
        format <- map["mask"]
        residence <- map["forResidence"]
    }
}

extension CountryModal {
    convenience init(serverCountryModel: ServerCountryModel, phoneFormats: PhoneFormats, placeOfBirth: Bool = true, residence: Bool = false) {
        self.init()
        self.name = serverCountryModel.name
        self.dialCode = phoneFormats.code
        self.code = serverCountryModel.code
        self.format = phoneFormats.mask
        self.residence = residence
        self.imageURLString = serverCountryModel.imageUrl
        self.placeOfBirth = placeOfBirth
    }
}
