//
//  Tab2VCTests.swift
//  LocationManager
//
//  Created by Dmytro Bohachevskyy on 9/3/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import XCTest
import UIKit
import INTULocationManager
@testable import LocationManager

class Tab2VCTests: XCTestCase {
    var viewController : Tab2VC!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Tab2VC") as! Tab2VC
        
    }
    
    func testUpdatingLocation() {
        let _ = viewController.view
        let originel = Double(viewController.travelledDistanceLabel.text!)
        LocationManager.instance.prevLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
        LocationManager.instance.currentLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(1.0), longitude: CLLocationDegrees(0.0))
        LocationManager.instance.locationUpdated()
        
        let distance = Double(viewController.travelledDistanceLabel.text!)
        XCTAssert(originel != distance)
    }
}

