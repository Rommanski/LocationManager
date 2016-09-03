//
//  MessengerHelper.swift
//  LocationManager
//
//  Created by Dmytro Bohachevskyy on 9/3/16.
//  Copyright © 2016 Dmytro Bohachevskyy. All rights reserved.
//

import Foundation
import SVProgressHUD

struct MessangerHelper {
    static func showInfoMessage(withText text : String) {
        SVProgressHUD.showInfoWithStatus(text, maskType: SVProgressHUDMaskType.Clear)
    }
}