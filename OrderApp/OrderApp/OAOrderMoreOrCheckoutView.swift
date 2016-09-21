//
//  OAOrderMoreOrCheckoutView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/28/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAOrderMoreOrCheckoutViewDelegate : NSObjectProtocol {
  func orderMoreButtonTapped(sender: UIButton!)
  func checkoutButtonTapped(sender: UIButton!)
}

class OAOrderMoreOrCheckoutView: UIView {
  
  var containerScrollView: UIScrollView!
  
  var orderConfirmationLabel: UILabel!
  var orLabel: UILabel!
  
  var orderMoreButton: UIButton!
  var checkoutButton: UIButton!
  
  weak var delegate: OAOrderMoreOrCheckoutViewDelegate!
  
  //MARK: Life Cycle
  convenience init(delegate: OAOrderMoreOrCheckoutViewDelegate) {
    self.init(frame: CGRectZero)
    
    self.delegate = delegate
    // configure scroll view
    containerScrollView = UIScrollView()
    self.addSubview(containerScrollView)
    
    // configure button view
    orderMoreButton = UIButton()
    orderMoreButton.setTitle("Order More", forState: .Normal)
    orderMoreButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    orderMoreButton.backgroundColor = OATabBarBarTintColor
    orderMoreButton.layer.cornerRadius = 4.0
    orderMoreButton.addTarget(self, action: #selector(self.orderMoreButtonTapped), forControlEvents: .TouchUpInside)
    containerScrollView.addSubview(orderMoreButton)
    
    checkoutButton = UIButton()
    checkoutButton.setTitle("Check Out", forState: .Normal)
    checkoutButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    checkoutButton.backgroundColor = OATabBarBarTintColor
    checkoutButton.layer.cornerRadius = 4.0
    checkoutButton.addTarget(self, action: #selector(self.checkoutButtonTapped), forControlEvents: .TouchUpInside)
    containerScrollView.addSubview(checkoutButton)
  }
  
  //MARK: Layout Views
  override func layoutSubviews() {
    orderMoreButton.frame = CGRectIntegral(
      CGRectMake(
        self.bounds.width / 2.0 - 180 / 2.0,
        36,
        180,
        48))
    checkoutButton.frame = CGRectIntegral(
      CGRectMake(
        self.bounds.width / 2.0 - 180 / 2.0,
        CGRectGetMaxY(orderMoreButton.frame) + 36,
        180,
        48))
    
    self.containerScrollView.frame = self.bounds
  }
  
  //MARK: Button Action
  func orderMoreButtonTapped(sender: UIButton!) {
    delegate.orderMoreButtonTapped(sender)
  }
  
  func checkoutButtonTapped(sender: UIButton!) {
    delegate.checkoutButtonTapped(sender)
  }
  
}
