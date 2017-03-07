//
//  OAViewConstants.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/14/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit

let OANavigationBarTintColor = UIColor(red: 104.0 / 255, green: 4.0 / 255, blue: 82.0 / 255, alpha: 1)
let OANavigationTintColor = UIColor.white
let OANavigationBarTextColor = UIColor.white
let OATabBarBarTintColor = UIColor(red: 104.0 / 255, green: 4.0 / 255, blue: 82.0 / 255, alpha: 1)
let OATabBarTintColor = UIColor.white
let OASeparatorColor = UIColor(red: 151.0 / 255, green: 151.0 / 255, blue: 151.0 / 255, alpha: 1)
let OALoginButtonColor = UIColor(red: 255.0 / 255, green: 149.0 / 255, blue: 0.0 / 255, alpha: 1)
let OASignUpButtonColor = UIColor(red: 26.0 / 255, green: 214.0 / 255, blue: 253.0 / 255, alpha: 1)

let kOADefaultPadding: CGFloat = 12.0
let kOATabBarHeight: CGFloat = 44.0
let kOADefaultTableViewCellHeight: CGFloat = 44.0
let kOATopLayoutOffset: CGFloat = 64.0
let kOANextButtonWidth: CGFloat = 180.0
let kOANextButtonHeight: CGFloat = 48.0

let kContactFieldArray: [String] = ["Name", "Street", "City", "State", "Phone", "Email"]
let kProfileFieldArray: [String] = ["My Account", "Payment Information", "Order History"]
let kContactInfofilePath = "contactInfo.json"
let kCardInfoFieldArray: [String] = ["Name on Card", "Card No.", "Exp Date", "CVV"]
let kBillingAddressFieldArray: [String] = ["Street", "City", "State", "Zip Code"]
enum PaymentInfoSection: Int {
    case cardInfoSection = 0
    case billingAddressSection
    case numerOfSections
}
let kPaymentInfofilePath = "paymentInfo.json"

let OABoldTextFont: UIFont =  UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold)
let OALargeBoldTextFont: UIFont =  UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightBold)
let OAPrimaryTextFont: UIFont =  UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)
let OASecondaryTextFont: UIFont =  UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightRegular)

let OADishGalleryCollectionViewCellIdentifier = "DishGalleryCollectionViewCell"
