//
//  LocationManager.swift
//  LocationManager
//
//  Created by Dmytro Bohachevskyy on 9/3/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import Foundation
import INTULocationManager
import SwiftEventBus

class LocationManager {
    private static var classInstance : LocationManager?
    static var instance : LocationManager {
        get {
            if nil == classInstance {
                classInstance = LocationManager()
            }
            
            return classInstance!
        }
    }
    
    private let locationManager = INTULocationManager.sharedInstance()
    private var subscriptionId : INTULocationRequestID?
    var currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
    
    /**
     * State of subscription updating
     */
    var subcribtionState : Bool {
        get {
            return nil != self.subscriptionId
        }
    }
    
    /**
     * start subscription updating
     */
    func startSubscribe() {
        if nil != self.subscriptionId {
            return
        }
        
        // receive location updates
        self.subscriptionId = locationManager.subscribeToLocationUpdatesWithBlock() { (location : CLLocation!, accuracy : INTULocationAccuracy, status : INTULocationStatus) -> Void in
            if INTULocationStatus.Success == status {
                self.currentLocation = location.coordinate
                // post an event of updating location
                SwiftEventBus.post(EventBusConst.locationUpdate)
            } else {
                // fail dermine location
                print("ERROR: Location determine fail")
            }
        }
    }
    
    /**
     * finish subscription updating
     */
    func finishSubscribe() {
        if nil != subscriptionId {
            locationManager.cancelHeadingRequest(subscriptionId!)
            self.subscriptionId = nil
        }
    }
    
    /**
     * Calculate distance from self to the point
     * Returns distance in kilometers
     */
    func distnceToTheCoordinate( latitude lat : Double, longitude lon : Double ) -> Double {
        let selfLocation = CLLocation(latitude: self.currentLocation.latitude, longitude: self.currentLocation.longitude)
        let pointLocation = CLLocation(latitude: lat, longitude: lon)
        let distance = (selfLocation.distanceFromLocation(pointLocation) / 1000.0)
        
        // round with 1 digits precision
        return round(distance * 10) / 10
    }
}