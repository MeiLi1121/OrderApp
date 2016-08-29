//
//  OAOrderItemView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/28/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

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
  
  //MARK: Life Cycle
  convenience init(itemName: String) {
    self.init(frame: CGRectZero)
    
    // configure scroll view
    containerScrollView = UIScrollView()
    self.addSubview(containerScrollView)
    
    //configure item name label
    itemNameLabel = UILabel()
    itemNameLabel.text = itemName
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
    smallItemRadioView = OARadioButtonTextLabelView(text: "Small", isChecked: true)
    containerScrollView.addSubview(smallItemRadioView)
    largeItemRadioView = OARadioButtonTextLabelView(text: "Large", isChecked: false)
    containerScrollView.addSubview(largeItemRadioView)
    
    //configure stepper view
    stepperView = OAOrderStepperView(text: "1")
    containerScrollView.addSubview(stepperView)
    
    // configure button view
    addItemButton = UIButton()
    addItemButton.setTitle("Add to cart", forState: .Normal)
    addItemButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    addItemButton.backgroundColor = OATabBarBarTintColor
    addItemButton.layer.cornerRadius = 4.0
    containerScrollView.addSubview(addItemButton)
    
    //configure price label
    priceLabel = UILabel()
    priceLabel.text = "Current Total: $7.95"
    priceLabel.font = OAPrimaryTextFont
    containerScrollView.addSubview(priceLabel)
  }
  
  //MARK: Layout Views
  override func layoutSubviews() {
    let constrainedWidth = self.bounds.size.width / 2.0 - 2 * OADefaultPadding
    
    let itemNameLabelBounds = itemNameLabel.sizeThatFits(CGSizeMake(constrainedWidth, CGFloat.max))
    let xOffset = self.bounds.size.width / 2.0 - itemNameLabelBounds.width / 2.0
    itemNameLabel.frame = CGRectIntegral(
      CGRectMake(
        xOffset,
        20,
        itemNameLabelBounds.width,
        itemNameLabelBounds.height))
    
    itemNameSeparator.frame = CGRectIntegral(
      CGRectMake(
        0.0,
        CGRectGetMaxY(itemNameLabel.frame) + 20,
        self.bounds.width,
        1.0 / UIScreen.mainScreen().scale))
    
    let smallItemRadioViewBounds = smallItemRadioView.sizeThatFits(CGSizeMake(self.bounds.width / 4.0, CGFloat.max))
    smallItemRadioView.frame = CGRectIntegral(
      CGRectMake(
        self.bounds.width / 4.0,
        CGRectGetMaxY(itemNameSeparator.frame) + 36,
        self.bounds.width / 4.0,
        smallItemRadioViewBounds.height))
    
    largeItemRadioView.frame = CGRectIntegral(
      CGRectMake(
        self.bounds.width / 2.0,
        CGRectGetMaxY(itemNameSeparator.frame) + 36,
        self.bounds.width / 4.0,
        smallItemRadioViewBounds.height))
    
    let stepperViewBounds = stepperView.sizeThatFits(CGSizeMake(self.bounds.width, CGFloat.max))
    stepperView.frame = CGRectIntegral(
      CGRectMake(
        0.0,
        CGRectGetMaxY(smallItemRadioView.frame) + 36,
        self.bounds.width,
        stepperViewBounds.height))
    
    stepperSeparator.frame = CGRectIntegral(
      CGRectMake(
        0.0,
        CGRectGetMaxY(stepperView.frame) + 36,
        self.bounds.width,
        1.0 / UIScreen.mainScreen().scale))
    
    addItemButton.frame = CGRectIntegral(
      CGRectMake(
        self.bounds.width / 2.0 - 180 / 2.0,
        CGRectGetMaxY(stepperSeparator.frame) + 36,
        180,
        48))
    
    let priceLabelBounds = priceLabel.sizeThatFits(CGSizeMake(constrainedWidth, CGFloat.max))
    priceLabel.frame = CGRectIntegral(
      CGRectMake(
        self.bounds.width / 2.0 - priceLabelBounds.width / 2.0,
        CGRectGetMaxY(addItemButton.frame) + OADefaultPadding,
        priceLabelBounds.width,
        priceLabelBounds.height))
    
    self.containerScrollView.frame = self.bounds
  }

}

