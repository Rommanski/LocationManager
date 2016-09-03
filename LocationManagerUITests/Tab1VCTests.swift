//
//  Tab1VCTests.swift
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

class Tab1VCTests: QuickSpec {
    override func spec() {
        describe("Tab1VC Controller") {
            var viewController : Tab1VC!
            beforeEach {
                viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Tab1VC") as! Tab1VC
            }
            
            it("Check updating location on the screen") {
                let _ = viewController.view
                let val = 20.0
                LocationManager.instance.currentLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(val), longitude: CLLocationDegrees(val))
                LocationManager.instance.locationUpdated()
                
                let lat = Double(viewController.latLabel.text!)
                let lon = Double(viewController.lonLabel.text!)
                expect(lat).to(equal(val))
                expect(lon).to(equal(val))
            }
        }
    }
}
