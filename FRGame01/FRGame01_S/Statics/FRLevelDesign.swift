//
//  FRLevelDesign.swift
//  FRGame01_S
//
//  Created by Fermata 강상우 on 30/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import FRBinder

class FRLevelDesign: FRModel {
    let tileGravity01 = FRProperty(Int.self)
    let tileGravity02 = FRProperty(Int.self)
    let tileGravity03 = FRProperty(Int.self)
    let tileGravity04 = FRProperty(Int.self)
    let tileGravity05 = FRProperty(Int.self)
    let tileGravity06 = FRProperty(Int.self)
    let tileGravity07 = FRProperty(Int.self)
    var gravityArray: [FRProperty<Int>] {
        return [tileGravity01, tileGravity02, tileGravity03, tileGravity04, tileGravity05, tileGravity06, tileGravity07 ]
    }
    
    static let shared: FRLevelDesign = FRLevelDesign()
    
    override init() {
        super.init()
        
        tileGravity01.value = 10
        tileGravity02.value = 8
        tileGravity03.value = 10
        tileGravity04.value = 10
        tileGravity05.value = 10
        tileGravity06.value = 10
        tileGravity07.value = 10
    }
}
