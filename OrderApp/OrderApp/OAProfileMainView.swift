//
//  OAProfileMainView.swift
//  OrderApp
//
//  Created by Shawn Xu on 2/4/17.
//  Copyright © 2017 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OAProfileMainViewDelegate : UITableViewDataSource, UITableViewDelegate {}

class OAProfileMainView: UIView {
    
    //MARK: Private Properties
    
    var profileTableView: UITableView!
    weak private var delegate: OAProfileMainViewDelegate!
    
    //MARK: Life Cycle
    
    convenience init(delegate: OAProfileMainViewDelegate) {
        self.init(frame: CGRect.zero)
        
        self.delegate = delegate
        
        // configure contact info table view
        profileTableView = UITableView();
        profileTableView.dataSource = delegate
        profileTableView.delegate = delegate
        // remove extra table view cells
        profileTableView.tableFooterView = UIView(frame: CGRect.zero)
        profileTableView.separatorInset = UIEdgeInsets.zero
        profileTableView.separatorColor = OASeparatorColor
        profileTableView.alwaysBounceVertical = false
        profileTableView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        self.addSubview(profileTableView)
    }
    
    //MARK: Layout
    
    override func layoutSubviews() {
        profileTableView.frame = CGRect(
            x: 0,
            y: kOATopLayoutOffset,
            width: self.bounds.width,
            height: self.bounds.height)
    }
}

