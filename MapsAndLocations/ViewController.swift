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
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var artworks = [Artwork]()
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    let regionRadius: CLLocationDistance = 1000
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate=self
//        let artwork = Artwork(title: "King David Kalakaua",
//                              locationName: "Waikiki Gateway Park",
//                              discipline: "Sculpture",
//                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
//        
//
//        
        centeronMapLocation(initialLocation)
        loadInitialData()
        mapView.addAnnotations(artworks)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        checkLocationAuthorisationStatus()
    }
    func checkLocationAuthorisationStatus(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
        mapView.showsUserLocation = true
        }
        else
        {
        locationManager.requestWhenInUseAuthorization()
        }
    }
    func loadInitialData() {
        // 1
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json");
        var readError : NSError?
        var data: NSData = NSData(contentsOfFile: fileName!)!
        
        // 2
        do{
        let jsonObject: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data,options: NSJSONReadingOptions(rawValue: 0))
        
        // 3
        if let jsonObject = jsonObject as? [String: AnyObject] ,
            // 4
            let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
            for artworkJSON in jsonData {
                if let artworkJSON = artworkJSON.array,
                    // 5
                    artwork = Artwork.fromJSON(artworkJSON) {
                    artworks.append(artwork)
                }
            }
            }}
        catch{
        
        }
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

