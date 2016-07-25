//
//  OAOrderMenuCategoryView.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAOrderMenuCategoryView: UIView {

  //MARK: Properties
  
  var categoryTableView:UITableView?
  
  //MARK: Life Cycle
  
  convenience init(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
    self.init(frame: CGRectZero)
    self.categoryTableView = UITableView();
    self.categoryTableView?.dataSource = dataSource
    self.categoryTableView?.delegate = delegate
    // remove extra table view cells
    self.categoryTableView?.tableFooterView = UIView(frame: CGRect.zero)
    self.addSubview(self.categoryTableView!)
    
    self.backgroundColor = UIColor.whiteColor()
  }
  
  //MARK: Layout
  
  override func layoutSubviews() {
    self.categoryTableView?.frame = self.bounds;
  }
}
