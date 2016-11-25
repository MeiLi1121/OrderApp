//
//  OALoginViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 11/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

import FirebaseAuth

class OALoginViewController: UIViewController, OALoginViewDelegate {
    
    //MARK:Properties
    
    var loginView: OALoginView?
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginView = OALoginView(delegate: self)
        self.view = self.loginView
        
        self.view.backgroundColor = UIColor.white
    }
    
    //MARK: hide status bar and navigation bar
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    //MARK: OALoginViewDelegate
    func loginButtonTapped(_ sender: UIButton!, userName: String!, password: String!) {
        if let userName = userName, let password = password {
            FIRAuth.auth()?.signIn(withEmail: userName, password: password) { (user, error) in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                self.navigationController!.setViewControllers([ OAMainTabBarController() ], animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "User Name or Password can't be empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func signUpButtonTapped(_ sender: UIButton!) {
        
    }
    
}

