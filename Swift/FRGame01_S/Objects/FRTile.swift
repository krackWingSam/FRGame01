//
//  FRTile.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

public enum FRTileType: Int, CaseIterable {
    case FRType_Test_1 = 1,
         FRType_Test_2,
         FRType_Test_3,
         FRType_Test_4,
         FRType_Test_5,
         FRType_Test_6,
         FRType_Test_7
}

class FRTile: NSObject {
    
    var axisX       : UInt          = 0
    var axisY       : UInt          = 0
    var type        : FRTileType    = .FRType_Test_1
    var imageView   : UIImageView!

    override init() {
        super.init()
        
    }
    
    public init(type: FRTileType) {
        imageView = FRImageViewManager.shared.getImageView()
        imageView.image = FRImageManager.shared.getImage(type: type)
    }
    
    class func getRandonTile() -> FRTile {
        let rawValue = arc4random() % UInt32(FRTileType.allCases.count) + 1
        let type = FRTileType(rawValue: Int(rawValue))
        let tile = FRTile(type: type!)
        
        return tile
    }
}
