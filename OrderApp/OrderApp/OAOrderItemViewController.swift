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
  var price: Double!
  
  var orderItemView:OAOrderItemView?
  
  //MARK: Life Cycle
  convenience init(itemName: String, price: Double) {
    self.init()
    self.itemName = itemName
    self.price = price
  }
  
  //MARK: View Controller
  
  override func loadView() {
    orderItemView = OAOrderItemView(itemName: itemName, price: price, delegate: self)
    self.view = self.orderItemView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Order"
    self.view.backgroundColor = UIColor.white
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
  }
  
  //MARK: OAOrderItemViewDelegate
  
  func addToCartButtonTapped(_ sender: UIButton!) {
    self.navigationController!.pushViewController(OAOrderMoreOrCheckoutViewController(),
                                                  animated: true);
  }
  
  func addSignTapped() {
    self.orderItemView?.addItem()
  }
  
  func minusSignTapped() {
    self.orderItemView?.removeItem()
  }

}
