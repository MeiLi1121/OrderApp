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
  
  //MARK: Properties
  
  var contantInfoTableView: UITableView!
  
  var nextButton: UIButton!
  
  var pickUpRadioView: OARadioButtonTextLabelView!
  var deliverRadioView: OARadioButtonTextLabelView!
  
  weak var delegate: OAShoppingCartOrderTypeViewDelegate!
  
  //MARK: Life Cycle
  
  convenience init(delegate: OAShoppingCartOrderTypeViewDelegate) {
    self.init(frame: CGRect.zero)
    
    self.delegate = delegate

    
    contantInfoTableView = UITableView();
    contantInfoTableView?.dataSource = delegate
    contantInfoTableView?.delegate = delegate
    // remove extra table view cells
    contantInfoTableView?.tableFooterView = UIView(frame: CGRect.zero)
    self.addSubview(self.contantInfoTableView!)
    
    //configure item radio views
    pickUpRadioView = OARadioButtonTextLabelView(text: "Pick Up", isChecked: false)
    self.addSubview(self.pickUpRadioView!)
    deliverRadioView = OARadioButtonTextLabelView(text: "Deliver", isChecked: true)
    self.addSubview(self.deliverRadioView!)
    
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
    let yOffset: CGFloat = 64.0 + 36.0
    let pickUpRadioViewBounds = pickUpRadioView.sizeThatFits(CGSize(width: self.bounds.width / 4.0, height: CGFloat.greatestFiniteMagnitude))
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
      x: self.bounds.width / 2.0 - 180 / 2.0,
      y: self.bounds.height - 20.0 - 48.0 - 44.0,
      width: 180,
      height: 48).integral
    
    contantInfoTableView.frame = CGRect(
      x: 0,
      y: pickUpRadioView.frame.maxY + OADefaultPadding - 64.0,
      width: self.bounds.width,
      height: nextButton.frame.minY - pickUpRadioView.frame.maxY - OADefaultPadding).integral;
  }

  //MARK: Button Action
  func buttonTapped(_ sender: UIButton!) {
    delegate.nextButtonTapped(sender)
  }
}
