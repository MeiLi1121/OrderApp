//
//  OAProfileDetailedInfoView.swift
//  OrderApp
//
//  Created by Shawn Xu on 2/4/17.
//  Copyright © 2017 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAProfileDetailInfoViewDelegate : UITableViewDataSource, UITableViewDelegate {
    func saveButtonTapped(_ sender: UIButton!)
}

class OAProfileDetailInfoView: UIView {
    
    //MARK: Private Properties
    
    var contactInfoTableView: UITableView!
    private var saveButton: UIButton!
    
    weak private var delegate: OAProfileDetailInfoViewDelegate!
    
    //MARK: Life Cycle
    
    convenience init(delegate: OAProfileDetailInfoViewDelegate) {
        self.init(frame: CGRect.zero)
        
        self.delegate = delegate
        
        // configure contact info table view
        contactInfoTableView = UITableView();
        contactInfoTableView.dataSource = delegate
        contactInfoTableView.delegate = delegate
        // remove extra table view cells
        contactInfoTableView.tableFooterView = UIView(frame: CGRect.zero)
        contactInfoTableView.separatorInset = UIEdgeInsets.zero
        contactInfoTableView.separatorColor = OASeparatorColor
        contactInfoTableView.alwaysBounceVertical = false
        self.addSubview(contactInfoTableView)
        
        // configure button view
        saveButton = UIButton()
        saveButton.setTitle("Save", for: UIControlState())
        saveButton.setTitleColor(UIColor.white, for: UIControlState())
        saveButton.backgroundColor = OATabBarBarTintColor
        saveButton.layer.cornerRadius = 4.0
        saveButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        self.addSubview(saveButton)
    }
    
    //MARK: Layout
    
    override func layoutSubviews() {
        saveButton.frame = CGRect(
            x: self.bounds.width / 2.0 - kOANextButtonWidth / 2.0,
            y: self.bounds.height - kOANextButtonHeight - kOATabBarHeight - 20.0,
            width: kOANextButtonWidth,
            height: kOANextButtonHeight).integral
        
        contactInfoTableView.frame = CGRect(
            x: 0,
            y: kOATopLayoutOffset,
            width: self.bounds.width,
            height: saveButton.frame.minY - kOATopLayoutOffset - 2 * kOADefaultPadding).integral;
    }
    
    //MARK: Button Action
    func buttonTapped(_ sender: UIButton!) {
        delegate.saveButtonTapped(sender)
    }
}
