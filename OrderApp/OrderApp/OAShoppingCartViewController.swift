//
//  OAShoppingCartViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartViewController: UIViewController, OAShoppingCartViewDelegate, OAShoppingCartItemsTableViewCellDelegate {
  
  //MARK:Properties
  
  var shoppingCartView: OAShoppingCartView?
  let cellIdentifier = "OrderedItemsTableViewCell"
  
  //MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.shoppingCartView = OAShoppingCartView(delegate: self)
    self.view = self.shoppingCartView
    
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    self.title = "Cart"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.shoppingCartView?.orderedItemsTableView.reloadData()
  }
  
  //MARK: UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (OAOrderStore.sharedInstance.order.orderDictionary?.keys.count)!;
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    // Dequeue cell
    var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? OAShoppingCartItemsTableViewCell
    if (cell == nil) {
      cell = OAShoppingCartItemsTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
    }
    let orderItem : OAOrderItem = OAOrderStore.sharedInstance.order.orderItemAtIndex(index: indexPath.row)!
    cell!.orderItem = orderItem
    cell!.selectionStyle = UITableViewCellSelectionStyle.none
    cell!.delegate = self
    return cell!
  }
  
  //MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0;
  }
  
  //MARK: OAShoppingCartViewDelegate
  
  func nextButtonTapped(_ sender: UIButton!) {
    self.navigationController!.pushViewController(OAShoppingCartOrderTypeViewController(),
                                                  animated: true);
  }
  
  //MARK: OAShoppingCartItemsTableViewCellDelegate
  func addSignTapped(cell: UITableViewCell) {
    let itemCell = cell as? OAShoppingCartItemsTableViewCell
    itemCell?.addItem()
    self.shoppingCartView?.priceAndTipView.updatePriceAndTax()
    
  }
  
  func minusSignTapped(cell: UITableViewCell) {
    let itemCell = cell as? OAShoppingCartItemsTableViewCell
    itemCell?.removeItem()
    self.shoppingCartView?.priceAndTipView.updatePriceAndTax()
  }
  
}
