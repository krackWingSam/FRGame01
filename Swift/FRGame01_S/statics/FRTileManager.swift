//
//  FRTileManager.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

let TILEMANAGER_TILE_REMOVED = "TileManager_Tile_Removed"

class FRTileManager: NSObject {
    
    static let shared = FRTileManager()
    
    var tileMap     : [[FRTile]] = []
    var dimensionX  : UInt      = 0
    var dimensionY  : UInt      = 0
    
    
    
    // MARK: - Calculation
    // make recto for initial position
    func calcTileInitializedRect(tile: FRTile) -> CGRect {
        let boardHeight = FRPreference.shared.boardHeight
        let width = FRPreference.shared.cellWidth
        let height = FRPreference.shared.cellHeight
        let count = FRPreference.shared.tileRange
        let x = CGFloat(tile.axisX) * width
        let y = CGFloat(count-1 - Int(tile.axisY)) * height - boardHeight
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        dimensionX = FRPreference.shared.axisX
        dimensionY = FRPreference.shared.axisY
        initTileMap()
    }
    
    func removeAllTile() {
        if tileMap.count > 0 {
            for i in 0..<tileMap.count {
                // remove imageview from superview
                for tile in tileMap[i] {
                    tile.imageView.removeFromSuperview()
                }
                
                // remove all tile in array
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
        
        fillTileMap()
    }
    
    func fillTileMap() {
        // find empty tile
        for yArray in tileMap {
            let x: Int = tileMap.firstIndex(of: yArray)!
            let count = yArray.count
            
            // create empty tile
            for y in count..<dimensionY.intValue {
                let tile = FRTile.getRandonTile()
                tile.axisX = x.uintValue
                tile.axisY = y.uintValue
                tile.imageView.frame = calcTileInitializedRect(tile: tile)
                
                tileMap[x].append(tile)
            }
        }
        
        refreshTilePosition()
    }
    
    // refresh tile's axis
    func refreshTilePosition() {
        for yArray in tileMap {
            if yArray.count < dimensionY {
                print("########## Assert!")
                print("\t tile map doesn't filled")
                print("##########")
                return
            }
            
            let x: Int = tileMap.firstIndex(of: yArray)!
            for y in 0..<dimensionY.intValue {
                let tile = tileMap[x][y]
                tile.axisX = x.uintValue
                tile.axisY = y.uintValue
            }
        }
    }
    
    func removeTile(tiles: [FRTile]) {
        for tile in tiles {
            tile.imageView.removeFromSuperview()
            
            for yArray in tileMap {
                let x = tileMap.firstIndex(of: yArray)
                let index = yArray.firstIndex(of: tile)
                guard index != nil else {
                    continue
                }
                tileMap[x!].remove(at: index!)
            }
        }
        fillTileMap()
        refreshTilePosition()
        sendNotification()
    }
    
    // MARK: - Notification
    func sendNotification() {
        NotificationCenter.default.post(name: Notification.Name(TILEMANAGER_TILE_REMOVED), object: nil)
    }
}