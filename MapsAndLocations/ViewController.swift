//
//  ViewController.swift
//  MapsAndLocations
//
//  Created by kartikey on 14/05/16.
//  Copyright © 2016 kartikey. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 1000
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate=self
        let artwork = Artwork(title: "King David Kalakaua",
                              locationName: "Waikiki Gateway Park",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        

        centeronMapLocation(initialLocation)
        mapView.addAnnotation(artwork)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func centeronMapLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

