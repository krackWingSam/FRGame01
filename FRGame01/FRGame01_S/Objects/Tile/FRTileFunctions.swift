//
//  FRTileFunction.swift
//  FRGame01_S
//
//  Created by exs-mobile 강상우 on 23/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRTileFunctions: NSObject {
    class func atack(_ tile: FRTile) {
        
        let ap: Int = tile.tilePP.value
        print("tile atack function : %d", tile.tilePP.value!)
        
        //TODO: push animation to animation queue
        
        FRUserInfo.shared.calcDamage(ap)
    }
    
    class func recoverSheild(_ tile: FRTile) {
        let sp: Int = tile.tilePP.value
        
        print("tile shield function : %d", sp)
        
        FRUserInfo.shared.recoveryShield(sp)
    }
    
    class func recoverLife(_ tile: FRTile) {
        let lp: Int = tile.tilePP.value
        
        print("tile life function : %d", lp)
        
        FRUserInfo.shared.recoveryLife(lp)
    }
    
    class func addCoin(_ tile: FRTile) {
        let cp: Int = tile.tilePP.value
        
        print("tile add coin function : %d", cp)
        
        FRUserInfo.shared.addCoin(cp)
    }
}
