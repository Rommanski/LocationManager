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
@testable import LocationManager

class LocationManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInsertingToDatabase() {
        let realm = try! Realm()
        let originalSize = realm.objects(Record).count
        
        LocationManager.instance.distnaceFromStart = 60
        LocationManager.instance.locationUpdated()
        
        XCTAssertEqual(realm.objects(Record).count, originalSize + 1)
    }
    

    func testUpdatingLocation() {
        SwiftEventBus.onMainThread(self, name: EventBusConst.locationUpdate) { _ in
            XCTAssert(true)
        }
        
        LocationManager.instance.locationUpdated()
    }
    
    func testStatusOfSubscription() {
        LocationManager.instance.startSubscribe()
        XCTAssertEqual(LocationManager.instance.subcribtionState, true)
    }
    
    func testStatusOfSubscription2() {
        LocationManager.instance.finishSubscribe()
        XCTAssertEqual(LocationManager.instance.subcribtionState, false)
    }
}
