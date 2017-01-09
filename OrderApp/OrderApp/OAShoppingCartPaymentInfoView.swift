//
//  OAShoppingCartPayInfoView.swift
//  OrderApp
//
//  Created by Shawn Xu on 1/8/17.
//  Copyright © 2017 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAShoppingCartPaymentInfoViewDelegate : UITableViewDataSource, UITableViewDelegate {
  func nextButtonTapped(_ sender: UIButton!)
}

class OAShoppingCartPaymentInfoView: UIView {
  
  //MARK: Private Properties
  var paymentInfoTableView: UITableView!
  private var nextButton: UIButton!
  
  weak private var delegate: OAShoppingCartPaymentInfoViewDelegate!

  //MARK: Life Cycle
  
  convenience init(delegate: OAShoppingCartPaymentInfoViewDelegate) {
    self.init(frame: CGRect.zero)
    
    self.delegate = delegate
    
    // configure payment info table view
    paymentInfoTableView = UITableView();
    paymentInfoTableView.dataSource = delegate
    paymentInfoTableView.delegate = delegate
    // remove extra table view cells
    paymentInfoTableView.separatorInset = UIEdgeInsets.zero
    paymentInfoTableView.separatorColor = OASeparatorColor
    paymentInfoTableView.alwaysBounceVertical = false
    self.addSubview(paymentInfoTableView)
    
    // configure button view
    nextButton = UIButton()
    nextButton.setTitle("Next", for: UIControlState())
    nextButton.setTitleColor(UIColor.white, for: UIControlState())
    nextButton.backgroundColor = OATabBarBarTintColor
    nextButton.layer.cornerRadius = 4.0
    nextButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    self.addSubview(nextButton)
  }
  
  //MARK: Layout
  
  override func layoutSubviews() {
    let yOffset: CGFloat = kOATopLayoutOffset
    
    nextButton.frame = CGRect(
      x: self.bounds.width / 2.0 - kOANextButtonWidth / 2.0,
      y: self.bounds.height - kOANextButtonHeight - kOATabBarHeight - 20.0,
      width: kOANextButtonWidth,
      height: kOANextButtonHeight).integral
    
    paymentInfoTableView.frame = CGRect(
      x: 0,
      y: yOffset + kOADefaultPadding,
      width: self.bounds.width,
      height: nextButton.frame.minY - yOffset - 2 * kOADefaultPadding).integral;
  }
  
  //MARK: Button Action
  func buttonTapped(_ sender: UIButton!) {
    delegate.nextButtonTapped(sender)
  }

}
