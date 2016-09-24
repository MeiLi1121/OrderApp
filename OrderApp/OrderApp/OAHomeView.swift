//
//  OAHomeView.swift
//  OrderApp
//
//  Created by Shawn Xu on 8/20/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import AddressBook
import Contacts

class OAMapAnnotation: NSObject, MKAnnotation {
  let title: String?
  let subtitle: String?
  let coordinate: CLLocationCoordinate2D
  
  init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate
    super.init()
  }
  
  //MARK: Public Helpers
  //annotation callout info button opens this mapItem in Maps app
  func mapItem() -> MKMapItem {
    let addressDictionary = [CNPostalAddressStreetKey: self.subtitle!]
    let placemark = MKPlacemark(coordinate: self.coordinate, addressDictionary: addressDictionary)
    
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = self.title
    
    return mapItem
  }
}

public protocol OAHomeViewDelegate : NSObjectProtocol, MKMapViewDelegate, UICollectionViewDataSource {
  func phoneButtonTapped(_ sender: UIButton!)
}

class OAHomeView: UIView {
  
  let regionRadius: CLLocationDistance = 1000
  // set initial location in Honolulu
  let initialLocation = CLLocation(latitude: 34.153494, longitude: -118.758839)
  
  var descriptionLabel: UILabel!
  
  var containerScrollView: UIScrollView!
  
  var hoursView: OAHomeHoursView!
  
  var mapView: MKMapView!
  var mapNotation: OAMapAnnotation!
  
  var descriptionSeparator: UIView!
  var hoursSeparator: UIView!
  var dishGalleryCollectionView: UICollectionView!
  var dishGalleryCollectionViewSeparator: UIView!
  
  //MARK: Life Cycle
  convenience init(delegate: OAHomeViewDelegate) {
    self.init(frame: CGRect.zero)
    self.backgroundColor = UIColor.white
    
    // configure scroll view
    containerScrollView = UIScrollView()
    self.addSubview(containerScrollView)
    
    //configure map view
    self.mapView = MKMapView()
    self._centerMapOnLocation(initialLocation)
    self.mapNotation = OAMapAnnotation(title: "Szechuan Place", subtitle: "5639 Kanan Road, Agoura Hills, CA 91301", coordinate: CLLocationCoordinate2D(latitude: 34.153494, longitude: -118.758839))
    self.mapView.addAnnotation(self.mapNotation)
    self.mapView.delegate = delegate
    self.mapView.selectAnnotation(self.mapNotation, animated: false)
    self.containerScrollView.addSubview(self.mapView)
    
    //configure text view
    self.descriptionLabel = UILabel()
    let nameText = "Szechuan Place"
    let normalText = " offers authentic and delicious tasting Chinese cuisine in Agoura Hills, California. We offer dine-in, take-out, and delivery services in the Agoura Hills community."
    let boldFont = [NSFontAttributeName : OABoldTextFont]
    let descriptionString = NSMutableAttributedString(string:nameText, attributes:boldFont)
    let textFont = [NSFontAttributeName : OAPrimaryTextFont]
    descriptionString.append(NSMutableAttributedString(string:normalText, attributes: textFont))
    self.descriptionLabel.attributedText = descriptionString
    self.descriptionLabel.numberOfLines = 0
    self.containerScrollView.addSubview(self.descriptionLabel)
    
    //configure dine in hours view
    self.hoursView = OAHomeHoursView()
    self.containerScrollView.addSubview(self.hoursView)
    
    //configure separators
    self.descriptionSeparator = UIView()
    self.descriptionSeparator.backgroundColor = OASeparatorColor
    self.containerScrollView.addSubview(self.descriptionSeparator)
    self.hoursSeparator = UIView()
    self.hoursSeparator.backgroundColor = OASeparatorColor
    self.containerScrollView.addSubview(self.hoursSeparator)
    self.dishGalleryCollectionViewSeparator = UIView()
    self.dishGalleryCollectionViewSeparator.backgroundColor = OASeparatorColor
    self.containerScrollView.addSubview(self.dishGalleryCollectionViewSeparator)
    
    // configure dish gallery collection view
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets.zero
    flowLayout.minimumInteritemSpacing = 1.0 / UIScreen.main.scale
    flowLayout.minimumLineSpacing = 1.0 / UIScreen.main.scale
    flowLayout.scrollDirection = .horizontal
    flowLayout.itemSize = CGSize(width: 112, height: 80)
    self.dishGalleryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
    self.dishGalleryCollectionView.dataSource = delegate
    self.dishGalleryCollectionView.register(OADishGalleryCollectionViewCell.self, forCellWithReuseIdentifier: OADishGalleryCollectionViewCellIdentifier)
    self.dishGalleryCollectionView.showsHorizontalScrollIndicator = false
    self.dishGalleryCollectionView.backgroundColor = UIColor.white
    self.containerScrollView.addSubview(self.dishGalleryCollectionView)
  }
  
  //MARK: Layout Views
  
  override func layoutSubviews() {
    let constrainedWidth = self.bounds.size.width - 2 * OADefaultPadding
    let constrainedHeight = self.bounds.size.height
    let descriptionLabelBounds = self.descriptionLabel.sizeThatFits(CGSize(width: constrainedWidth, height: constrainedHeight))
    self.descriptionLabel.frame = CGRect(
        x: OADefaultPadding,
        // have to add 20 for status bar and 44 for navigation bar but don't know why
        y: OADefaultPadding,
        width: descriptionLabelBounds.width,
        height: descriptionLabelBounds.height).integral
   
    self.descriptionSeparator.frame = CGRect(
        x: 0.0,
        y: self.descriptionLabel.frame.maxY + OADefaultPadding,
        width: self.bounds.width,
        height: 1.0 / UIScreen.main.scale).integral
    
    self.dishGalleryCollectionView.frame = CGRect(
        x: 0.0,
        y: self.descriptionSeparator.frame.maxY,
        width: self.bounds.width,
        height: 80.0).integral
    
    self.dishGalleryCollectionViewSeparator.frame = CGRect(
        x: 0.0,
        y: self.dishGalleryCollectionView.frame.maxY,
        width: self.bounds.width,
        height: 1.0 / UIScreen.main.scale).integral
    
    let hoursViewBounds = self.hoursView.sizeThatFits(CGSize(width: self.bounds.width, height: self.bounds.height - self.dishGalleryCollectionView.frame.maxY - OADefaultPadding))
    self.hoursView.frame = CGRect(
        x: 0.0,
        y: self.dishGalleryCollectionViewSeparator.frame.maxY + OADefaultPadding,
        width: hoursViewBounds.width,
        height: hoursViewBounds.height).integral
    
    self.hoursSeparator.frame = CGRect(
        x: 0.0,
        y: self.hoursView.frame.maxY + OADefaultPadding,
        width: self.bounds.width,
        height: 1.0 / UIScreen.main.scale).integral
    
    self.mapView.frame = CGRect(
        x: 0.0,
        y: self.hoursSeparator.frame.maxY,
        width: self.bounds.width,
        height: max(self.bounds.height - self.hoursSeparator.frame.maxY, 200)).integral
    self.containerScrollView.frame = self.bounds
    self.containerScrollView.contentSize = CGSize(width: self.bounds.width, height: self.mapView.frame.maxY)
  }
  
  //MARK: Private Helpers
  func _centerMapOnLocation(_ location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius * 2.0,
                                                              regionRadius * 2.0)
    self.mapView.setRegion(coordinateRegion, animated: true)
  }
}
