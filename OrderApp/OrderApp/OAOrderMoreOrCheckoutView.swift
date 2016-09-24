//
//  OAOrderMoreOrCheckoutView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/28/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAOrderMoreOrCheckoutViewDelegate : NSObjectProtocol {
  func orderMoreButtonTapped(_ sender: UIButton!)
  func checkoutButtonTapped(_ sender: UIButton!)
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
    self.init(frame: CGRect.zero)
    
    self.delegate = delegate
    // configure scroll view
    containerScrollView = UIScrollView()
    self.addSubview(containerScrollView)
    
    // configure button view
    orderMoreButton = UIButton()
    orderMoreButton.setTitle("Order More", for: UIControlState())
    orderMoreButton.setTitleColor(UIColor.white, for: UIControlState())
    orderMoreButton.backgroundColor = OATabBarBarTintColor
    orderMoreButton.layer.cornerRadius = 4.0
    orderMoreButton.addTarget(self, action: #selector(self.orderMoreButtonTapped), for: .touchUpInside)
    containerScrollView.addSubview(orderMoreButton)
    
    checkoutButton = UIButton()
    checkoutButton.setTitle("Check Out", for: UIControlState())
    checkoutButton.setTitleColor(UIColor.white, for: UIControlState())
    checkoutButton.backgroundColor = OATabBarBarTintColor
    checkoutButton.layer.cornerRadius = 4.0
    checkoutButton.addTarget(self, action: #selector(self.checkoutButtonTapped), for: .touchUpInside)
    containerScrollView.addSubview(checkoutButton)
  }
  
  //MARK: Layout Views
  override func layoutSubviews() {
    orderMoreButton.frame = CGRect(
        x: self.bounds.width / 2.0 - 180 / 2.0,
        y: 36,
        width: 180,
        height: 48).integral
    checkoutButton.frame = CGRect(
        x: self.bounds.width / 2.0 - 180 / 2.0,
        y: orderMoreButton.frame.maxY + 36,
        width: 180,
        height: 48).integral
    
    self.containerScrollView.frame = self.bounds
  }
  
  //MARK: Button Action
  func orderMoreButtonTapped(_ sender: UIButton!) {
    delegate.orderMoreButtonTapped(sender)
  }
  
  func checkoutButtonTapped(_ sender: UIButton!) {
    delegate.checkoutButtonTapped(sender)
  }
  
}
