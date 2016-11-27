//
//  OAAddress.swift
//  OrderApp
//
//  Created by Shawn Xu on 11/26/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import Foundation

struct OAAddress {
    
    let addressee: String?
    let building: String?
    let street: String?
    let street2: String?
    let city: String?
    let state: String?
    let country: String?
    let postalCode: String?
    
    init(addressee: String,
         building: String,
         street: String,
         street2: String,
         city: String,
         state: String,
         country: String,
         postalCode: String) {
        self.addressee = addressee
        self.building = building
        self.street = street
        self.street2 = street2
        self.city = city
        self.state = state
        self.country = country
        self.postalCode = postalCode
    }
}
