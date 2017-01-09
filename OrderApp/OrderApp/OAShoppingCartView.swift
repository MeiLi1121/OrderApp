//
//  OAShoppingCardView.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/21/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAShoppingCartViewDelegate : UITableViewDataSource, UITableViewDelegate {
  func nextButtonTapped(_ sender: UIButton!)
}

class OAShoppingCartView: UIView {
  
  //MARK: Properties
  
  var orderedItemsTableView:UITableView!
  var priceAndTipView: OAShoppingCartPriceAndTipView!
  
  var nextButton: UIButton!
  
  weak var delegate: OAShoppingCartViewDelegate!
  
  //MARK: Life Cycle
  
  convenience init(delegate: OAShoppingCartViewDelegate) {
    self.init(frame: CGRect.zero)
    
    self.delegate = delegate
    self.backgroundColor = UIColor.white
    
    orderedItemsTableView = UITableView();
    orderedItemsTableView?.dataSource = delegate
    orderedItemsTableView?.delegate = delegate
    // remove extra table view cells
    orderedItemsTableView?.tableFooterView = UIView(frame: CGRect.zero)
    self.addSubview(self.orderedItemsTableView!)
    
    
    // configure button view
    nextButton = UIButton()
    nextButton.setTitle("Next", for: UIControlState())
    nextButton.setTitleColor(UIColor.white, for: UIControlState())
    nextButton.backgroundColor = OATabBarBarTintColor
    nextButton.layer.cornerRadius = 4.0
    nextButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    self.addSubview(nextButton)
    
    // configure price and tip view
    priceAndTipView = OAShoppingCartPriceAndTipView()
    self.addSubview(priceAndTipView)
  }
  
  //MARK: Layout
  
  override func layoutSubviews() {
    nextButton.frame = CGRect(
      x: self.bounds.width / 2.0 - 180 / 2.0,
      y: self.bounds.height - 20.0 - 48.0 - 44.0,
      width: kOANextButtonWidth,
      height: kOANextButtonHeight).integral
    
    let priceAndTipViewBounds = priceAndTipView.sizeThatFits(CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
    priceAndTipView.frame = CGRect(
      x: 0,
      y: nextButton.frame.minY - priceAndTipViewBounds.height,
      width: self.bounds.width,
      height: priceAndTipViewBounds.height).integral
    
    orderedItemsTableView.frame = CGRect(
      x: 0,
      y: 0,
      width: self.bounds.width,
      height: priceAndTipView.frame.minY).integral;
  }
  
  //MARK: Button Action
  func buttonTapped(_ sender: UIButton!) {
    delegate.nextButtonTapped(sender)
  }
}
