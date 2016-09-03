//
//  Tab1VC.swift
//  LocationManager
//
//  Created by Dmytro Bohachevskyy on 9/3/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import UIKit
import SwiftEventBus
import INTULocationManager

class Tab1VC: UIViewController {
    // MARK : ui elements
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // start determine user location
        LocationManager.instance.startSubscribe()
        
        // subscribe for updating location
        SwiftEventBus.onMainThread(self, name: EventBusConst.locationUpdate) { _ in
            let location = LocationManager.instance.currentLocation
            self.latLabel.text = "\(location.latitude)"
            self.lonLabel.text = "\(location.longitude)"
        }
    }
}
