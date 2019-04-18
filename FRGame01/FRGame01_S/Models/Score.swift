//
//  Score.swift
//  FRGame01_S
//
//  Created by exs-mobile 강상우 on 17/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import EXBinder

class Score: EXModel {
    static let shared = Score()
    
    let tile01 = EXProperty(Int.self)
    let tile02 = EXProperty(Int.self)
    let tile03 = EXProperty(Int.self)
    let tile04 = EXProperty(Int.self)
    let tile05 = EXProperty(Int.self)
    let tile06 = EXProperty(Int.self)
    let tile07 = EXProperty(Int.self)
    let turn   = EXProperty(Int.self)
    
    override init() {
        super.init()
        
        tile01.value = 0
        tile02.value = 0
        tile03.value = 0
        tile04.value = 0
        tile05.value = 0
        tile06.value = 0
        tile07.value = 0
        turn.value = 0
    }
    
    // MARK: - Manage Score
    func appendTile(_ tile : FRTile) {
        switch tile.type {
        case .FRType_Sword?:
            tile01.value += 1
            break
        case .FRType_Enemy?:
            tile02.value += 1
            break
        case .FRType_Test_3?:
            tile03.value += 1
            break
        case .FRType_Test_4?:
            tile04.value += 1
            break
        case .FRType_Test_5?:
            tile05.value += 1
            break
        case .FRType_Test_6?:
            tile06.value += 1
            break
        case .FRType_Test_7?:
            tile07.value += 1
            break
        default: break
        }
    }
    
    func addTile(_ tiles: [FRTile]) {
        for tile in tiles {
            appendTile(tile)
        }
    }
    
    
    func clearPoints() {
        tile01.value = 0
        tile02.value = 0
        tile03.value = 0
        tile04.value = 0
        tile05.value = 0
        tile06.value = 0
        tile07.value = 0
        turn.value = 0
    }
}
