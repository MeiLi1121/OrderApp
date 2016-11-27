//
//  OAUserSession.swift
//  OrderApp
//
//  Created by Shawn Xu on 11/26/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import Foundation

class OAUserSession {
    let currentUser: OAUser
    var orderStore: OAOrderStore
    
    init(currentUser: OAUser) {
        self.currentUser = currentUser
        self.orderStore = OAOrderStore()
    }
}
