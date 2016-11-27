//
//  OAOrderStore.swift
//  OrderApp
//
//  Created by Shawn Xu on 11/26/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import Foundation

class OAOrderStore {
    var order: OAOrder
    
    init() {
        order = OAOrder()
    }
    
    func addOrderItem(_ orderItem: OAOrderItem) {
        self.order.orderDictionary?.updateValue((self.order.orderDictionary?[orderItem])! + 1, forKey: orderItem)
    }
    
    func removeOrderItem(_ orderItem: OAOrderItem) {
        
    }
    
}
