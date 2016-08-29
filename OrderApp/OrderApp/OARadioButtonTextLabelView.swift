//
//  OARadioButtonTextLabelView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/28/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OARadioButtonTextLabelView: UIView {
  
  var radioButtonView: UIImageView!
  var textLabel: UILabel!
  
  let radioButtonWidth: CGFloat = 24.0
  
  //MARK: Life Cycle
  convenience init(text: String, isChecked: Bool) {
    self.init(frame: CGRectZero)
    
    // configure radio button
    let image = isChecked ? UIImage(named:"radiochecked") : UIImage(named:"radiounchecked")
    radioButtonView = UIImageView(image: image)
    self.addSubview(radioButtonView)
    
    // configure text label
    textLabel = UILabel()
    textLabel.text = text
    textLabel.font = OABoldTextFont
    self.addSubview(textLabel)
  }
  
  //MARK: Layout Views
  override func layoutSubviews() {
    let textLabelBounds = textLabel.sizeThatFits(CGSizeMake(self.bounds.width, CGFloat.max))
    let totalWidth = radioButtonWidth + OADefaultPadding + textLabelBounds.width
    let xOffset = self.bounds.size.width / 2.0 - totalWidth / 2.0
    
    radioButtonView.frame = CGRectIntegral(
      CGRectMake(
        xOffset,
        self.bounds.size.height / 2.0 - radioButtonWidth / 2.0,
        radioButtonWidth,
        radioButtonWidth))
    
    textLabel.frame = CGRectIntegral(
      CGRectMake(
        CGRectGetMaxX(radioButtonView.frame) + OADefaultPadding,
        self.bounds.size.height / 2.0 - textLabelBounds.height / 2.0,
        textLabelBounds.width,
        textLabelBounds.height))
  }
  
  override func sizeThatFits(size: CGSize) -> CGSize {
    let textLabelBounds = textLabel.sizeThatFits(CGSizeMake(size.width, CGFloat.max))
    return CGSizeMake(radioButtonWidth + OADefaultPadding + textLabelBounds.width,
                      max(radioButtonWidth, textLabelBounds.height))
  }
  
}
