//
//  FRUserInfo.swift
//  FRGame01_S
//
//  Created by exs-mobile 강상우 on 22/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import EXBinder

class FRUserInfo: EXModel {
    static let shared = FRUserInfo()
    
    let life    = EXProperty(Int.self)      // Life Point
    let AP      = EXProperty(Int.self)      // Atack Point
    let WP      = EXProperty(Int.self)      // Weapon Point
    
    override init() {
        super.init()
        
        clear()
    }
    
    func clear() {
        life.value = 10
        AP.value = 1
        WP.value = 1
    }
}
