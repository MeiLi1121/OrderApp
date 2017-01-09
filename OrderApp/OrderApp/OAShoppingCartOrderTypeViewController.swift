//
//  OAShoppingCartOrderTypeViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/25/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit
import MapKit

let kContactTableViewInset: CGFloat = 20.0
let kContactFieldArray: [String] = ["Name", "Street", "City", "State", "Phone", "Email"]

class OAShoppingCartOrderTypeViewController: UIViewController, OAShoppingCartOrderTypeViewDelegate, UITextFieldDelegate {
  
  //MARK: Private Constants
  private let kCellIdentifier = "ContactInfoTableViewCell"
  private let kContactInfofilePath = "contactInfo.json"
  
  //MARK:Properties
  
  private var orderTypeView: OAShoppingCartOrderTypeView?
  private var contactInfo: [String:String]? = [:]
  
  //MARK: Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.orderTypeView = OAShoppingCartOrderTypeView(delegate: self)
    self.view = self.orderTypeView
    
    self.title = "Select Order Type"
    self.view.backgroundColor = UIColor.white
    self.automaticallyAdjustsScrollViewInsets = false
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    self.syncContactInfoFromDisk()
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
    cell!.fieldTextField.text = contactInfo?[kContactFieldArray[indexPath.row]]
    cell!.fieldTextField.delegate = self
    if (indexPath.row == 0) {
      cell!.fieldTextField.becomeFirstResponder()
    }
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
    textLabel.text = "Deliver To"
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
  
  //MARK: OAShoppingCartViewDelegate
  
  func nextButtonTapped(_ sender: UIButton!) {
    for row in 0..<kContactFieldArray.count {
      let cell = self.orderTypeView?.contactInfoTableView.cellForRow(at: IndexPath(row: row, section: 0)) as! OAShoppingCartContactInfoTableViewCell
      contactInfo?[cell.fieldNameLabel.text!] = cell.fieldTextField.text
    }
    self.syncContactInfoToDisk(contactInfo)
    self.navigationController!.pushViewController(OAShoppingCartPaymentInfoViewController(),
                                                  animated: true);
  }
  
  //MARK: MKMapViewDelegate
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if let annotation = annotation as? OAMapAnnotation {
      let identifier = "pin"
      var view: MKPinAnnotationView
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        as? MKPinAnnotationView { // 2
        dequeuedView.annotation = annotation
        view = dequeuedView
      } else {
        // 3
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type:.detailDisclosure) as UIView
      }
      return view
    }
    return nil
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    let location = view.annotation as! OAMapAnnotation
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    location.mapItem().openInMaps(launchOptions: launchOptions)
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
      contactInfo = temp
    }
  }
  
  func syncContactInfoToDisk(_ contactInfo:[String:String]?) {
    OAJSONHelper.syncTo(kContactInfofilePath, withJSON: contactInfo)
  }
}
