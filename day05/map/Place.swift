//
//  Place.swift
//  day05
//
//  Created by kyujlee on 2022/08/23.
//

import Foundation
import MapKit

class PlaceList {
    static var places: [MKAnnotation] = [
        MKPointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 55.79714, longitude: 37.57983),
                          title: "School 21",
                          subtitle: "Moscow Campus"),
        MKPointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 48.89662, longitude: 2.31851),
                          title: "42",
                          subtitle: "Paris Campus"),
        MKPointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 45.77966, longitude: 4.75065),
                          title: "42",
                          subtitle: "Lyon Campus"),
        MKPointAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 52.42673, longitude: 10.78987),
                          title: "42",
                          subtitle: "Wolfsburg Campus")
    ]
}
//CLLocationCoordinate2D(latitude: 37.4882145, longitude: 127.0647887),
