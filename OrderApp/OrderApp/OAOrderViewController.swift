//
//  OAOrderViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

import Firebase

class OAOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  //MARK:Properties
  
  var menuCategoryView:OAOrderMenuCategoryView?
  let cellIdentifier = "MenuCategoryTableViewCell"
  
  // TODO: define keys from server
  let categoryDBName = "categories"
  let nameKey = "name"
  let quantityKey = "quantity"
  
  private var _ref: FIRDatabaseReference!
  private var _refHandle: FIRDatabaseHandle!
  private var _categories: [FIRDataSnapshot]! = []
  
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
    
    // set up firebase database. might need to be moved to an earlier stage
    self.configureDatabase()
  }
  
  deinit {
    _ref.child(categoryDBName).removeObserverWithHandle(_refHandle)
  }
  
  // UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1;
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return _categories.count;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    // Dequeue cell
    var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    if (cell == nil) {
      cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
    }
    // Unpack message from Firebase DataSnapshot
    let categorySnapshot: FIRDataSnapshot! = _categories[indexPath.row]
    let category = categorySnapshot.value as! Dictionary<String, String>
    let name = category[nameKey] as String!
    let quantity = category[quantityKey] as String!
    cell!.textLabel?.text = name
    cell!.detailTextLabel?.text = quantity
    cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    return cell!
  }
  
  // UITableViewDelegate
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 44.0;
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let categorySnapshot: FIRDataSnapshot! = _categories[indexPath.row]
    let category = categorySnapshot.value as! Dictionary<String, String>
    let name = category[nameKey] as String!
    self.navigationController!.pushViewController(OAOrderSpecificCategoryViewController(categoryType:name),
                                                  animated: true);
    tableView.deselectRowAtIndexPath(indexPath, animated: true);
  }
  
  // Firebase
  func configureDatabase() {
    _ref = FIRDatabase.database().reference()
    // Listen for new messages in the Firebase database
    _refHandle = _ref.child(categoryDBName).observeEventType(.ChildAdded, withBlock: { (snapshot) -> Void in
      self._categories.append(snapshot)
      self.menuCategoryView?.categoryTableView!.insertRowsAtIndexPaths([NSIndexPath(forRow: self._categories.count-1, inSection: 0)], withRowAnimation: .Automatic)
    })
  }
}
