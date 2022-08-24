//
//  PlaceViewController.swift
//  day05
//
//  Created by Kyu Jin Lee on 2022/08/23.
//

import UIKit
import MapKit
import CoreLocation

class PlaceMapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var trackingIsOn : Bool = false
    var placeToShow : MKAnnotation = PlaceList.places.first!
    
    @IBOutlet weak var placesMapView: MKMapView!
    
    
    @IBOutlet weak var tabSegment: UISegmentedControl!
    @IBAction func tabSegmentedBar(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            placesMapView.mapType = .standard
        } else if sender.selectedSegmentIndex == 1 {
            placesMapView.mapType = .satellite
        } else {
            placesMapView.mapType = .hybrid
        }
    }
    
    @IBAction func trackingButton(_ sender: UIButton) {
        
        if !trackingIsOn {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
        trackingIsOn = !trackingIsOn
        placesMapView.setUserTrackingMode(.follow, animated: false)
    }

    
    
    @IBAction func unwindToPlacesMapViewController(_ segue:  UIStoryboardSegue) {
        locationManager.stopUpdatingLocation()
        trackingIsOn = false
        //        updateTrackingButtonViev()
        showPlace(coordinate: placeToShow.coordinate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                print("No access")
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 10
        
        placesMapView.isZoomEnabled = true
        placesMapView.addAnnotations(PlaceList.places)
        showPlace(coordinate: placeToShow.coordinate)
    }
    
    func showPlace(coordinate: CLLocationCoordinate2D) {
        var region = MKCoordinateRegion()
        region.center = coordinate
        region.span.latitudeDelta = 0.01;
        region.span.longitudeDelta = 0.01;
        placesMapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = manager.location?.coordinate else {
            return
        }
        showPlace(coordinate: coordinate)
    }
}

