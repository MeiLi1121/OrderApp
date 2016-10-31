//
//  OAShoppingCartConfirmationView.swift
//  OrderApp
//
//  Created by Shawn Xu on 10/30/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAShoppingCartConfirmationViewDelegate : NSObjectProtocol {
    func rateUsOnYelpButtonTapped(_ sender: UIButton!)
}

class OAShoppingCartConfirmationView: UIView {
    
    var containerScrollView: UIScrollView!
    
    var orderCompletedLabel: UILabel!
    var prepareLabel: UILabel!
    
    var rateUsOnYelpButton: UIButton!
    var checkmarkImageView: UIImageView!
    
    weak var delegate: OAShoppingCartConfirmationViewDelegate!
    
    //MARK: Life Cycle
    convenience init(delegate: OAShoppingCartConfirmationViewDelegate) {
        self.init(frame: CGRect.zero)
        
        self.delegate = delegate
        // configure scroll view
        self.containerScrollView = UIScrollView()
        self.addSubview(containerScrollView)
        
        // configure button view
        rateUsOnYelpButton = UIButton()
        rateUsOnYelpButton.setTitle("Rate Us on Yelp", for: UIControlState())
        rateUsOnYelpButton.setTitleColor(UIColor.white, for: UIControlState())
        rateUsOnYelpButton.backgroundColor = OATabBarBarTintColor
        rateUsOnYelpButton.layer.cornerRadius = 4.0
        rateUsOnYelpButton.addTarget(self, action: #selector(self.rateUsOnYelpButtonTapped), for: .touchUpInside)
        self.containerScrollView.addSubview(rateUsOnYelpButton)
        
        // configure labels
        orderCompletedLabel = UILabel()
        orderCompletedLabel.text = "Order Completed!"
        orderCompletedLabel.font = OALargeBoldTextFont
        self.containerScrollView.addSubview(orderCompletedLabel)
        
        // configure image views
        checkmarkImageView = UIImageView(image: UIImage(named:"finishSign"))
        self.containerScrollView.addSubview(checkmarkImageView)
    }
    
    //MARK: Layout Views
    override func layoutSubviews() {
        checkmarkImageView.frame = CGRect(
            x: self.bounds.width / 2.0 - 36.0 / 2.0,
            y: 120,
            width: 36,
            height: 36).integral
        
        let orderCompletedLabelBounds = orderCompletedLabel.sizeThatFits(self.bounds.size)
        orderCompletedLabel.frame = CGRect(
            x: self.bounds.size.width / 2 - orderCompletedLabelBounds.width / 2.0,
            y: checkmarkImageView.frame.maxY + 14.0,
            width: orderCompletedLabelBounds.width,
            height: orderCompletedLabelBounds.height).integral
        
        rateUsOnYelpButton.frame = CGRect(
            x: self.bounds.width / 2.0 - 180 / 2.0,
            y: orderCompletedLabel.frame.maxY + 40.0,
            width: 180,
            height: 48).integral
        
        self.containerScrollView.frame = self.bounds
    }
    
    //MARK: Button Action
    func rateUsOnYelpButtonTapped(_ sender: UIButton!) {
        delegate.rateUsOnYelpButtonTapped(sender)
    }
    
}
