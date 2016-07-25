//
//  OAOrderViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  //MARK:Properties
  
  var menuCategoryView:OAOrderMenuCategoryView?
  let cellIdentifier = "MenuCategoryTableViewCell"
  
  let categories = [ "Appetizers", "Soup and Noodle", "Entree", "Rice and Noodle", "House Special", "Set Meals", "Vegetable" ]
  let numberForCategories = [ "12", "10", "123", "15", "18", "2", "5" ]
  
  //MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.menuCategoryView = OAOrderMenuCategoryView(dataSource: self, delegate: self)
    self.view = menuCategoryView
    
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .Plain,
                                                            target: nil,
                                                            action: nil)
    self.title = "Order"
  }
  
  // UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1;
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.categories.count;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    
    var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    if (cell == nil) {
      cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
    }
    cell!.textLabel!.text = self.categories[indexPath.row]
    cell!.detailTextLabel!.text = self.numberForCategories[indexPath.row]
    cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    return cell!
  }
  
  // UITableViewDelegate
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 44.0;
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.navigationController!.pushViewController(OAOrderSpecificCategoryViewController(categoryType:self.categories[indexPath.row]),
                                                  animated: true);
    tableView.deselectRowAtIndexPath(indexPath, animated: true);
  }
}
