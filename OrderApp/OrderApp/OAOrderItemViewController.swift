//
//  OAOrderItemViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/28/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAOrderItemViewController: UIViewController, OAOrderItemViewDelegate {
  
  var itemName: String!
  
  var orderItemView:OAOrderItemView?
  
  //MARK: Life Cycle
  convenience init(itemName: String) {
    self.init()
    self.itemName = itemName
  }
  
  //MARK: View Controller
  
  override func loadView() {
    orderItemView = OAOrderItemView(itemName: itemName, delegate: self)
    self.view = self.orderItemView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Order"
    self.view.backgroundColor = UIColor.whiteColor()
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .Plain,
                                                            target: nil,
                                                            action: nil)
  }
  
  //MARK: OAOrderItemViewDelegate
  
  func addToCartButtonTapped(sender: UIButton!) {
    self.navigationController!.pushViewController(OAOrderMoreOrCheckoutViewController(),
                                                  animated: true);
  }

}
