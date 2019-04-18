//
//  IntExtension.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit


extension Int {
    var floatValue: CGFloat {
        get {
            return CGFloat(self)
        }
    }
    
    var uintValue: UInt {
        get {
            return UInt(self)
        }
    }
}
