//
//  OAOrderItemViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/28/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

class OAOrderItemViewController: UIViewController, OAOrderItemViewDelegate {
    
    var orderItem: OAOrderItem!
    
    var orderItemView:OAOrderItemView?
    
    //MARK: Life Cycle
    convenience init(orderItem: OAOrderItem) {
        self.init()
        self.orderItem = orderItem
    }
    
    //MARK: View Controller
    
    override func loadView() {
        orderItemView = OAOrderItemView(orderItem: orderItem, delegate: self)
        self.view = self.orderItemView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Order"
        self.view.backgroundColor = UIColor.white
        // remove "back" text from back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                style: .plain,
                                                                target: nil,
                                                                action: nil)
    }
    
    //MARK: OAOrderItemViewDelegate
    
    func addToCartButtonTapped(_ sender: UIButton!, count: Int!) {
        OAOrderStore.sharedInstance.addOrderItem(self.orderItem, count: count)
        self.navigationController!.pushViewController(OAOrderMoreOrCheckoutViewController(),
                                                      animated: true);
    }
    
    func addSignTapped() {
        self.orderItemView?.addItem()
    }
    
    func minusSignTapped() {
        self.orderItemView?.removeItem()
    }
}
