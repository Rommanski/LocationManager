//
//  Tab2VC.swift
//  LocationManager
//
//  Created by Dmytro Bohachevskyy on 9/3/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import UIKit
import SwiftEventBus

class Tab2VC: UIViewController {
    // MARK : - UI elements
    @IBOutlet weak var travelledDistanceLabel: UILabel!
    
    // MARK : - data
    var messageWasShowwed : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // subscribe for updating location
        SwiftEventBus.onMainThread(self, name: EventBusConst.locationUpdate) { _ in
            // round with 1 digits precision
            let distance = round(LocationManager.instance.distnaceFromStart * 10) / 10
            self.travelledDistanceLabel.text = "\(distance) mtrs"
        }
    }

}
