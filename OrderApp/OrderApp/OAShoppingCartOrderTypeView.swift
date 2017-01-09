//
//  OAShoppingCartOrderTypeView.swift
//  OrderApp
//
//  Created by Shawn Xu on 9/25/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit
import MapKit

public protocol OAShoppingCartOrderTypeViewDelegate : UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {
  func nextButtonTapped(_ sender: UIButton!)
}

class OAShoppingCartOrderTypeView: UIView {
  
  //MARK: Private Properties
  
  var contactInfoTableView: UITableView!
  private var nextButton: UIButton!
  private var pickUpRadioView: OARadioButtonTextLabelView!
  private var deliverRadioView: OARadioButtonTextLabelView!
  private var mapView: MKMapView!
  private var mapNotation: OAMapAnnotation!
  
  weak private var delegate: OAShoppingCartOrderTypeViewDelegate!
  
  //MARK: Life Cycle
  
  convenience init(delegate: OAShoppingCartOrderTypeViewDelegate) {
    self.init(frame: CGRect.zero)
    
    self.delegate = delegate
    
    // configure contact info table view
    contactInfoTableView = UITableView();
    contactInfoTableView.dataSource = delegate
    contactInfoTableView.delegate = delegate
    // remove extra table view cells
    contactInfoTableView.tableFooterView = UIView(frame: CGRect.zero)
    contactInfoTableView.separatorInset = UIEdgeInsets.zero
    contactInfoTableView.separatorColor = OASeparatorColor
    contactInfoTableView.alwaysBounceVertical = false
    self.addSubview(contactInfoTableView)
    
    //configure item radio views
    pickUpRadioView = OARadioButtonTextLabelView(text: "Pick Up",
                                                 isChecked: false)
    pickUpRadioView.isUserInteractionEnabled = true
    self.addSubview(pickUpRadioView)
    pickUpRadioView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                action: #selector(self.handlePickUpTap)))
    
    deliverRadioView = OARadioButtonTextLabelView(text: "Deliver",
                                                  isChecked: true)
    deliverRadioView.isUserInteractionEnabled = true
    self.addSubview(self.deliverRadioView)
    deliverRadioView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(self.handleDeliverTap)))
    
    // configure button view
    nextButton = UIButton()
    nextButton.setTitle("Next", for: UIControlState())
    nextButton.setTitleColor(UIColor.white, for: UIControlState())
    nextButton.backgroundColor = OATabBarBarTintColor
    nextButton.layer.cornerRadius = 4.0
    nextButton.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
    self.addSubview(nextButton)
    
    //configure map view
    self.mapView = MKMapView()
    self._centerMapOnLocation( CLLocation(latitude: 34.153494, longitude: -118.758839))
    self.mapNotation = OAMapAnnotation(title: "Szechuan Place", subtitle: "5639 Kanan Road, Agoura Hills, CA 91301", coordinate: CLLocationCoordinate2D(latitude: 34.153494, longitude: -118.758839))
    self.mapView.addAnnotation(self.mapNotation)
    self.mapView.delegate = delegate
    self.mapView.selectAnnotation(self.mapNotation, animated: false)
    self.mapView.isHidden = true
    self.addSubview(self.mapView)
  }
  
  //MARK: Layout
  
  override func layoutSubviews() {
    let yOffset: CGFloat = kOATopLayoutOffset + 20.0
    let pickUpRadioViewBounds = pickUpRadioView.sizeThatFits(CGSize(width: self.bounds.width / 4.0,
                                                                    height: CGFloat.greatestFiniteMagnitude))
    pickUpRadioView.frame = CGRect(
      x: self.bounds.width / 8.0,
      y: yOffset,
      width: self.bounds.width / 4.0,
      height: pickUpRadioViewBounds.height).integral
    
    deliverRadioView.frame = CGRect(
      x: self.bounds.width / 2.0,
      y: yOffset,
      width: self.bounds.width / 4.0,
      height: pickUpRadioViewBounds.height).integral
    
    nextButton.frame = CGRect(
      x: self.bounds.width / 2.0 - kOANextButtonWidth / 2.0,
      y: self.bounds.height - kOANextButtonHeight - kOATabBarHeight - 20.0,
      width: kOANextButtonWidth,
      height: kOANextButtonHeight).integral
    
    self.mapView.frame = CGRect(
      x: 0.0,
      y: self.pickUpRadioView.frame.maxY + 2 * kOADefaultPadding,
      width: self.bounds.width,
      height: nextButton.frame.minY - pickUpRadioView.frame.maxY - 4 * kOADefaultPadding).integral
    
    contactInfoTableView.frame = CGRect(
      x: 0,
      y: pickUpRadioView.frame.maxY + kOADefaultPadding,
      width: self.bounds.width,
      height: nextButton.frame.minY - pickUpRadioView.frame.maxY - 2 * kOADefaultPadding).integral;
  }
  
  //MARK: UIGestureRecognizer
  
  func handlePickUpTap(_ sender: UITapGestureRecognizer) {
    pickUpRadioView.isChecked = true
    deliverRadioView.isChecked = false
    mapView.isHidden = false
    contactInfoTableView.isHidden = true
  }
  
  func handleDeliverTap(_ sender: UITapGestureRecognizer) {
    pickUpRadioView.isChecked = false
    deliverRadioView.isChecked = true
    mapView.isHidden = true
    contactInfoTableView.isHidden = false
  }
  
  //MARK: Button Action
  func buttonTapped(_ sender: UIButton!) {
    delegate.nextButtonTapped(sender)
  }
  
  //MARK: Private Helpers
  func _centerMapOnLocation(_ location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              1000 * 2.0,
                                                              1000 * 2.0)
    self.mapView.setRegion(coordinateRegion, animated: true)
  }
}
