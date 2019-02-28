//
//  FRTileManager.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRTileManager: NSObject {
    
    static let shared = FRTileManager()
    
    var tileMap     : [[FRTile]] = []
    var dimensionX  : UInt      = 0
    var dimensionY  : UInt      = 0
    
    override init() {
        super.init()
        
        dimensionX = FRPreference.shared.axisX
        dimensionY = FRPreference.shared.axisY
        initTileMap()
    }
    
    func removeAllTile() {
        if tileMap.count > 0 {
            for i in 0..<tileMap.count {
                tileMap[i].removeAll()
            }
            tileMap.removeAll()
        }
        
        for _ in 0..<dimensionY {
            tileMap.append([])
        }
    }
    
    func initTileMap() {
        removeAllTile()
        
        for x in 0..<dimensionY {
            for y in 0..<dimensionX {
                let tile = FRTile.getRandonTile()
                tile.axisX = x
                tile.axisY = y
                
                tileMap[Int(x)].append(tile)
            }
        }
    }
}
