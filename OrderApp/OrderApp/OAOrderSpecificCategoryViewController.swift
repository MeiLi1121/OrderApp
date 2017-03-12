//
//  OAOrderSpecificCategoryViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAOrderSpecificCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  //MARK:Properties
  
  var specificCategoryView: OAOrderSpecificCategoryView?
  var categoryType: String?
  var dishes: NSArray?
  let cellIdentifier = "SpecificCategoryTableViewCell"
  
  //MARK: Life Cycle
  convenience init(categoryType: String, dishes: NSArray) {
    self.init()
    self.categoryType = categoryType
    self.dishes = dishes
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.specificCategoryView = OAOrderSpecificCategoryView(dataSource: self, delegate: self)
    self.view = specificCategoryView
    
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    self.title = self.categoryType
  }
  
  // UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let dishes = self.dishes {
      return dishes.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    
    var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    if (cell == nil) {
      cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
    }
    let currentDish : NSDictionary? = self.dishes?[(indexPath as NSIndexPath).row] as! NSDictionary?
    let name = currentDish?["name"] as! String?
    let price = currentDish?["price"] as! String?
    cell!.textLabel!.text = name
    cell!.detailTextLabel!.text = "$" + price!
    cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    return cell!
  }
  
  // UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0;
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let currentDish : NSDictionary? = self.dishes?[(indexPath as NSIndexPath).row] as! NSDictionary?
    let price = currentDish?["price"] as! String?
    let itemId = currentDish?["id"] as! String?
    let itemName = currentDish?["name"] as! String?
    let orderItem = OAOrderItem(id: itemId!, name: itemName!, price: Double(price!)!)
    self.navigationController!.pushViewController(OAOrderItemViewController(orderItem: orderItem),
                                                  animated: true);
    tableView.deselectRow(at: indexPath, animated: true);
  }
}
