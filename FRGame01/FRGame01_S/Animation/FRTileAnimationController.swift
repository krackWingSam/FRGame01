//
//  FRTileAnimationController.swift
//  FRGame01_S
//
//  Created by Fermata 강상우 on 31/07/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRTileAnimationController: NSObject {
    class func pushTilesInAnimationQueue(tiles: [[FRTile]]) {
        var needAnimationCount = 0
        
        for yArray in tiles {
            for tile in yArray {
                let oldFrame = tile.imageView.frame
                let newFrame = tile.animatedFrame
                
                if oldFrame.origin.y != newFrame.origin.y {
                    needAnimationCount += 1
                    let duration = TimeInterval(FRPreference.shared.tileAnimationDuration)
                    let delay = TimeInterval(FRPreference.shared.tileAnimationDelay) * TimeInterval(needAnimationCount)
                    
                    UIView.animateKeyframes(withDuration: TimeInterval(duration), delay: delay, options: [.layoutSubviews], animations: {
                        tile.imageView.frame = newFrame
                    })
                }
            }
        }
    }
    
    class func pushAnimation(_ blocks: [FRAnimationBlock], handler:@escaping () -> Void) {
        var currentAnimations: [FRAnimationBlock] = []
        var leastAnimations: [FRAnimationBlock] = []
        var timeInterval: Double = 0.0
        
        for i in 0..<blocks.count {
            let block = blocks[i]
            if currentAnimations.count == 0 {
                currentAnimations.append(block)
                timeInterval = block.animationFlag.rawValue
                continue
            }
            
            guard let flag = currentAnimations.first?.animationFlag else { continue }
            if flag == block.animationFlag {
                currentAnimations.append(block)
            }
            else {
                leastAnimations.append(block)
            }
        }
        
        for block in currentAnimations {
            block.doAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            if leastAnimations.count == 0 {
                handler()
            }
            else {
                self.pushAnimation(leastAnimations, handler: handler)
            }
        }
    }
}
