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
  
  fileprivate var _ref: FIRDatabaseReference!
  fileprivate var _refHandle: FIRDatabaseHandle!
  fileprivate var _categories: [FIRDataSnapshot]! = []
  
  //MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.menuCategoryView = OAOrderMenuCategoryView(dataSource: self, delegate: self)
    self.view = self.menuCategoryView
    
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    self.title = "Order"
    
    // set up firebase database. might need to be moved to an earlier stage
    self.configureDatabase()
  }
  
  deinit {
    _ref.child(categoryDBName).removeObserver(withHandle: _refHandle)
  }
  
  //MARK: UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return _categories.count;
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    // Dequeue cell
    var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    if (cell == nil) {
      cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
    }
    // Unpack message from Firebase DataSnapshot
    let categorySnapshot: FIRDataSnapshot! = _categories[(indexPath as NSIndexPath).row]
    let category = categorySnapshot.value as! Dictionary<String, String>
    let name = category[nameKey] as String!
    let quantity = category[quantityKey] as String!
    cell!.textLabel?.text = name
    cell!.detailTextLabel?.text = quantity
    cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    return cell!
  }
  
  //MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0;
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let categorySnapshot: FIRDataSnapshot! = _categories[(indexPath as NSIndexPath).row]
    let category = categorySnapshot.value as! Dictionary<String, String>
    let name = category[nameKey] as String!
    self.navigationController!.pushViewController(OAOrderSpecificCategoryViewController(categoryType:name!),
                                                  animated: true);
    tableView.deselectRow(at: indexPath, animated: true);
  }
  
  //MARK: Firebase
  func configureDatabase() {
    _ref = FIRDatabase.database().reference()
    // Listen for new messages in the Firebase database
    _refHandle = _ref.child(categoryDBName).observe(.childAdded, with: { (snapshot) -> Void in
      self._categories.append(snapshot)
      self.menuCategoryView?.categoryTableView!.insertRows(at: [IndexPath(row: self._categories.count-1, section: 0)], with: .automatic)
    })
  }
}
