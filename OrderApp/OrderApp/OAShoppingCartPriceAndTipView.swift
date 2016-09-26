//
//  OAShoppingCartPriceAndTipView.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/25/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartPriceAndTipView: UIView {
  var orderTotalTextLabel: UILabel!
  var orderTotalPriceLabel: UILabel!
  var orderTaxTextLabel: UILabel!
  var orderTaxPriceLabel: UILabel!
  
  var orderTipsTextLabel: UILabel!
  var orderTipAmountLabel: UILabel!
  
  var orderTotalWithTipTextLabel: UILabel!
  var orderTotalWithTipPriceLabel: UILabel!
  
  let orderTotalTextLabelTitle = "Order Total:"
  let orderTaxTextLabelTitle = "Tax (9.0%):"
  let orderTipsTextLabelTitle = "Tips:"
  
  var orderTipsButtonArray: [UIButton] = []
  
  //MARK: Life Cycle
  convenience init() {
    self.init(frame: CGRect.zero)
    
    // configure labels
    orderTotalTextLabel = UILabel()
    orderTotalTextLabel.text = orderTotalTextLabelTitle
    orderTotalTextLabel.font = OAPrimaryTextFont
    self.addSubview(orderTotalTextLabel)
    
    orderTotalPriceLabel = UILabel()
    orderTotalPriceLabel.text = "$21.25"
    orderTotalPriceLabel.font = OAPrimaryTextFont
    self.addSubview(orderTotalPriceLabel)
    
    orderTaxTextLabel = UILabel()
    orderTaxTextLabel.text = orderTaxTextLabelTitle
    orderTaxTextLabel.font = OAPrimaryTextFont
    self.addSubview(orderTaxTextLabel)
    
    orderTaxPriceLabel = UILabel()
    orderTaxPriceLabel.text = "$2.15"
    orderTaxPriceLabel.font = OAPrimaryTextFont
    self.addSubview(orderTaxPriceLabel)
    
    orderTipsTextLabel = UILabel()
    orderTipsTextLabel.text = orderTipsTextLabelTitle
    orderTipsTextLabel.font = OAPrimaryTextFont
    self.addSubview(orderTipsTextLabel)
    
    for i in 0 ..< 3 {
      let tipsButton = UIButton()
      if (i == 0) {
        tipsButton.setTitle("15%", for: UIControlState())
      } else if (i == 1) {
        tipsButton.setTitle("18%", for: UIControlState())
      } else {
        tipsButton.setTitle("20%", for: UIControlState())
      }
      tipsButton.setTitleColor(UIColor.white, for: UIControlState())
      tipsButton.backgroundColor = OATabBarBarTintColor
      tipsButton.titleLabel?.font = OABoldTextFont
      tipsButton.layer.cornerRadius = 4.0
      self.addSubview(tipsButton)
      orderTipsButtonArray.append(tipsButton)
    }
  }
  
  //MARK: Layout Views
  override func layoutSubviews() {
    var currentY: CGFloat = OADefaultPadding;
    let constrainedWidth = self.bounds.size.width / 2.0 - 2 * OADefaultPadding
    
    let orderTotalPriceLabelBounds = orderTotalPriceLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 16))
    orderTotalPriceLabel.frame = CGRect(
      x: self.bounds.size.width - 32.0 - orderTotalPriceLabelBounds.width,
      y: currentY,
      width: orderTotalPriceLabelBounds.width,
      height: orderTotalPriceLabelBounds.height).integral
    
    let orderTotalTextLabelBounds = orderTotalTextLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 16))
    orderTotalTextLabel.frame = CGRect(
      x: orderTotalPriceLabel.frame.minX - OADefaultPadding - orderTotalTextLabelBounds.width,
      y: currentY,
      width: orderTotalTextLabelBounds.width,
      height: orderTotalTextLabelBounds.height).integral
    
    currentY = orderTotalPriceLabel.frame.maxY + 4.0
    
    let orderTaxPriceLabelBounds = orderTaxPriceLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 16))
    orderTaxPriceLabel.frame = CGRect(
      x: self.bounds.size.width - 32.0 - orderTaxPriceLabelBounds.width,
      y: currentY,
      width: orderTaxPriceLabelBounds.width,
      height: orderTaxPriceLabelBounds.height).integral
    
    let orderTaxTextLabelBounds = orderTaxTextLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 16))
    orderTaxTextLabel.frame = CGRect(
      x: orderTaxPriceLabel.frame.minX - OADefaultPadding - orderTaxTextLabelBounds.width,
      y: currentY,
      width: orderTaxTextLabelBounds.width,
      height: orderTaxTextLabelBounds.height).integral
    
    currentY = orderTaxTextLabel.frame.maxY + 4.0
    
    var xOffset = self.bounds.size.width - 32.0
    for i in 0 ..< 3 {
      let tipsButton = orderTipsButtonArray[i]
      tipsButton.frame = CGRect(
        x: xOffset - 56.0,
        y: currentY,
        width: 56,
        height: 26).integral
      xOffset -= 56.0 + 8.0
    }
    let orderTipsTextLabelBounds = orderTipsTextLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 26.0))
    orderTipsTextLabel.frame = CGRect(
      x: xOffset - orderTipsTextLabelBounds.width,
      y: currentY,
      width: orderTipsTextLabelBounds.width,
      height: 26.0).integral
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    var height: CGFloat = OADefaultPadding;
    let constrainedWidth = self.bounds.size.width - 2 * OADefaultPadding
    let orderTotalPriceLabelBounds = orderTotalPriceLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 16))
    height += orderTotalPriceLabelBounds.height + 4.0
    let orderTaxPriceLabelBounds = orderTaxPriceLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 16))
    height += orderTaxPriceLabelBounds.height + 4.0
    height += 26.0 + OADefaultPadding
    return CGSize(width: size.width, height: height)
  }
}
