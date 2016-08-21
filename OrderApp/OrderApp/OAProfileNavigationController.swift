//
//  OAProfileNavigationController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAProfileNavigationController: UINavigationController {
  
  convenience init() {
    self.init(nibName: nil, bundle: nil)
    tabBarItem = UITabBarItem(title: "Profile",
                              image: UIImage(named: "profile"),
                              tag: 4)
    let profileVC = OAProfileViewController()
    self.setViewControllers([ profileVC ], animated: false)
    self.navigationBar.barTintColor = OANavigationBarTintColor
    self.navigationBar.tintColor = OANavigationTintColor
    self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:OANavigationBarTextColor];
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
