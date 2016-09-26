//
//  OAShoppingCartOrderTypeViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/25/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartOrderTypeViewController: UIViewController, OAShoppingCartOrderTypeViewDelegate {
  
  //MARK:Properties
  
  var orderTypeView: OAShoppingCartOrderTypeView?
  let cellIdentifier = "ContactInfoTableViewCell"
  
  //MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.orderTypeView = OAShoppingCartOrderTypeView(delegate: self)
    self.view = self.orderTypeView
    
    self.title = "Select Order Type"
    self.view.backgroundColor = UIColor.white
  }
  
  //MARK: UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //TODO: needs to be the number of ordered items
    return 3;
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    // Dequeue cell
    var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? OAShoppingCartContactInfoTableViewCell
    if (cell == nil) {
      cell = OAShoppingCartContactInfoTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
    }
    cell!.fieldNameLabel.text = "Name"
    return cell!
  }
  
  //MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0;
  }
  
  //MARK: OAShoppingCartViewDelegate
  
  func nextButtonTapped(_ sender: UIButton!) {
    self.navigationController!.pushViewController(OAOrderViewController(),
                                                  animated: true);
  }
}
