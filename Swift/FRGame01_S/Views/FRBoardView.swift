//
//  FRBoardView.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRBoardView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
    }

    // TODO: add tile in self
    func initTileMap() {
        FRTileManager.shared.initTileMap()
    }
    
    func addAllTile() {
        let tiles = FRTileManager.shared.tileMap
        let axisX = FRTileManager.shared.dimensionX
        let axisY = FRTileManager.shared.dimensionY
        for x in 0..<axisY {
            for y in 0..<axisX {
                
            }
        }
        
        
    }
    
    // TODO: animation control
}
