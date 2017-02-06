//
//  OAProfileViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

let kProfileDetailedInfoTableViewInset: CGFloat = 20.0

class OAProfileDetailInfoViewController: UIViewController, OAProfileDetailInfoViewDelegate, UITextFieldDelegate {
    
    //MARK: Private Constants
    private let kCellIdentifier = "ProfileDetailInfoTableViewCell"
    
    //MARK:Properties
    
    private var detailInfoView: OAProfileDetailInfoView?
    private var detailInfo: [String:String]? = [:]
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailInfoView = OAProfileDetailInfoView(delegate: self)
        self.view = self.detailInfoView
        
        self.title = "Edit Profile"
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        // remove "back" text from back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
        self.syncContactInfoFromDisk()
    }
    
    //MARK: OAProfileDetailInfoViewDelegate
    
    func saveButtonTapped(_ sender: UIButton!) {
        for row in 0..<kContactFieldArray.count {
            let cell = self.detailInfoView?.contactInfoTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! OAShoppingCartContactInfoTableViewCell
            detailInfo?[cell.fieldNameLabel.text!] = cell.fieldTextField.text
        }
        self.syncContactInfoToDisk(detailInfo)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kContactFieldArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        // Dequeue cell
        var cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as? OAShoppingCartContactInfoTableViewCell
        if (cell == nil) {
            cell = OAShoppingCartContactInfoTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: kCellIdentifier)
        }
        cell!.fieldNameLabel.text = kContactFieldArray[indexPath.row]
        cell!.fieldTextField.text = detailInfo?[kContactFieldArray[indexPath.row]]
        cell!.fieldTextField.delegate = self
        if (indexPath.row == 0) {
            cell!.fieldTextField.becomeFirstResponder()
        }
        return cell!
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kOADefaultTableViewCellHeight;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let textLabel = UILabel()
        textLabel.text = "Your Profile"
        textLabel.font = OABoldTextFont
        textLabel.sizeToFit()
        textLabel.frame = CGRect(x: kContactTableViewInset,
                                 y: 0,
                                 width: textLabel.frame.size.width,
                                 height: kOADefaultTableViewCellHeight)
        headerView.addSubview(textLabel)
        let separator = UIView();
        separator.frame = CGRect(
            x: 0.0,
            y: kOADefaultTableViewCellHeight,
            width: tableView.frame.size.width,
            height: 1.0 / UIScreen.main.scale)
        separator.backgroundColor = OASeparatorColor
        headerView.addSubview(separator)
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: tableView.frame.size.width,
                                  height: kOADefaultTableViewCellHeight)
        headerView.backgroundColor = UIColor.white
        return headerView;
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //MARK: Private Helpers
    
    func syncContactInfoFromDisk() {
        let temp = OAJSONHelper.syncFrom(kContactInfofilePath) as? [String:String]
        if (temp != nil) {
            detailInfo = temp
        }
    }
    
    func syncContactInfoToDisk(_ contactInfo:[String:String]?) {
        OAJSONHelper.syncTo(kContactInfofilePath, withJSON: contactInfo)
    }
}
