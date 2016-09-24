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
  
  var specificCategoryView:OAOrderSpecificCategoryView?
  var categoryType:String?
  let cellIdentifier = "SpecificCategoryTableViewCell"
  
  let dishes = [
    "Egg Roll (4 Pcs)",
    "Fried Wonton (10 Pcs)",
    "Paper Wrapped Chicken (6 Pcs)",
    "Fried Shrimp (6 Pcs)",
    "Potstickers (10 Pcs)"
  ]
  let prices = [
    "$5.45",
    "$4.45",
    "$5.95",
    "$6.45",
    "$7.95"
  ]
  
  //MARK: Life Cycle
  convenience init(categoryType: String) {
    self.init()
    self.categoryType = categoryType
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
    return self.dishes.count;
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    
    var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    if (cell == nil) {
      cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
    }
    cell!.textLabel!.text = self.dishes[(indexPath as NSIndexPath).row]
    cell!.detailTextLabel!.text = self.prices[(indexPath as NSIndexPath).row]
    cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    return cell!
  }
  
  // UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0;
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.navigationController!.pushViewController(OAOrderItemViewController(itemName: self.dishes[(indexPath as NSIndexPath).row]),
                                                  animated: true);
    tableView.deselectRow(at: indexPath, animated: true);
  }
}
