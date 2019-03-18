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
                needAnimationCount += 1
                let duration = TimeInterval(FRPreference.shared.tileAnimationDuration)
                let delay = TimeInterval(FRPreference.shared.tileAnimationDelay) * TimeInterval(needAnimationCount)
                
                UIView.animateKeyframes(withDuration: TimeInterval(duration), delay: delay, options: [.layoutSubviews], animations: {
                    let dimensionY = FRPreference.shared.axisY - 1
                    let width = FRPreference.shared.cellWidth
                    let height = FRPreference.shared.cellHeight
                    let x = width * CGFloat(tile.axisX)
                    let y = height * CGFloat(Int(dimensionY) - Int(tile.axisY))
                    let newFrame = CGRect(x: x, y: y, width: width, height: height)
                    tile.imageView.frame = newFrame
//                    print("(\(tile.axisX), \(tile.axisY))")
//                    print("(\(x), \(y))")
//                    print(tile.imageView.frame)
                })
            }
        }
    }
}
