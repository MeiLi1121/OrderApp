//
//  OAHomeDishGalleryCollectionView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/27/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OADishGalleryCollectionViewCell: UICollectionViewCell {
  var imageView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    imageView = UIImageView(frame: frame)
    contentView.addSubview(imageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    imageView.frame = self.bounds
  }
}
