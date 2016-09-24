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

class OAHomeViewController: UIViewController, OAHomeViewDelegate, UICollectionViewDataSource {
  
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
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    self.title = "Home"
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
  
  func phoneButtonTapped(_ sender: UIButton!) {
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  //MARK: UICollectionViewDataSource

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dishImages().count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OADishGalleryCollectionViewCellIdentifier, for: indexPath) as! OADishGalleryCollectionViewCell
    cell.imageView.image = dishImages()[(indexPath as NSIndexPath).row]
    cell.backgroundColor = UIColor.red
    return cell
  }
}
