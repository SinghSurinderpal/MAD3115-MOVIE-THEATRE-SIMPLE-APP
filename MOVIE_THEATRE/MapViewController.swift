//
//  MapViewController.swift
//  MOVIE_THEATRE
//
//  Created by MacStudent on 2017-12-12.
//  Copyright © 2017 surinder pal singh sidhu. All rights reserved.
//

import UIKit
import MapKit //importing mapkit package
/*MapViewController class that inherits properties of UIViewController */
class MapViewController: UIViewController {
    var current_location:String?  //Variable to store location
    @IBOutlet weak var mapView: MKMapView! //outlet for mapview
    /*method is invoked after view is loaded in memory*/
    override func viewDidLoad() {
        super.viewDidLoad()
        var location = current_location?.components(separatedBy: ",") //separating latitude and longitude
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(location![0])!,Double(location![1])!)  //storing values of latitude and longitude
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)  //passing location values
        mapView.setRegion(region, animated: true)  //setting location of mapview
        let annotation = MKPointAnnotation()
        annotation.coordinate = myLocation
        mapView.addAnnotation(annotation)
        self.mapView.showsUserLocation = true  //enabling current location
    }
    /*method is called after detecting warning*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
