//
//  OAShoppingCartItemsTableViewCell.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartItemsTableViewCell: UITableViewCell {
  
  let padding: CGFloat = 5
  var nameLabel: UILabel!
  var priceLabel: UILabel!
  var quantityLabel: UILabel!
  
  var addSignView: UIImageView!
  var minusSignView: UIImageView!
  
  let signWidth: CGFloat = 28.0
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor.white
    
    nameLabel = UILabel(frame: CGRect.zero)
    nameLabel.font = OAPrimaryTextFont
    self.contentView.addSubview(nameLabel)
    
    priceLabel = UILabel(frame: CGRect.zero)
    priceLabel.font = OASecondaryTextFont
    contentView.addSubview(priceLabel)
    
    quantityLabel = UILabel(frame: CGRect.zero)
    quantityLabel.font = OABoldTextFont
    contentView.addSubview(quantityLabel)
    
    // configure sign views
    addSignView = UIImageView(image: UIImage(named:"addSign"))
    addSignView.contentMode = UIViewContentMode.scaleAspectFit
    contentView.addSubview(addSignView)
    
    minusSignView = UIImageView(image: UIImage(named:"minusSign"))
    minusSignView.contentMode = UIViewContentMode.scaleAspectFit
    contentView.addSubview(minusSignView)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let constrainedWidth = self.contentView.bounds.size.width / 2.0 - 2 * kOADefaultPadding
    let nameLabelBounds = nameLabel.sizeThatFits(CGSize(width: constrainedWidth, height: CGFloat.greatestFiniteMagnitude))
    nameLabel.frame = CGRect(
      x: kOADefaultPadding,
      y: 4.0,
      width: nameLabelBounds.width,
      height: nameLabelBounds.height).integral
    
    let priceLabelBounds = priceLabel.sizeThatFits(CGSize(width: constrainedWidth, height: CGFloat.greatestFiniteMagnitude))
    priceLabel.frame = CGRect(
      x: kOADefaultPadding,
      y: nameLabel.frame.maxY + 4.0,
      width: priceLabelBounds.width,
      height: priceLabelBounds.height).integral
    
    addSignView.frame = CGRect(
      x: self.contentView.bounds.size.width - kOADefaultPadding - signWidth,
      y: self.contentView.bounds.size.height / 2.0 - signWidth / 2.0,
      width: signWidth,
      height: signWidth).integral
    
    let quantityLabelBounds = quantityLabel.sizeThatFits(CGSize(width: constrainedWidth, height: CGFloat.greatestFiniteMagnitude))
    quantityLabel.frame = CGRect(
      x: addSignView.frame.minX - 16.0 - quantityLabelBounds.width,
      y: self.bounds.size.height / 2.0 - quantityLabelBounds.height / 2.0,
      width: quantityLabelBounds.width,
      height: quantityLabelBounds.height).integral
    
    minusSignView.frame = CGRect(
      x: quantityLabel.frame.minX - 16.0 - signWidth,
      y: self.bounds.size.height / 2.0 - signWidth / 2.0,
      width: signWidth,
      height: signWidth).integral
  }
}
