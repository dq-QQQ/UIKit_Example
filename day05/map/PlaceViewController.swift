//
//  PlaceViewController.swift
//  day05
//
//  Created by kyujlee on 2022/08/23.
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
    //        //        print("\(current?.coordinate.longitude) and \(current?.coordinate.latitude)")
    //        locationManager.startUpdatingLocation()
    //        var region = MKCoordinateRegion()
    //        region.center = current!.coordinate
    //        region.span.latitudeDelta = 0.01;
    //        region.span.longitudeDelta = 0.01;
    //        placesMapView.setRegion(region, animated: true)
    //        locationManager.stopUpdatingLocation()
    //        placesMapView.setUserTrackingMode(.follow, animated: true)
    
    
    @IBAction func unwindToPlacesMapViewController(_ segue:  UIStoryboardSegue) {
        locationManager.stopUpdatingLocation()
        trackingIsOn = false
        //        updateTrackingButtonViev()
        showPlace(coordinate: placeToShow.coordinate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        locationManager.distanceFilter = 10
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //        locationManager.requestWhenInUseAuthorization()
        //        locationManager.startUpdatingLocation()
        //
        //
        //        var  a = MKPointAnnotation()
        //        a.coordinate = CLLocationCoordinate2D(latitude: (current?.coordinate.latitude)!, longitude: (current?.coordinate.longitude)!)
        //        showPlace(place: a)
        
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
        
        //        placesMapView.isZoomEnabled = true
        //        placesMapView.addAnnotations(PlaceList.places)
        //        showPlace(coordinate: placeToShow.coordinate)
        //        locationManager.delegate = self
        //        // 정확도를 최고로 설정
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //        // 위치 데이터를 추적하기 위해 사용자에게 승인 요구
        //        locationManager.requestWhenInUseAuthorization()
        //        // 위치 업데이트를 시작
        //        locationManager.startUpdatingLocation()
        //        // 위치 보기 설정
        //        placesMapView.showsUserLocation = true
        
        locationManager.delegate = self //delegate 선언
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

