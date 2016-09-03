//
//  Tab2VCTests.swift
//  LocationManager
//
//  Created by Dmytro Bohachevskyy on 9/3/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import XCTest
import RealmSwift
import SwiftEventBus
import Quick
import Nimble
import INTULocationManager
@testable import LocationManager

class Tab2VCTests: QuickSpec {
    override func spec() {
        describe("Tab2VC Controller") {
            var viewController : Tab2VC!
            
            beforeEach {
                viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Tab2VC") as! Tab2VC
            }
            
            afterEach {
                
            }
            
            it("Check updating distance on the screen") {
                let _ = viewController.view
                let original = Double(viewController.travelledDistanceLabel.text!)
                LocationManager.instance.prevLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(0.0), longitude: CLLocationDegrees(0.0))
                LocationManager.instance.currentLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(1.0), longitude: CLLocationDegrees(0.0))
                LocationManager.instance.locationUpdated()
                
                let distance = Double(viewController.travelledDistanceLabel.text!.componentsSeparatedByString(" ")[0])
                expect(distance) != original
            }
        }
    }
}