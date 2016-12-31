//
//  OAOrderStepperView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/28/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAOrderStepperView: UIView {
  
  var addSignView: UIImageView!
  var minusSignView: UIImageView!
  
  var textLabel: UILabel!
  
  let signWidth: CGFloat = 36.0
  let textLabelWidth: CGFloat = 84.0
  let textLabelHeight: CGFloat = 40.0
  
  //MARK: Life Cycle
  convenience init(text: String) {
    self.init(frame: CGRect.zero)
    
    // configure sign views
    addSignView = UIImageView(image: UIImage(named:"addSign"))
    self.addSubview(addSignView)
    
    minusSignView = UIImageView(image: UIImage(named:"minusSign"))
    self.addSubview(minusSignView)
    
    // configure text label
    textLabel = UILabel()
    textLabel.text = text
    textLabel.font = OABoldTextFont
    textLabel.layer.borderColor = UIColor.gray.cgColor
    textLabel.layer.borderWidth = 1.0
    textLabel.textAlignment = .center
    textLabel.layer.cornerRadius = 4.0
    self.addSubview(textLabel)
  }
  
  //MARK: Layout Views
  override func layoutSubviews() {
    let totalWidth = signWidth * 2 + kOADefaultPadding * 2 + textLabelWidth
    let xOffset = self.bounds.size.width / 2.0 - totalWidth / 2.0
    
    minusSignView.frame = CGRect(
        x: xOffset,
        y: self.bounds.size.height / 2.0 - signWidth / 2.0,
        width: signWidth,
        height: signWidth).integral
    
    textLabel.frame = CGRect(
        x: minusSignView.frame.maxX + kOADefaultPadding,
        y: self.bounds.size.height / 2.0 - textLabelHeight / 2.0,
        width: textLabelWidth,
        height: textLabelHeight).integral
    
    addSignView.frame = CGRect(
        x: textLabel.frame.maxX + kOADefaultPadding,
        y: self.bounds.size.height / 2.0 - signWidth / 2.0,
        width: signWidth,
        height: signWidth).integral
  }
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return CGSize(width: signWidth * 2 + kOADefaultPadding * 2 + textLabelWidth,
                      height: max(signWidth, textLabelHeight))
  }
  
}

