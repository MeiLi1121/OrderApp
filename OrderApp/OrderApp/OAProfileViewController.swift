//
//  OAProfileViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 2/4/17.
//  Copyright © 2017 Shawn Xu. All rights reserved.
//

import UIKit

class OAProfileViewController: UIViewController, OAProfileMainViewDelegate {
    
    //MARK: Private Constants
    private let kCellIdentifier = "ProfileTableViewCell"
    
    //MARK:Properties
    
    private var profileView: OAProfileMainView?
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileView = OAProfileMainView(delegate: self)
        self.view = self.profileView
        
        self.title = "Profile"
        self.view.backgroundColor = UIColor.gray
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return kProfileFieldArray.count;
        } else {
            return 1;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        // Dequeue cell
        var cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: kCellIdentifier)
        }
        if (indexPath.section == 0) {
            cell?.textLabel?.text = kProfileFieldArray[indexPath.row]
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        } else {
            cell?.textLabel?.text = "Log Out";
        }
        return cell!
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            switch indexPath.row {
            case 0:
                self.navigationController!.pushViewController(OAProfileDetailInfoViewController(),
                                                              animated: true);
            default: break
            }
        }
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 1) {
            return kOADefaultTableViewCellHeight;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kOADefaultTableViewCellHeight;
    }
}
