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
  
  func orderItemAtIndex(index: Int) -> OAOrderItem? {
    var i: Int = 0
    for (orderItem, _) in self.orderDictionary! {
      if (i == index) {
        return orderItem
      }
      i += 1
    }
    return nil
  }
  
  func currentOrderTotalPrice() -> Double {
    var totalPrice: Double = 0.0
    for (orderItem, count) in self.orderDictionary! {
      totalPrice += orderItem.price * Double(count)
    }
    return totalPrice
  }
  
  func currentOrderTax() -> Double {
    return self.currentOrderTotalPrice() * 0.09
  }
}
