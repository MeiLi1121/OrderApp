//
//  OAOrderSpecificCategoryView.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAOrderSpecificCategoryView: UIView {

  //MARK: Properties
  
  var dishTableView:UITableView?
  
  //MARK: Life Cycle
  
  convenience init(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
    self.init(frame: CGRectZero)
    self.dishTableView = UITableView();
    self.dishTableView?.dataSource = dataSource
    self.dishTableView?.delegate = delegate
    // remove extra table view cells
    self.dishTableView?.tableFooterView = UIView(frame: CGRect.zero)
    self.addSubview(self.dishTableView!)
    
    self.backgroundColor = UIColor.whiteColor()
  }
  
  //MARK: Layout
  
  override func layoutSubviews() {
    self.dishTableView?.frame = self.bounds;
  }

}
