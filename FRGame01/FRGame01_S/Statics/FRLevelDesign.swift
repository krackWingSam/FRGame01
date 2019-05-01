//
//  FRLevelDesign.swift
//  FRGame01_S
//
//  Created by exs-mobile 강상우 on 30/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import EXBinder

class FRLevelDesign: EXModel {
    let tileGravity01 = EXProperty(Int.self)
    let tileGravity02 = EXProperty(Int.self)
    let tileGravity03 = EXProperty(Int.self)
    let tileGravity04 = EXProperty(Int.self)
    let tileGravity05 = EXProperty(Int.self)
    let tileGravity06 = EXProperty(Int.self)
    let tileGravity07 = EXProperty(Int.self)
    
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
