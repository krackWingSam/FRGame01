//
//  FRTouchManager.swift
//  FRGame01_S
//
//  Created by 강상우 on 26/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRTouchManager: NSObject {
    
    static let shared: FRTouchManager = FRTouchManager()
    
    var array_Touches: Array<FRTouch> = []
    var currentTouch: FRTouch!
    
    override init() {
        
    }
    
    // MARK: - Public
    func checkSameTile(touch: FRTouch) -> Bool {
        let axisY = FRPreference.shared.axisY
        
        let firstTouch = array_Touches.first
        let x = firstTouch?.x
        let y = axisY.intValue-1 - (firstTouch?.y)!
        let tile = FRTileManager.shared.tileMap[x!][y]
        
        let currentX = touch.x
        let currentY = axisY.intValue-1 - touch.y
        let currentTile = FRTileManager.shared.tileMap[currentX][currentY]
        
        if tile.type.rawValue != currentTile.type.rawValue {
            return false
        }
        
        return true
    }
    
    func checkValidTouch(touch: FRTouch) -> Bool {
        if array_Touches.count <= 0 {
            return true
        }
        
        let lastTouch: FRTouch = array_Touches.last!
        if abs(Int(lastTouch.x) - Int(touch.x)) > 1 {
            return false
        }
        if abs(Int(lastTouch.y) - Int(touch.y)) > 1 {
            return false
        }
        
        //check smae position with old object
        for oldTouch: FRTouch in array_Touches {
            if oldTouch.isEqual(touch: touch) {
                return false
            }
        }
        
        //check same tile with first touch
        if !checkSameTile(touch: touch) {
            return false
        }
        
        
        return true
    }
    
    func checkRemovableTouch(touch: FRTouch) -> Bool {
        if array_Touches.count < 2 {
            return false
        }
        
        let previousTouch = array_Touches[array_Touches.count-2]
        if previousTouch.isEqual(touch: touch) {
            return true
        }
        
        return false;
    }
    
    func checkLastTouch(touch: FRTouch) -> Bool {
        let lastTouch = array_Touches.last!
        if touch.isEqual(touch:lastTouch) {
            return true
        }
        
        return false
    }
    
    func setFirstTouch(touch: FRTouch) {
        array_Touches.removeAll()
        
        if touch.x == -1 || touch.y == -1 {
            return
        }
        
//        if FRPreference.shared.isDebug {
//            print("set first touch add : " + touch.description)
//        }
        
        array_Touches.append(touch)
    }
    
    func addNextTouch(touch: FRTouch) -> Bool {
        currentTouch = touch
        
        if touch.x == -1 || touch.y == -1 {
            return false
        }
        
        if self.checkValidTouch(touch: touch) {
            array_Touches.append(touch)
        }
        else if self.checkRemovableTouch(touch: touch) {
            array_Touches.removeLast()
        }
        else {
            return false
        }
        
        if FRPreference.shared.isDebug {
//            print("touches array start - ")
//            for obj in array_Touches {
//                print(obj)
//            }
//            print(" - touches array end")
        }
        
        return true
    }
    
    func setLastTouch(touch: FRTouch) -> Bool {
        if self.checkLastTouch(touch: touch) {
            if checkValidTouch(touch: touch) {
                array_Touches.append(touch)
            }
            
//            if FRPreference.shared.isDebug {
//                print("add ended : " + touch.description)
//            }
            
            // make tile array for remove
            var removeTiles : [FRTile] = []
            for touch in array_Touches {
                let dimensionY = Int(FRPreference.shared.axisY - 1)
                let tile = FRTileManager.shared.tileMap[touch.x][dimensionY - touch.y]
                removeTiles.append(tile)
            }
            
            // remove tiles using tile manager
            FRTileManager.shared.removeTile(tiles: removeTiles)
            
            array_Touches.removeAll()
            return true
        }
        
        // clear array
        array_Touches.removeAll()
        
        return false
    }
}
