//
//  OAOrder.swift
//  OrderApp
//
//  Created by Shawn Xu on 11/26/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import Foundation

struct OAOrder {
    var orderDictionary : [OAOrderItem:Int]?
    init() {
        self.orderDictionary = [:]
    }
}
