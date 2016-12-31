//
//  OAShoppingCartOrderTypeView.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/25/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAShoppingCartOrderTypeViewDelegate : UITableViewDataSource, UITableViewDelegate {
  func nextButtonTapped(_ sender: UIButton!)
}

class OAShoppingCartOrderTypeView: UIView {
  
  //MARK: Private Properties
  
  private var contactInfoTableView: UITableView!
  private var nextButton: UIButton!
  private var pickUpRadioView: OARadioButtonTextLabelView!
  private var deliverRadioView: OARadioButtonTextLabelView!
  
  weak private var delegate: OAShoppingCartOrderTypeViewDelegate!
  
  //MARK: Private Constant
  private let kNextButtonWidth: CGFloat = 180.0
  private let kNextButtonHeight: CGFloat = 48.0
  
  //MARK: Life Cycle
  
  convenience init(delegate: OAShoppingCartOrderTypeViewDelegate) {
    self.init(frame: CGRect.zero)
    
    self.delegate = delegate
    
    // configure contact info table view
    contactInfoTableView = UITableView();
    contactInfoTableView.dataSource = delegate
    contactInfoTableView.delegate = delegate
    // remove extra table view cells
    contactInfoTableView.tableFooterView = UIView(frame: CGRect.zero)
    contactInfoTableView.separatorInset = UIEdgeInsets.zero
    contactInfoTableView.separatorColor = OASeparatorColor
    self.addSubview(contactInfoTableView)
    
    //configure item radio views
    pickUpRadioView = OARadioButtonTextLabelView(text: "Pick Up",
                                                 isChecked: false)
    pickUpRadioView.isUserInteractionEnabled = true
    self.addSubview(pickUpRadioView)
    pickUpRadioView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(self.handlePickUpTap)))
    
    deliverRadioView = OARadioButtonTextLabelView(text: "Deliver",
                                                  isChecked: true)
    deliverRadioView.isUserInteractionEnabled = true
    self.addSubview(self.deliverRadioView)
    deliverRadioView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(self.handleDeliverTap)))
    
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
    let yOffset: CGFloat = kOATopLayoutOffset + 36.0
    let pickUpRadioViewBounds = pickUpRadioView.sizeThatFits(CGSize(width: self.bounds.width / 4.0,
                                                                    height: CGFloat.greatestFiniteMagnitude))
    pickUpRadioView.frame = CGRect(
      x: self.bounds.width / 8.0,
      y: yOffset,
      width: self.bounds.width / 4.0,
      height: pickUpRadioViewBounds.height).integral
    
    deliverRadioView.frame = CGRect(
      x: self.bounds.width / 2.0,
      y: yOffset,
      width: self.bounds.width / 4.0,
      height: pickUpRadioViewBounds.height).integral
    
    nextButton.frame = CGRect(
      x: self.bounds.width / 2.0 - kNextButtonWidth / 2.0,
      y: self.bounds.height - kNextButtonHeight - kOATabBarHeight - 20.0,
      width: kNextButtonWidth,
      height: kNextButtonHeight).integral
    
    contactInfoTableView.frame = CGRect(
      x: 0,
      y: pickUpRadioView.frame.maxY,
      width: self.bounds.width,
      height: nextButton.frame.minY - pickUpRadioView.frame.maxY - kOADefaultPadding).integral;
  }
  
  //MARK: UIGestureRecognizer
  
  func handlePickUpTap(_ sender: UITapGestureRecognizer) {
    pickUpRadioView.isChecked = true
    deliverRadioView.isChecked = false
  }
  
  func handleDeliverTap(_ sender: UITapGestureRecognizer) {
    pickUpRadioView.isChecked = false
    deliverRadioView.isChecked = true
  }
  
  //MARK: Button Action
  func buttonTapped(_ sender: UIButton!) {
    delegate.nextButtonTapped(sender)
  }
}
