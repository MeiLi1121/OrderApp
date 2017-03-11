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
  var categories: NSArray?
  
  // TODO: define keys from server
  let categoryDBName = "categories"
  let nameKey = "name"
  let quantityKey = "quantity"
  let dishesKey = "dishes"
  
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
    if let categories = self.categories {
      return categories.count
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Table view cells are reused and should be dequeued using a cell identifier.
    // Dequeue cell
    var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    if (cell == nil) {
      cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: cellIdentifier)
    }
    // Unpack message from Firebase DataSnapshot
//    let categorySnapshot: FIRDataSnapshot! = _categories[(indexPath as NSIndexPath).row]
//    let category = categorySnapshot.value as! Dictionary<String, String>
//    let name = category[nameKey] as String!
//    let quantity = category[quantityKey] as String!
    let currentCategory : NSDictionary? = self.categories?[(indexPath as NSIndexPath).row] as! NSDictionary?
    cell!.textLabel?.text = currentCategory?[nameKey] as! String?
    cell!.detailTextLabel?.text = currentCategory?[quantityKey] as! String?
    cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    return cell!
  }
  
  //MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // should define desired height
    return kOADefaultTableViewCellHeight;
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let categorySnapshot: FIRDataSnapshot! = _categories[(indexPath as NSIndexPath).row]
//    let category = categorySnapshot.value as! Dictionary<String, String>
//    let name = category[nameKey] as String!
    
    let currentCategory : NSDictionary? = self.categories?[(indexPath as NSIndexPath).row] as! NSDictionary?
    let name = currentCategory?[nameKey] as! String?
    let dishes : NSArray = currentCategory?[dishesKey] as! NSArray
    self.navigationController!.pushViewController(OAOrderSpecificCategoryViewController(categoryType:name!, dishes: dishes),
                                                  animated: true);
    tableView.deselectRow(at: indexPath, animated: true);
  }
  
  //MARK: Firebase
  func configureDatabase() {
    //    _ref = FIRDatabase.database().reference()
    //    // Listen for new messages in the Firebase database
    //    _refHandle = _ref.child(categoryDBName).observe(.childAdded, with: { (snapshot) -> Void in
    //      self._categories.append(snapshot)
    //      self.menuCategoryView?.categoryTableView!.insertRows(at: [IndexPath(row: self._categories.count-1, section: 0)], with: .automatic)
    //    })
    if let filePath = Bundle.main.path(forResource: "categories", ofType: "json"), let data = NSData(contentsOfFile: filePath) {
      do {
        let data = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary
        self.categories = data?[categoryDBName] as! NSArray?
      }
      catch {
        //Handle error
      }
    }
  }
}
