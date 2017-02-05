//
//  OAProfileDetailedInfoView.swift
//  OrderApp
//
//  Created by Shawn Xu on 2/4/17.
//  Copyright © 2017 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAProfileDetailInfoViewDelegate : UITableViewDataSource, UITableViewDelegate {}

class OAProfileDetailInfoView: UIView {
    
    //MARK: Private Properties
    
    var contactInfoTableView: UITableView!
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
    }
    
    //MARK: Layout
    
    override func layoutSubviews() {
        contactInfoTableView.frame = CGRect(
            x: 0,
            y: kOATopLayoutOffset,
            width: self.bounds.width,
            height: self.bounds.height)
    }
}
