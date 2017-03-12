//
//  OAOrderItem.swift
//  OrderApp
//
//  Created by Shawn Xu on 11/26/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import Foundation
import Firebase

struct OAOrderItem : Hashable {

    let id: String
    let name: String
    let price: Double
    
    init(id: String, name: String, price: Double) {
        self.id = id
        self.name = name
        self.price = price
    }
  
    
    func toAnyObject() -> Any {
        return [
            "id": id,
            "name": name,
            "price": price as Any
        ]
    }
    
    //MARK: Hashtable
    var hashValue: Int {
        return self.id.hashValue ^ self.name.hashValue ^ self.price.hashValue;
    }
    
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: OAOrderItem, rhs: OAOrderItem) -> Bool {
        return (lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.price == rhs.price)
    }
}
