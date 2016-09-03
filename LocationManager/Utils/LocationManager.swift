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
import RealmSwift

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
    private var messageWasShowwed : Bool = false
    var prevLocation : CLLocationCoordinate2D?
    var currentLocation : CLLocationCoordinate2D?
    var distnaceFromStart : Double = 0.0
    
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
                self.prevLocation = self.currentLocation
                self.currentLocation = location.coordinate
                
                self.locationUpdated()
            } else {
                // fail dermine location
                print("ERROR: Location determine fail")
            }
        }
    }
    
    /**
     * Update all values after location updates
     */
    func locationUpdated() {
        // update travelled distance
        self.distnaceFromStart += self.distnceToPrevLocation
        
        // post an event of updating location
        SwiftEventBus.post(EventBusConst.locationUpdate)
        
        // show message that user has travelled 50 meters
        if self.distnaceFromStart > 50.0 && !self.messageWasShowwed {
            self.messageWasShowwed = true
            MessangerHelper.showInfoMessage(withText: "User has travelled 50 mtrs")
            
            // save record about 50 travelled meters to database
            let realm = try! Realm()
            try! realm.write {
                let r = Record()
                r.date = NSDate()
                realm.add(r)
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
     * Calculate distance from self to the prev location
     * Returns distance in meters
     */
    var distnceToPrevLocation : Double {
        get {
            if nil == self.currentLocation || nil == self.prevLocation {
                return 0.0
            }
            
            let selfLocation = CLLocation(latitude: self.currentLocation!.latitude, longitude: self.currentLocation!.longitude)
            let pointLocation = CLLocation(latitude: self.prevLocation!.latitude, longitude: self.prevLocation!.longitude)
            return selfLocation.distanceFromLocation(pointLocation)
        }
    }
}