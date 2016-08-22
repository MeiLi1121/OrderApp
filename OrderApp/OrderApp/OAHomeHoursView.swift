//
//  OAHomeHoursView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/21/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

enum OAHomeHoursViewStyle: Int {
  case OAHomeHoursViewStyleDineIn = 0, OAHomeHoursViewStyleDelivery
}

class OAHomeHoursView: UIView {
  
  let dateFormatter: NSDateFormatter = NSDateFormatter()
  
  var dineInTitleLabel: UILabel!
  var deliveryTitleLabel: UILabel!
  var dineInWeekdayLabelArray: [UILabel] = []
  var dineInHourLabelArray: [UILabel] = []
  var deliveryWeekdayLabelArray: [UILabel] = []
  var deliveryHourLabelArray: [UILabel] = []
  
  //MARK: Life Cycle
  convenience init() {
    self.init(frame: CGRectZero)
    
    // configure dine in title label
    dineInTitleLabel = UILabel()
    dineInTitleLabel.text = titleTextForStyle(OAHomeHoursViewStyle.OAHomeHoursViewStyleDineIn)
    dineInTitleLabel.font = OABoldTextFont
    self.addSubview(dineInTitleLabel)
    
    // configure delivery title label
    deliveryTitleLabel = UILabel()
    deliveryTitleLabel.text = titleTextForStyle(OAHomeHoursViewStyle.OAHomeHoursViewStyleDelivery)
    deliveryTitleLabel.font = OABoldTextFont
    self.addSubview(deliveryTitleLabel)
    
    // configure time label
    let dineInHourTextArray = timeTextsForStyle(OAHomeHoursViewStyle.OAHomeHoursViewStyleDineIn)
    let deliveryTextArray = timeTextsForStyle(OAHomeHoursViewStyle.OAHomeHoursViewStyleDelivery)
    for i in 0 ..< dateFormatter.shortWeekdaySymbols.count {
      let dineInWeekDayLabel = UILabel()
      dineInWeekDayLabel.text = dateFormatter.shortWeekdaySymbols[i] + ":"
      dineInWeekDayLabel.font = OAPrimaryTextFont
      self.addSubview(dineInWeekDayLabel)
      dineInWeekdayLabelArray.append(dineInWeekDayLabel)
      
      let deliveryWeekDayLabel = UILabel()
      deliveryWeekDayLabel.text = dateFormatter.shortWeekdaySymbols[i] + ":"
      deliveryWeekDayLabel.font = OAPrimaryTextFont
      self.addSubview(deliveryWeekDayLabel)
      deliveryWeekdayLabelArray.append(deliveryWeekDayLabel)
      
      let dineInHourLabel = UILabel()
      dineInHourLabel.text = dineInHourTextArray[i]
      dineInHourLabel.font = OASecondaryTextFont
      self.addSubview(dineInHourLabel)
      dineInHourLabelArray.append(dineInHourLabel)
      
      let deliveryHourLabel = UILabel()
      deliveryHourLabel.text = deliveryTextArray[i]
      deliveryHourLabel.font = OASecondaryTextFont
      self.addSubview(deliveryHourLabel)
      deliveryHourLabelArray.append(deliveryHourLabel)
    }
  }
  
  //MARK: Layout Views
  override func layoutSubviews() {
    var currentY: CGFloat = 0.0;
    let constrainedWidth = self.bounds.size.width / 2.0 - 2 * OADefaultPadding
    
    let dineInTitleLabelBounds = dineInTitleLabel.sizeThatFits(CGSizeMake(constrainedWidth, 16))
    dineInTitleLabel.frame = CGRectIntegral(
      CGRectMake(
        OADefaultPadding,
        currentY,
        dineInTitleLabelBounds.width,
        dineInTitleLabelBounds.height))
    let deliveryTitleLabelBounds = deliveryTitleLabel.sizeThatFits(CGSizeMake(constrainedWidth, 16))
    deliveryTitleLabel.frame = CGRectIntegral(
      CGRectMake(
        self.bounds.size.width / 2.0 + OADefaultPadding,
        currentY,
        deliveryTitleLabelBounds.width,
        deliveryTitleLabelBounds.height))
    currentY = CGRectGetMaxY(dineInTitleLabel.frame) + 8.0
    
    for i in 0 ..< dineInWeekdayLabelArray.count {
      let dineInWeekdayLabel = dineInWeekdayLabelArray[i]
      let dineInWeekdayLabelBounds = dineInWeekdayLabel.sizeThatFits(CGSizeMake(constrainedWidth, 14))
      dineInWeekdayLabel.frame = CGRectIntegral(
        CGRectMake(
          OADefaultPadding,
          currentY,
          dineInWeekdayLabelBounds.width,
          dineInWeekdayLabelBounds.height))
      
      let deliveryWeekdayLabel = deliveryWeekdayLabelArray[i]
      let deliveryWeekdayLabelBounds = deliveryWeekdayLabel.sizeThatFits(CGSizeMake(constrainedWidth, 14))
      deliveryWeekdayLabel.frame = CGRectIntegral(
        CGRectMake(
          self.bounds.size.width / 2.0 + OADefaultPadding,
          currentY,
          deliveryWeekdayLabelBounds.width,
          deliveryWeekdayLabelBounds.height))
      
      let dineInHourLabel = dineInHourLabelArray[i]
      let dineInHourLabelBounds = dineInHourLabel.sizeThatFits(CGSizeMake(constrainedWidth, 14))
      dineInHourLabel.frame = CGRectIntegral(
        CGRectMake(
          CGRectGetMinX(dineInWeekdayLabel.frame) + 36.0,
          currentY,
          dineInHourLabelBounds.width,
          dineInHourLabelBounds.height))
      
      let deliveryHourLabel = deliveryHourLabelArray[i]
      let deliveryHourLabelBounds = deliveryHourLabel.sizeThatFits(CGSizeMake(constrainedWidth, 14))
      deliveryHourLabel.frame = CGRectIntegral(
        CGRectMake(
          CGRectGetMinX(deliveryWeekdayLabel.frame) + 36.0,
          currentY,
          deliveryHourLabelBounds.width,
          deliveryHourLabelBounds.height))
      currentY = CGRectGetMaxY(dineInWeekdayLabel.frame) + 4.0
    }
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    var height: CGFloat = 0.0;
    let constrainedWidth = self.bounds.size.width - 2 * OADefaultPadding
    let titleLabelBounds = dineInTitleLabel.sizeThatFits(CGSizeMake(constrainedWidth, 16))
    height += titleLabelBounds.height + 8.0
    for label in dineInWeekdayLabelArray {
      let labelBounds = label.sizeThatFits(CGSizeMake(constrainedWidth, 14))
      height += labelBounds.height + 4.0
    }
    return CGSizeMake(size.width, height)    
  }
  
}
