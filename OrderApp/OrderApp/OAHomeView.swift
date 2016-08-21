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
}


class OAHomeView: UIView {
  
  let regionRadius: CLLocationDistance = 1000
  // set initial location in Honolulu
  let initialLocation = CLLocation(latitude: 34.153494, longitude: -118.758839)
  
  var mapView: MKMapView!
  var mapNotation: OAMapAnnotation!
  
  //MARK: Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.whiteColor()
    self.mapView = MKMapView()
    self._centerMapOnLocation(initialLocation)
    self.mapNotation = OAMapAnnotation(title: "Szechuan Place", subtitle: "5639 Kanan Road, Agoura Hills, CA 91301", coordinate: CLLocationCoordinate2D(latitude: 34.153494, longitude: -118.758839))
    self.addSubview(self.mapView)
    self.mapView.addAnnotation(self.mapNotation)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Layout Views
  
  override func layoutSubviews() {
    self.mapView.frame = self.bounds;
  }
  
  //MARK: Private Helpers
  func _centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius * 2.0,
                                                              regionRadius * 2.0)
    self.mapView.setRegion(coordinateRegion, animated: true)
  }
}