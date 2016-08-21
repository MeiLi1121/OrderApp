//
//  OAHomeNavigationController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAHomeNavigationController: UINavigationController {

  convenience init() {
    self.init(nibName: nil, bundle: nil)
    tabBarItem = UITabBarItem(title: "Home",
                              image: UIImage(named: "home"),
                              tag: 1)
    let homeVC = OAHomeViewController()
    self.setViewControllers([ homeVC ], animated: false)
    self.navigationBar.barTintColor = OANavigationBarTintColor
    self.navigationBar.tintColor = OANavigationTintColor
    self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:OANavigationBarTextColor];
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
