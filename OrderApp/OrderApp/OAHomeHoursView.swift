//
//  OAHomeHoursView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/21/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAHomeHoursView: UIView {
  
  let dateFormatter: DateFormatter = DateFormatter()
  
  var dineInTitleLabel: UILabel!
  var dineInWeekdayLabelArray: [UILabel] = []
  var dineInHourLabelArray: [UILabel] = []
  
  //MARK: Life Cycle
  convenience init() {
    self.init(frame: CGRect.zero)
    
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
    
    let dineInTitleLabelBounds = dineInTitleLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 16))
    let xOffset = self.bounds.size.width / 2.0 - dineInTitleLabelBounds.width / 2.0
    dineInTitleLabel.frame = CGRect(
        x: xOffset,
        y: currentY,
        width: dineInTitleLabelBounds.width,
        height: dineInTitleLabelBounds.height).integral
    currentY = dineInTitleLabel.frame.maxY + 8.0
    
    for i in 0 ..< dineInWeekdayLabelArray.count {
      let dineInWeekdayLabel = dineInWeekdayLabelArray[i]
      let dineInWeekdayLabelBounds = dineInWeekdayLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 14))
      dineInWeekdayLabel.frame = CGRect(
          x: xOffset - 40.0,
          y: currentY,
          width: dineInWeekdayLabelBounds.width,
          height: dineInWeekdayLabelBounds.height).integral
      
      let dineInHourLabel = dineInHourLabelArray[i]
      let dineInHourLabelBounds = dineInHourLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 14))
      dineInHourLabel.frame = CGRect(
          x: dineInWeekdayLabel.frame.minX + 36.0,
          y: currentY,
          width: dineInHourLabelBounds.width,
          height: dineInHourLabelBounds.height).integral
      currentY = dineInWeekdayLabel.frame.maxY + 4.0
    }
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    var height: CGFloat = 0.0;
    let constrainedWidth = self.bounds.size.width - 2 * OADefaultPadding
    let titleLabelBounds = dineInTitleLabel.sizeThatFits(CGSize(width: constrainedWidth, height: 16))
    height += titleLabelBounds.height + 8.0
    for label in dineInWeekdayLabelArray {
      let labelBounds = label.sizeThatFits(CGSize(width: constrainedWidth, height: 14))
      height += labelBounds.height + 4.0
    }
    return CGSize(width: size.width, height: height)    
  }
  
}
