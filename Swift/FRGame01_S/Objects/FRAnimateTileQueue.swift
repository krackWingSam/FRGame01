//
//  FRAnimateTileQueue.swift
//  FRGame01_S
//
//  Created by 강상우 on 28/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRAnimateTileQueue: NSObject {
    class func pushTilesInAnimationQueue(tiles: [[FRTile]]) {
        var needAnimationCount = 0
        
        for yArray in tiles {
            for tile in yArray {
                let originFrame = tile.imageView.frame
                let newFrame = tile.animatedFrame
                
                if originFrame != newFrame {
                    needAnimationCount += 1
//                    var duration = FRPreference.shared.tileAnimationDuration
//                    duration = duration * (newFrame.origin.y - originFrame.origin.y)/FRPreference.shared.cellHeight
                    let duration = TimeInterval(FRPreference.shared.tileAnimationDuration)
                    let delay = TimeInterval(FRPreference.shared.tileAnimationDelay) * TimeInterval(needAnimationCount)
                    
                    UIView.animateKeyframes(withDuration: TimeInterval(duration), delay: delay, options: [], animations: {
                        tile.imageView.frame = tile.animatedFrame
                    })
                }
            }
        }
    }
}
