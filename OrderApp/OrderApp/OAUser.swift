//
//  OAUser.swift
//  OrderApp
//
//  Created by Shawn Xu on 11/26/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import Foundation
import Firebase

struct OAUser {
    
    let uid: String
    let email: String?
    let name: String?
    let photoURL: URL?
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email
        name = authData.displayName
        photoURL = authData.photoURL
    }
    
    init(uid: String, email: String, name: String, photoURL: URL) {
        self.uid = uid
        self.email = email
        self.name = name
        self.photoURL = photoURL
    }
}
