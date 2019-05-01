//
//  FRTileFactory.swift
//  FRGame01_S
//
//  Created by exs-mobile 강상우 on 23/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRTileFactory: NSObject {
    static let tileGravity = [10, 8, 10, 10, 10, 10, 10]
    
    // MARK: - private class functions
    class func getTileRange() -> [Range<Int>] {
        var range: [Range<Int>] = []
        var startPoint = 0
        for i in 0..<tileGravity.count {
            range.append(startPoint..<tileGravity[i] + startPoint)
            startPoint += tileGravity[i]
        }
        return range
    }
    
    class func generateTileType() -> FRTileType {
        // calc gavity and percentage for each tile
        var totalPosibleRange = 0
        for i in 0..<FRPreference.shared.tileRange.value {
            totalPosibleRange += tileGravity[i]
        }
        
        var rawValue = Int(arc4random()) % totalPosibleRange
        
        let arrayRange = getTileRange()
        for i in 0..<FRPreference.shared.tileRange.value {
            let range = arrayRange[i]
            if range.contains(rawValue) {
                rawValue = i
                break
            }
        }
        
        return FRTileType(rawValue: Int(rawValue + 1))!
    }
    
    // MARK: - public class functions
    class func getRandomTile() -> FRTile {
        let type = generateTileType()
        let tile = FRTile(type: type)
        
        
        //        tile.tileLP.value = 1
        if tile.type == .FRType_Enemy {
            //TODO: generate life, demage
            tile.tilePP.value = 1
            tile.tileTurnOver = FRTileFunctions.atack
        }
        else if tile.type == .FRType_Shield {
            tile.tilePP.value = 1
            tile.tileWillDisappear = FRTileFunctions.recoverSheild
        }
        else if tile.type == .FRType_Potion {
            tile.tilePP.value = 1
            tile.tileWillDisappear = FRTileFunctions.recoverLife
        }
        else if tile.type == .FRType_Coin {
            tile.tilePP.value = 1
            tile.tileWillDisappear = FRTileFunctions.addCoin
        }
        
        return tile
    }
    
    class func generateTile(_ life: Int, _ type: FRTileType, _ propertyValue: Int) -> FRTile {
        let tile = FRTile(type: type)
        tile.tileLP.value = life
        tile.tilePP.value = propertyValue
        
        return tile
    }
    
    override init() {
        super.init()
    }
}
