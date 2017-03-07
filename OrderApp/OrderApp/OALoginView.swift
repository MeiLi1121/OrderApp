//
//  OALoginView.swift
//  OrderApp
//
//  Created by Shawn Xu on 11/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

//
//  OAShoppingCartConfirmationView.swift
//  OrderApp
//
//  Created by Shawn Xu on 10/30/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

public protocol OALoginViewDelegate : NSObjectProtocol {
    func loginButtonTapped(_ sender: UIButton!, userName: String!, password: String!)
    func signUpButtonTapped(_ sender: UIButton!)
}

class OALoginView: UIView {
    
    var containerScrollView: UIScrollView!
    
    var logoImageView: UIImageView!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    
    let logoWidth: CGFloat = 76.0
    let textFieldWidth: CGFloat = 235.0
    let textFieldHeight: CGFloat = 36.0
    
    var loginButton: UIButton!
    var signUpButton: UIButton!
    
    weak var delegate: OALoginViewDelegate!
    
    //MARK: Life Cycle
    convenience init(delegate: OALoginViewDelegate) {
        self.init(frame: CGRect.zero)
        
        self.delegate = delegate
        // configure scroll view
        self.containerScrollView = UIScrollView()
        self.addSubview(containerScrollView)
        
        // configure logo image view
        logoImageView = UIImageView(image: UIImage(named:"logo"))
        self.containerScrollView.addSubview(logoImageView)
        
        // configure user name text fields
        usernameTextField = UITextField()
        usernameTextField.backgroundColor = UIColor.white
        usernameTextField.placeholder = "User Name"
        usernameTextField.borderStyle = UITextBorderStyle.roundedRect
        usernameTextField.font = OAPrimaryTextFont
        usernameTextField.autocapitalizationType = UITextAutocapitalizationType.none;
        usernameTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        usernameTextField.autocorrectionType = UITextAutocorrectionType.no;
        self.containerScrollView.addSubview(usernameTextField)
        
        // configure pass word labels
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.borderStyle = UITextBorderStyle.roundedRect
        passwordTextField.font = OAPrimaryTextFont
        passwordTextField.isSecureTextEntry = true;
        passwordTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no;
        self.containerScrollView.addSubview(passwordTextField)
        
        // configure login button
        loginButton = UIButton()
        loginButton.setTitle("Login", for: UIControlState())
        loginButton.setTitleColor(UIColor.white, for: UIControlState())
        loginButton.backgroundColor = OALoginButtonColor
        loginButton.layer.cornerRadius = 4.0
        loginButton.addTarget(self, action: #selector(self.loginButtonTapped), for: .touchUpInside)
        self.containerScrollView.addSubview(loginButton)
        
        // configure sign up button
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: UIControlState())
        signUpButton.setTitleColor(UIColor.white, for: UIControlState())
        signUpButton.backgroundColor = OASignUpButtonColor
        signUpButton.layer.cornerRadius = 4.0
        signUpButton.addTarget(self, action: #selector(self.signUpButtonTapped), for: .touchUpInside)
        self.containerScrollView.addSubview(signUpButton)
        
        self.containerScrollView.backgroundColor = OANavigationBarTintColor
    }
    
    //MARK: Layout Views
    override func layoutSubviews() {
        logoImageView.frame = CGRect(
            x: (self.bounds.size.width - logoWidth) / 2.0,
            y: 80.0,
            width: logoWidth,
            height: logoWidth)
        usernameTextField.frame = CGRect(
            x: (self.bounds.size.width - textFieldWidth) / 2.0,
            y: 200.0,
            width: textFieldWidth,
            height: textFieldHeight)
        passwordTextField.frame = CGRect(
            x: (self.bounds.size.width - textFieldWidth) / 2.0,
            y: usernameTextField.frame.maxY + 20.0,
            width: textFieldWidth,
            height: textFieldHeight)
        loginButton.frame = CGRect(
            x: (self.bounds.size.width - textFieldWidth) / 2.0,
            y: passwordTextField.frame.maxY + 20.0,
            width: textFieldWidth,
            height: textFieldHeight)
        signUpButton.frame = CGRect(
            x: (self.bounds.size.width - textFieldWidth) / 2.0,
            y: loginButton.frame.maxY + 20.0,
            width: textFieldWidth,
            height: textFieldHeight)
        self.containerScrollView.frame = self.bounds
    }
    
    //MARK: Button Action
    func loginButtonTapped(_ sender: UIButton!) {
        self.delegate.loginButtonTapped(sender, userName: self.usernameTextField.text, password: self.passwordTextField.text)
    }
    
    func signUpButtonTapped(_ sender: UIButton!) {
        self.delegate.signUpButtonTapped(sender)
    }
}

