//
//  Tab3VCTests.swift
//  LocationManager
//
//  Created by Dmytro Bohachevskyy on 9/4/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import XCTest
import RealmSwift
import SwiftEventBus
import Quick
import Nimble
import INTULocationManager
@testable import LocationManager

class Tab3VCTests: QuickSpec {
    override func spec() {
        describe("Tab3VC Controller") {
            var viewController : Tab3VC!
            
            beforeEach {
                viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Tab3VC") as! Tab3VC
                viewController.tableView.layoutIfNeeded()
            }
            
            afterEach {
                
            }
            
            it("Check updating distance on the screen") {
                let _ = viewController.view
                let original = viewController.tableView.numberOfRowsInSection(0)
                LocationManager.instance.distnaceFromStart = 60
                LocationManager.instance.locationUpdated()
                
                print(original)
                print(viewController.tableView.numberOfRowsInSection(0))
                expect(viewController.tableView.numberOfRowsInSection(0)) == original + 1
            }
        }
    }
}