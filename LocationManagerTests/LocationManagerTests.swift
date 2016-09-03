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
    let realm = try! Realm(configuration: Realm.Configuration(fileURL: nil, inMemoryIdentifier: "test", encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, objectTypes: nil))
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
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
