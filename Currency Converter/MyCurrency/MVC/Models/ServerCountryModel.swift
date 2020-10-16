//
//  ServerCountryModel.swift
//  bankpro
//
//  Created by Dimon on 1/15/20.
//  Copyright © 2020 Dzionis. All rights reserved.
//

import Foundation
import ObjectMapper

class PhoneFormats: Mappable {
    var code: String?
    var mask: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        code <- map["code"]
        mask <- map["mask"]
    }
    
    init(code: String, mask: String) {
        self.code = code
        self.mask = mask
    }
}

class ServerCountryModel: Mappable {
    var name: String?
    var phoneFormats: [PhoneFormats] = []
    var code: String?
    var imageUrl: String?
    var forResidence: Bool = false

    var choosed: Bool = false

    required init?(map: Map){}

    func mapping(map: Map) {
        name <- map["name"]
        phoneFormats <- map["phoneFormats"]
        code <- map["code"]
        forResidence <- map["forResidence"]
        imageUrl <- map["imageUrl"]
    }
}

class TempCountryModel {
    var name: String?
    var contryCode: String?
    var imageUrl: String?
    var forResidence: Bool = false
    var code: String?
    var mask: String?
    var choosed: Bool = false

    init(name: String, contryCode: String, imageUrl: String, forResidence: Bool, code: String, mask: String) {
        self.name = name
        self.contryCode = contryCode
        self.imageUrl = imageUrl
        self.forResidence = forResidence
        self.code = code
        self.mask = mask
    }
}
