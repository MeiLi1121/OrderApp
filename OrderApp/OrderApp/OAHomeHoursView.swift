//
//  OAHomeHoursView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/21/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAHomeHoursView: UIView {
  
  let dateFormatter: NSDateFormatter = NSDateFormatter()
  
  var dineInTitleLabel: UILabel!
  var dineInWeekdayLabelArray: [UILabel] = []
  var dineInHourLabelArray: [UILabel] = []
  
  //MARK: Life Cycle
  convenience init() {
    self.init(frame: CGRectZero)
    
    // configure dine in title label
    dineInTitleLabel = UILabel()
    dineInTitleLabel.text = titleTextForDineInHours()
    dineInTitleLabel.font = OABoldTextFont
    self.addSubview(dineInTitleLabel)
    
    // configure time label
    let dineInHourTextArray = timeTextsForDineInHours()
    for i in 0 ..< dateFormatter.shortWeekdaySymbols.count {
      let dineInWeekDayLabel = UILabel()
      dineInWeekDayLabel.text = dateFormatter.shortWeekdaySymbols[i] + ":"
      dineInWeekDayLabel.font = OAPrimaryTextFont
      self.addSubview(dineInWeekDayLabel)
      dineInWeekdayLabelArray.append(dineInWeekDayLabel)
      
      let dineInHourLabel = UILabel()
      dineInHourLabel.text = dineInHourTextArray[i]
      dineInHourLabel.font = OASecondaryTextFont
      self.addSubview(dineInHourLabel)
      dineInHourLabelArray.append(dineInHourLabel)
    }
  }
  
  //MARK: Layout Views
  override func layoutSubviews() {
    var currentY: CGFloat = 0.0;
    let constrainedWidth = self.bounds.size.width / 2.0 - 2 * OADefaultPadding
    
    let dineInTitleLabelBounds = dineInTitleLabel.sizeThatFits(CGSizeMake(constrainedWidth, 16))
    let xOffset = self.bounds.size.width / 2.0 - dineInTitleLabelBounds.width / 2.0
    dineInTitleLabel.frame = CGRectIntegral(
      CGRectMake(
        xOffset,
        currentY,
        dineInTitleLabelBounds.width,
        dineInTitleLabelBounds.height))
    currentY = CGRectGetMaxY(dineInTitleLabel.frame) + 8.0
    
    for i in 0 ..< dineInWeekdayLabelArray.count {
      let dineInWeekdayLabel = dineInWeekdayLabelArray[i]
      let dineInWeekdayLabelBounds = dineInWeekdayLabel.sizeThatFits(CGSizeMake(constrainedWidth, 14))
      dineInWeekdayLabel.frame = CGRectIntegral(
        CGRectMake(
          xOffset - 40.0,
          currentY,
          dineInWeekdayLabelBounds.width,
          dineInWeekdayLabelBounds.height))
      
      let dineInHourLabel = dineInHourLabelArray[i]
      let dineInHourLabelBounds = dineInHourLabel.sizeThatFits(CGSizeMake(constrainedWidth, 14))
      dineInHourLabel.frame = CGRectIntegral(
        CGRectMake(
          CGRectGetMinX(dineInWeekdayLabel.frame) + 36.0,
          currentY,
          dineInHourLabelBounds.width,
          dineInHourLabelBounds.height))
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
