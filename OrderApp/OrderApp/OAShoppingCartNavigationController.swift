//
//  OAShoppingCartNavigationController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartNavigationController: UINavigationController {

  convenience init() {
    self.init(nibName: nil, bundle: nil)
    tabBarItem = UITabBarItem(title: "Cart",
                              image: UIImage(named: "shoppingcart"),
                              tag: 3)
    let shoppingCartVC = OAShoppingCartViewController()
    self.setViewControllers([ shoppingCartVC ], animated: false)
    self.navigationBar.barTintColor = OANavigationBarTintColor
    self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:OANavigationBarTextColor];
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
