//
//  OAShoppingCartContactInfoTableViewCell.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/25/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartContactInfoTableViewCell: UITableViewCell {
  
  //MARK: Constants
  private let kMaxLabelWidth: CGFloat = 80
  
  //MARK: Properties
  var fieldNameLabel: UILabel!
  var fieldTextField: UITextField!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor.white
    
    fieldNameLabel = UILabel(frame: CGRect.zero)
    fieldNameLabel.font = OABoldTextFont
    self.contentView.addSubview(fieldNameLabel)
    
    fieldTextField = UITextField(frame: CGRect.zero)
    fieldTextField.font = OAPrimaryTextFont
    fieldTextField.autocorrectionType = UITextAutocorrectionType.no
    fieldTextField.autocapitalizationType = UITextAutocapitalizationType.none
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
    let constrainedWidth = self.contentView.bounds.size.width - 2 * kOADefaultPadding
    let fieldNameLabelBounds = fieldNameLabel.sizeThatFits(CGSize(width: min(constrainedWidth, kMaxLabelWidth),
                                                                  height: CGFloat.greatestFiniteMagnitude))
    fieldNameLabel.frame = CGRect(
      x: kContactTableViewInset,
      y: 0,
      width: fieldNameLabelBounds.width,
      height: self.bounds.height).integral
    
    fieldTextField.frame = CGRect(
      x: max(fieldNameLabel.frame.maxX, kMaxLabelWidth),
      y: 0,
      width: constrainedWidth - fieldNameLabel.frame.maxX - kOADefaultPadding,
      height: self.bounds.height).integral
  }
}
