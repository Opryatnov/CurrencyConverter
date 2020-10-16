//
//  User.swift
//  Tix
//
//  Created by Dzionis on 2/28/20.
//  Copyright © 2020 Dzionis. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var userID: String?
    var firstName: String?
    var lastName: String?
    var title: String?
    var email: String?
    var country: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        userID <- map["id"]
        title <- map["title"]
        email <- map["email"]
        country <- map["residency"]
    }
}
