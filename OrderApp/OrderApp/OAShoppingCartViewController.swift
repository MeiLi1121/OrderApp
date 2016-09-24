//
//  OAShoppingCartViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  //MARK:Properties
  
  var shoppingCartView:OAShoppingCartView?
  let cellIdentifier = "OrderedItemsTableViewCell"

  //MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.shoppingCartView = OAShoppingCartView(dataSource: self, delegate: self)
    self.view = self.shoppingCartView
    
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    self.title = "Cart"
  }
  
  //MARK: UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //TODO: needs to be the number of ordered items
    return 1;
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    // Dequeue cell
    var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    if (cell == nil) {
      cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
    }
    cell!.textLabel?.text = "Ma Po Tofu"
    cell!.detailTextLabel?.text = "$7.89"
    return cell!
  }
  
  //MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0;
  }
}
