//
//  OAProfilePaymentInfoViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 2/4/17.
//  Copyright © 2017 Shawn Xu. All rights reserved.
//

import UIKit

class OAProfilePaymentInfoViewController: UIViewController, OAProfilePaymentInfoViewDelegate, UITextFieldDelegate {
    
    //MARK: Private Constants
    private let kCellIdentifier = "PaymentInfoTableViewCell"
    
    //MARK:Properties
    
    private var payInfoView: OAProfilePaymentInfoView?
    private var paymentInfo: [String:String]? = [:]
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.payInfoView = OAProfilePaymentInfoView(delegate: self)
        self.view = self.payInfoView
        
        self.title = "Payment Information"
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.syncPaymentInfoFromDisk()
    }
    
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return PaymentInfoSection.numerOfSections.rawValue;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == PaymentInfoSection.cardInfoSection.rawValue) {
            return kCardInfoFieldArray.count
        } else if (section == PaymentInfoSection.billingAddressSection.rawValue) {
            return kBillingAddressFieldArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        // Dequeue cell
        var cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as? OAShoppingCartContactInfoTableViewCell
        if (cell == nil) {
            cell = OAShoppingCartContactInfoTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: kCellIdentifier)
        }
        
        if (indexPath.section == PaymentInfoSection.cardInfoSection.rawValue) {
            cell!.fieldNameLabel.text = kCardInfoFieldArray[indexPath.row]
            cell!.fieldTextField.text = paymentInfo?[kCardInfoFieldArray[indexPath.row]]
            if (indexPath.row == 0) {
                cell!.fieldTextField.becomeFirstResponder()
            }
        } else if (indexPath.section == PaymentInfoSection.billingAddressSection.rawValue) {
            cell!.fieldNameLabel.text = kBillingAddressFieldArray[indexPath.row]
            cell!.fieldTextField.text = paymentInfo?[kBillingAddressFieldArray[indexPath.row]]
        }
        cell!.fieldTextField.delegate = self
        return cell!
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kOADefaultTableViewCellHeight;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kOADefaultTableViewCellHeight;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let textLabel = UILabel()
        if (section == PaymentInfoSection.cardInfoSection.rawValue) {
            textLabel.text = "Enter Credit Card Info"
        } else if (section == PaymentInfoSection.billingAddressSection.rawValue) {
            textLabel.text = "Enter Billing Address"
        }
        textLabel.font = OABoldTextFont
        textLabel.textColor = OATabBarBarTintColor
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let separator = UIView();
        separator.frame = CGRect(
            x: 0.0,
            y: kOADefaultTableViewCellHeight,
            width: tableView.frame.size.width,
            height: 1.0 / UIScreen.main.scale)
        separator.backgroundColor = OASeparatorColor
        return separator
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0 / UIScreen.main.scale;
    }
    
    //MARK: OAShoppingCartViewDelegate
    
    func saveButtonTapped(_ sender: UIButton!) {
        for row in 0..<kCardInfoFieldArray.count {
            let cell = self.payInfoView?.paymentInfoTableView.cellForRow(at: IndexPath(row: row, section: PaymentInfoSection.cardInfoSection.rawValue)) as! OAShoppingCartContactInfoTableViewCell
            paymentInfo?[cell.fieldNameLabel.text!] = cell.fieldTextField.text
        }
        for row in 0..<kBillingAddressFieldArray.count {
            let cell = self.payInfoView?.paymentInfoTableView.cellForRow(at: IndexPath(row: row, section: PaymentInfoSection.billingAddressSection.rawValue)) as! OAShoppingCartContactInfoTableViewCell
            paymentInfo?[cell.fieldNameLabel.text!] = cell.fieldTextField.text
        }
        self.syncContactInfoToDisk(paymentInfo)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //MARK: Private Helpers
    
    func syncPaymentInfoFromDisk() {
        let temp = OAJSONHelper.syncFrom(kPaymentInfofilePath) as? [String:String]
        if (temp != nil) {
            paymentInfo = temp
        }
    }
    
    func syncContactInfoToDisk(_ paymentInfo:[String:String]?) {
        OAJSONHelper.syncTo(kPaymentInfofilePath, withJSON: paymentInfo)
    }
}
