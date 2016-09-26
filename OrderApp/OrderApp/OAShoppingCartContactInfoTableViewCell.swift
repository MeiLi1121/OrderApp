//
//  OAShoppingCartContactInfoTableViewCell.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/25/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartContactInfoTableViewCell: UITableViewCell {
  
  var fieldNameLabel: UILabel!
  var fieldTextField: UITextField!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor.white
    
    fieldNameLabel = UILabel(frame: CGRect.zero)
    fieldNameLabel.font = OAPrimaryTextFont
    self.contentView.addSubview(fieldNameLabel)
    
    fieldTextField = UITextField(frame: CGRect.zero)
    fieldTextField.font = OAPrimaryTextFont
    fieldTextField.autocorrectionType = UITextAutocorrectionType.no
    fieldTextField.keyboardType = UIKeyboardType.default
    fieldTextField.returnKeyType = UIReturnKeyType.done
    fieldTextField.clearButtonMode = UITextFieldViewMode.whileEditing
    fieldTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
    self.contentView.addSubview(fieldTextField)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let constrainedWidth = self.contentView.bounds.size.width - 2 * OADefaultPadding
    let fieldNameLabelBounds = fieldNameLabel.sizeThatFits(CGSize(width: constrainedWidth, height: CGFloat.greatestFiniteMagnitude))
    fieldNameLabel.frame = CGRect(
      x: OADefaultPadding,
      y: 0,
      width: fieldNameLabelBounds.width,
      height: self.bounds.height).integral
    
    fieldTextField.frame = CGRect(
      x: fieldNameLabel.frame.maxX + OADefaultPadding,
      y: 0,
      width: constrainedWidth - fieldNameLabel.frame.maxX - OADefaultPadding,
      height: self.bounds.height).integral
  }
}
