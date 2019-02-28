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
    var type        : FRTileType!
    var imageView   : UIImageView!
    
    var frame       : CGRect {
        get {
            return imageView.frame
        }
    }
    
    var animatedFrame : CGRect {
        get {
            let dimensionY = FRPreference.shared.axisY - 1
            let width = FRPreference.shared.cellWidth
            let height = FRPreference.shared.cellHeight
            let x = width * CGFloat(axisX)
            let y = height * CGFloat(dimensionY - axisY)
            
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    
    class func getRandonTile() -> FRTile {
        let rawValue = arc4random() % UInt32(FRPreference.shared.tileRange) + 1
        let type = FRTileType(rawValue: Int(rawValue))
        let tile = FRTile(type: type!)
        
        return tile
    }

    override init() {
        super.init()
    }
    
    public init(type: FRTileType) {
        self.type = type
        let cellWidth = FRPreference.shared.cellWidth
        let cellHeight = FRPreference.shared.cellHeight
        imageView = FRImageViewManager.shared.getImageView()
        imageView.frame.origin.x = CGFloat(axisX) * cellWidth
        imageView.frame.origin.y = CGFloat(axisY) * cellHeight
        
        imageView.image = FRImageManager.shared.getImage(type: type)
    }
    
    // MARK: - override
    override var description: String {
        get {
            print("testing print description")
            let properties = self.propertyDic()
            var descriptionString = "\n######\nFRTile\n"
            descriptionString += "variables -\n" + properties.description + "\n######\n"
            
            return descriptionString
        }
    }
}
