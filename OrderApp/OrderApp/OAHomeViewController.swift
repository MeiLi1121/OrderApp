//
//  OAHomeViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAHomeViewController: UIViewController {
  
  //MARK:Properties
  
  var homeView:OAHomeView?
  
  override func loadView() {
    self.homeView = OAHomeView(frame: CGRectZero)
    self.view = self.homeView
    self.view.setNeedsLayout()
    self.view.layoutIfNeeded()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .Plain,
                                                            target: nil,
                                                            action: nil)
    self.title = "Home"
  }
}
