//
//  OAShoppingCardView.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/21/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartView: UIView {
  
  //MARK: Properties
  
  var orderedItemsTableView:UITableView?
  
  //MARK: Life Cycle
  
  convenience init(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
    self.init(frame: CGRect.zero)
    self.orderedItemsTableView = UITableView();
    self.orderedItemsTableView?.dataSource = dataSource
    self.orderedItemsTableView?.delegate = delegate
    // remove extra table view cells
    self.orderedItemsTableView?.tableFooterView = UIView(frame: CGRect.zero)
    self.addSubview(self.orderedItemsTableView!)
    
    self.backgroundColor = UIColor.white
  }
  
  //MARK: Layout
  
  override func layoutSubviews() {
    self.orderedItemsTableView?.frame = self.bounds;
  }
}
