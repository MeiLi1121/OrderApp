//
//  OAShoppingCardComfirmationViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 10/30/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAShoppingCartConfirmationViewController: UIViewController, OAShoppingCartConfirmationViewDelegate {
    
    //MARK:Properties
    
    var confirmationView: OAShoppingCartConfirmationView?
    let cellIdentifier = "ContactInfoTableViewCell"
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.confirmationView = OAShoppingCartConfirmationView(delegate: self)
        self.view = self.confirmationView
        
        self.title = "Done"
        self.view.backgroundColor = UIColor.white
        
        // hide back button
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
    }
    
    //MARK: OAShoppingCartConfirmationViewDelegate
    
    func rateUsOnYelpButtonTapped(_ sender: UIButton!) {
        
    }}
