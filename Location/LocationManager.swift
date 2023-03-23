//
//  LocationManager.swift
//  Location
//
//  Created by 이송은 on 2023/03/23.
//

import Foundation
import CoreLocation

class LocationManager : NSObject {
    
    override init(){
        super.init()
        manager.delegate = self
    }
    var manager = CLLocationManager()
    var completion : ((CLLocation)->Void)?
    
    func getMyLocation(completion : @escaping (CLLocation)->Void) {
        self.completion = completion
    }
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse :
            manager.startUpdatingLocation()
        case .authorizedAlways :
            manager.startUpdatingLocation()
        case .notDetermined :
            return
        case .denied :
            manager.stopUpdatingLocation()
        case .restricted : //제한된
            return
        @unknown default :
            fatalError()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{
            return
        }
        self.completion?(location)
    }
}
