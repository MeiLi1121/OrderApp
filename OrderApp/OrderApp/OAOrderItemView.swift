//
//  OAOrderItemView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/28/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAOrderItemViewDelegate : OAOrderStepperViewDelegate {
    func addToCartButtonTapped(_ sender: UIButton!, count: Int!)
}

class OAOrderItemView: UIView {
  
  var containerScrollView: UIScrollView!
  var itemNameLabel: UILabel!
  var itemNameSeparator: UIView!
  
  var smallItemRadioView: OARadioButtonTextLabelView!
  var largeItemRadioView: OARadioButtonTextLabelView!
  
  var stepperView: OAOrderStepperView!
  var stepperSeparator: UIView!
  
  var addItemButton: UIButton!
  
  var priceLabel: UILabel!
  var price: Double!
  var count: Int!

  weak var delegate: OAOrderItemViewDelegate!
  
  //MARK: Life Cycle
  convenience init(orderItem: OAOrderItem, delegate: OAOrderItemViewDelegate) {
    self.init(frame: CGRect.zero)
    
    self.delegate = delegate
    self.price = orderItem.price
    self.count = 1
    
    // configure scroll view
    containerScrollView = UIScrollView()
    self.addSubview(containerScrollView)
    
    //configure item name label
    itemNameLabel = UILabel()
    itemNameLabel.text = orderItem.name
    itemNameLabel.font = OALargeBoldTextFont
    containerScrollView.addSubview(itemNameLabel)
    
    //configure separators
    itemNameSeparator = UIView()
    itemNameSeparator.backgroundColor = OASeparatorColor
    containerScrollView.addSubview(self.itemNameSeparator)
    stepperSeparator = UIView()
    stepperSeparator.backgroundColor = OASeparatorColor
    containerScrollView.addSubview(self.stepperSeparator)
    
    //configure item radio views
//    smallItemRadioView = OARadioButtonTextLabelView(text: "Small", isChecked: true)
//    containerScrollView.addSubview(smallItemRadioView)
//    largeItemRadioView = OARadioButtonTextLabelView(text: "Large", isChecked: false)
//    containerScrollView.addSubview(largeItemRadioView)
    
    //configure stepper view
    stepperView = OAOrderStepperView(text: "1", delegate: self.delegate)
    containerScrollView.addSubview(stepperView)
    
    // configure button view
    addItemButton = UIButton()
    addItemButton.setTitle("Add to cart", for: UIControlState())
    addItemButton.setTitleColor(UIColor.white, for: UIControlState())
    addItemButton.backgroundColor = OATabBarBarTintColor
    addItemButton.layer.cornerRadius = 4.0
    addItemButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    containerScrollView.addSubview(addItemButton)
    
    //configure price label
    priceLabel = UILabel()
    priceLabel.text = "Price: $" + String(self.price)
    priceLabel.font = OAPrimaryTextFont
    containerScrollView.addSubview(priceLabel)
  }
  
  //MARK: Layout Views
  override func layoutSubviews() {
    let constrainedWidth = self.bounds.size.width / 2.0 - 2 * kOADefaultPadding
    
    let itemNameLabelBounds = itemNameLabel.sizeThatFits(CGSize(width: constrainedWidth, height: CGFloat.greatestFiniteMagnitude))
    let xOffset = self.bounds.size.width / 2.0 - itemNameLabelBounds.width / 2.0
    itemNameLabel.frame = CGRect(
        x: xOffset,
        y: 20,
        width: itemNameLabelBounds.width,
        height: itemNameLabelBounds.height).integral
    
    itemNameSeparator.frame = CGRect(
        x: 0.0,
        y: itemNameLabel.frame.maxY + 20,
        width: self.bounds.width,
        height: 1.0 / UIScreen.main.scale).integral
    
//    let smallItemRadioViewBounds = smallItemRadioView.sizeThatFits(CGSize(width: self.bounds.width / 4.0, height: CGFloat.greatestFiniteMagnitude))
//    smallItemRadioView.frame = CGRect(
//        x: self.bounds.width / 4.0,
//        y: itemNameSeparator.frame.maxY + 36,
//        width: self.bounds.width / 4.0,
//        height: smallItemRadioViewBounds.height).integral
//    
//    largeItemRadioView.frame = CGRect(
//        x: self.bounds.width / 2.0,
//        y: itemNameSeparator.frame.maxY + 36,
//        width: self.bounds.width / 4.0,
//        height: smallItemRadioViewBounds.height).integral
    
    let stepperViewBounds = stepperView.sizeThatFits(CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
    stepperView.frame = CGRect(
        x: 0.0,
        y: itemNameSeparator.frame.maxY + 36,
        width: self.bounds.width,
        height: stepperViewBounds.height).integral
    
    stepperSeparator.frame = CGRect(
        x: 0.0,
        y: stepperView.frame.maxY + 36,
        width: self.bounds.width,
        height: 1.0 / UIScreen.main.scale).integral
    
    addItemButton.frame = CGRect(
        x: self.bounds.width / 2.0 - 180 / 2.0,
        y: stepperSeparator.frame.maxY + 36,
        width: 180,
        height: 48).integral
    
    let priceLabelBounds = priceLabel.sizeThatFits(CGSize(width: constrainedWidth, height: CGFloat.greatestFiniteMagnitude))
    priceLabel.frame = CGRect(
        x: self.bounds.width / 2.0 - priceLabelBounds.width / 2.0,
        y: addItemButton.frame.maxY + kOADefaultPadding,
        width: priceLabelBounds.width,
        height: priceLabelBounds.height).integral
    
    self.containerScrollView.frame = self.bounds
  }
  
  //MARK: Public APIs
  
  func addItem() {
    if (self.count < 20) {
      self.count = self.count + 1
      self.stepperView.setItemCount(itemCount: self.count)
    }
  }
  
  func removeItem() {
    if (self.count > 0) {
      self.count = self.count - 1
      self.stepperView.setItemCount(itemCount: self.count)
    }
  }
  
  //MARK: Button Action
  
  func buttonTapped(_ sender: UIButton!) {
    self.delegate.addToCartButtonTapped(sender, count: self.count)
  }
}
