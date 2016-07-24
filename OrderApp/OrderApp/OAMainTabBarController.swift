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

      let profileVC = OAProfileViewController()
      profileVC.tabBarItem = UITabBarItem(title: "Profile",
                                          image: UIImage(named: "profile"),
                                          tag: 1)
      let orderVC = OAOrderViewController()
      orderVC.tabBarItem = UITabBarItem(title: "Order",
                                        image: UIImage(named: "order"),
                                        tag: 2)
      self.viewControllers = [profileVC, orderVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
