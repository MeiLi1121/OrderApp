//
//  OACreditCard.swift
//  OrderApp
//
//  Created by Shawn Xu on 11/26/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import Foundation

struct OACreditCard {

    let address: OAAddress?
    let association: String?
    let expireMonth: String?
    let expireYear: String?
    let firstName: String?
    let lastName: String?
    let cardNumber: String?
    
    init(address: OAAddress,
         association: String,
         expireMonth: String,
         expireYear: String,
         firstName: String,
         lastName: String,
         cardNumber: String) {
        self.address = address
        self.association = association
        self.expireMonth = expireMonth
        self.expireYear = expireYear
        self.firstName = firstName
        self.lastName = lastName
        self.cardNumber = cardNumber
    }
}
