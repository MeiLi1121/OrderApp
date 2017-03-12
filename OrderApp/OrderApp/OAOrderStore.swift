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
    
    static let sharedInstance = OAOrderStore()
    
    init() {
        order = OAOrder()
    }
    
    func addOrderItem(_ orderItem: OAOrderItem, count: Int) {
        if let currentCount = self.order.orderDictionary?[orderItem] {
          self.order.orderDictionary?.updateValue(Int(currentCount) + count, forKey: orderItem)
        } else {
          self.order.orderDictionary?.updateValue(count, forKey: orderItem)
        }
    }
    
    func removeOrderItem(_ orderItem: OAOrderItem) {
      self.order.orderDictionary?.removeValue(forKey: orderItem)
    }
    
}
