//
//  OAOrderMoreOrCheckoutViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/28/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAOrderMoreOrCheckoutViewController: UIViewController, OAOrderMoreOrCheckoutViewDelegate {
  
  var orderMoreOrCheckoutView: OAOrderMoreOrCheckoutView?
  
  //MARK: View Controller
  
  override func loadView() {
    orderMoreOrCheckoutView = OAOrderMoreOrCheckoutView(delegate: self)
    self.view = self.orderMoreOrCheckoutView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Order"
    self.view.backgroundColor = UIColor.white
    // hide back button
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = true;
  }
  
  //MARK: OAOrderMoreOrCheckoutViewDelegate
  
  func orderMoreButtonTapped(_ sender: UIButton!) {
    self.navigationController?.setViewControllers([ OAOrderViewController() ], animated: true)
  }
  
  func checkoutButtonTapped(_ sender: UIButton!) {
    self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers![2]
  }
  
}
