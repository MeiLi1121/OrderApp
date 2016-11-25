//
//  OAMainTabBarController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAMainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeNavVC = OAHomeNavigationController()
        let profileNavVC = OAProfileNavigationController()
        let orderNavVC = OAOrderNavigationController()
        let shoppingCartNavVC = OAShoppingCartNavigationController()
        self.viewControllers = [ homeNavVC, orderNavVC, shoppingCartNavVC, profileNavVC ]
        self.tabBar.tintColor = OATabBarBarTintColor
        self.tabBar.barTintColor =  OATabBarTintColor
        
        // hide back button
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
    }
    
    // Hide status bar iOS 7 or later
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
