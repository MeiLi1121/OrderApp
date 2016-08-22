//
//  OAHomeViewController.swift
//  OrderApp
//
//  Created by Shawn Xu on 7/24/16.
//  Copyright © 2016 Shawn Xu. All rights reserved.
//

import UIKit
import MapKit
import AddressBook

class OAHomeViewController: UIViewController, OAHomeViewDelegate {
  
  //MARK:Properties
  
  var homeView:OAHomeView?
  
  //MARK: View Controller
  
  override func loadView() {
    self.homeView = OAHomeView(delegate: self)
    self.view = self.homeView
    self.view.setNeedsLayout()
    self.view.layoutIfNeeded()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // remove "back" text from back button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                            style: .Plain,
                                                            target: nil,
                                                            action: nil)
    self.title = "Home"
  }
  
  //MARK: MKMapViewDelegate
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    if let annotation = annotation as? OAMapAnnotation {
      let identifier = "pin"
      var view: MKPinAnnotationView
      if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        as? MKPinAnnotationView { // 2
        dequeuedView.annotation = annotation
        view = dequeuedView
      } else {
        // 3
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure) as UIView
      }
      return view
    }
    return nil
  }
  
  func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    let location = view.annotation as! OAMapAnnotation
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    location.mapItem().openInMapsWithLaunchOptions(launchOptions)
  }
  
  func phoneButtonTapped(sender: UIButton!) {
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
}
