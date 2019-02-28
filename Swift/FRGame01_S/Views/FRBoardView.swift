//
//  FRBoardView.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRBoardView: UIView {
    let tileAnimationQueue = FRAnimateTileQueue()
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
        
        self.addAllTile()
        
        // add observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceivedTileRemoved(notification:)), name: NSNotification.Name(rawValue: TILEMANAGER_TILE_REMOVED), object: nil)
        // TODO: removeObserver
    }

    // add tile in self
    func initTileMap() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        FRTileManager.shared.initTileMap()
    }
    
    func addAllTile() {
        let tiles = FRTileManager.shared.tileMap
        let axisX = FRTileManager.shared.dimensionX
        let axisY = FRTileManager.shared.dimensionY
        for x in 0..<axisY {
            for y in 0..<axisX {
                let tile = tiles[Int(x)][Int(y)]
                self.addSubview(tile.imageView)
            }
        }
        
        // animation control
        FRAnimateTileQueue.pushTilesInAnimationQueue(tiles: tiles)
    }
    
    
    // MARK: - Notificaion Observer Respond
    @objc func didReceivedTileRemoved(notification: Notification) {
        addAllTile()
    }
    
    
    // MARK: - for debug
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("뷁")
    }
}
