//
//  Tab1VCTests.swift
//  LocationManager
//
//  Created by Dmytro Bohachevskyy on 9/3/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import XCTest
import UIKit
import INTULocationManager
@testable import LocationManager

class Tab1VCTests: XCTestCase {
    var viewController : Tab1VC!
    
    override func setUp() {
        super.setUp()
        
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Tab1VC") as! Tab1VC

    }
    
    func testUpdatingLocation() {
        let _ = viewController.view
        LocationManager.instance.currentLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(20.0), longitude: CLLocationDegrees(20.0))
        LocationManager.instance.locationUpdated()
        
        let lat = Double(viewController.latLabel.text!)
        let lon = Double(viewController.lonLabel.text!)
        XCTAssert(lat == 20.0 && lon == 20.0, "Should be 20.0:20.0")
    }
    
}
