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
    self.init(frame: CGRect.zero)
    
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
    let textLabelBounds = textLabel.sizeThatFits(CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
    let totalWidth = radioButtonWidth + OADefaultPadding + textLabelBounds.width
    let xOffset = self.bounds.size.width / 2.0 - totalWidth / 2.0
    
    radioButtonView.frame = CGRect(
        x: xOffset,
        y: self.bounds.size.height / 2.0 - radioButtonWidth / 2.0,
        width: radioButtonWidth,
        height: radioButtonWidth).integral
    
    textLabel.frame = CGRect(
        x: radioButtonView.frame.maxX + OADefaultPadding,
        y: self.bounds.size.height / 2.0 - textLabelBounds.height / 2.0,
        width: textLabelBounds.width,
        height: textLabelBounds.height).integral
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let textLabelBounds = textLabel.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
    return CGSize(width: radioButtonWidth + OADefaultPadding + textLabelBounds.width,
                      height: max(radioButtonWidth, textLabelBounds.height))
  }
  
}
