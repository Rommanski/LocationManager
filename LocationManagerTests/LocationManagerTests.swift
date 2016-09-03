//
//  LocationManagerTests.swift
//  LocationManagerTests
//
//  Created by Dmytro Bohachevskyy on 9/3/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import XCTest
import RealmSwift
import SwiftEventBus
import Quick
import Nimble
@testable import LocationManager

class LocationManagerTests: QuickSpec {
    let realm = try! Realm()
    
    override func spec() {
        describe("LocationManager") {
            beforeEach {  }
            
            afterEach {  }
            
            it("Adds the Record to the Realm") {
                let origin = self.realm.objects(Record).count
                
                LocationManager.instance.distnaceFromStart = 60
                LocationManager.instance.locationUpdated()
                
                expect(self.realm.objects(Record).count).to(equal(origin + 1))
            }
            
            it("Check location updating") {
                SwiftEventBus.onMainThread(self, name: EventBusConst.locationUpdate) { _ in
                    XCTAssert(true)
                }
                
                LocationManager.instance.locationUpdated()
            }
            
            it("Test status of subscription") {
                LocationManager.instance.startSubscribe()
                expect(LocationManager.instance.subcribtionState).to(equal(true))
            }
            
            it("Test status of subscription 2") {
                LocationManager.instance.startSubscribe()
                expect(LocationManager.instance.subcribtionState).to(equal(true))
            }
        }
    }
}
