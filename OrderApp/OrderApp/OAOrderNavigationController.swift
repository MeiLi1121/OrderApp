//
//  OAOrderNavigationController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAOrderNavigationController: UINavigationController {
  
  convenience init() {
    self.init(nibName: nil, bundle: nil)
    tabBarItem = UITabBarItem(title: "Order",
                              image: UIImage(named: "order"),
                              tag: 2)
    let orderVC = OAOrderViewController()
    self.setViewControllers([ orderVC ], animated: false)
    self.navigationBar.barTintColor = OANavigationBarTintColor
    self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:OANavigationBarTextColor];
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
