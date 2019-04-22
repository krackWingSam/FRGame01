//
//  FRTile.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import EXBinder

public enum FRTileType: Int, CaseIterable {
    case FRType_Sword = 1,
         FRType_Enemy,
         FRType_Test_3,
         FRType_Test_4,
         FRType_Test_5,
         FRType_Test_6,
         FRType_Test_7
}

class FRTile: NSObject {
    
    var axisX       : UInt          = 0
    var axisY       : UInt          = 0
    var tileLP                      = EXProperty(Int.self)  // Life Point
    var tileAP                      = EXProperty(Int.self)  // Atack Point
    
    var label_LP    : UILabel?
    var label_AP    : UILabel?
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
            let y = height * CGFloat(Int(dimensionY) - Int(axisY))
            
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    
    class func getRandomTile() -> FRTile {
        let rawValue = arc4random() % UInt32(FRPreference.shared.tileRange) + 1
        let type = FRTileType(rawValue: Int(rawValue))
        let tile = FRTile(type: type!)
        
        
//        tile.tileLP.value = 1
        if tile.type == .FRType_Enemy {
            //TODO: generate life, demage
        }
        else {
            
        }
        
        return tile
    }
    
    class func getRandomTile(_ life: Int) -> FRTile {
        let tile = FRTile.getRandomTile()
        tile.tileLP.value = life
        
        return tile
    }

    override init() {
        super.init()
    }
    
    // MARK: - Public
    public init(type: FRTileType) {
        super.init()
        
        self.type = type
        let cellWidth = FRPreference.shared.cellWidth
        let cellHeight = FRPreference.shared.cellHeight
        imageView = FRImageViewManager.shared.getImageView()
        imageView.frame.origin.x = CGFloat(axisX) * cellWidth
        imageView.frame.origin.y = CGFloat(axisY) * cellHeight
        
        imageView.image = FRImageManager.shared.getImage(type: type)
        
        tileLP.value = 0
        tileAP.value = 0
        
        if type == .FRType_Enemy {
            initLP()
            initAP()
            // test code
            tileLP.value = 3
        }
        if type == .FRType_Sword {
            initAP()
            tileAP.value = FRUserInfo.shared.WP.value
        }
    }
    
    func initAP() {
        label_AP = UILabel()
        guard let label_AP = label_AP else { return }
        
        label_AP.textColor = UIColor.black
        label_AP.font = UIFont.systemFont(ofSize: 12)
        label_AP.frame.size.width = imageView.frame.size.width
        label_AP.frame.size.height = 10
        label_AP.frame.origin.x = imageView.frame.size.height - 10 - 5
        label_AP.frame.origin.y = imageView.frame.size.width - 10 - 5
        
        tileAP.bind(userInterface: label_AP, propertyToInterface: { (property, label) in
            label_AP.text = String(property.value)
        }) { (property, label) in }
        imageView.addSubview(label_AP)
    }
    
    func initLP() {
        label_LP = UILabel()
        guard let label_LP = label_LP else { return }
        
        label_LP.textColor = UIColor.black
        label_LP.font = UIFont.systemFont(ofSize: 12)
        label_LP.frame.size.width = imageView.frame.size.width
        label_LP.frame.size.height = 10
        label_LP.frame.origin.x = 5
        label_LP.frame.origin.y = 5
        
        tileLP.bind(userInterface: label_LP, propertyToInterface: { (property, label) in
            label.text = String(property.value)
        }) { (property, label) in }
        imageView.addSubview(label_LP)
    }
    
    public func canRemoveTile(_ life: Int) -> Bool {
        tileLP.value -= life
        return tileLP.value <= 0 ? true : false
        
    }
    
    public func removeTile() {
        self.imageView.removeFromSuperview()
        if label_LP != nil {
            label_LP!.removeFromSuperview()
        }
        if label_AP != nil {
            label_AP!.removeFromSuperview()
        }
        tileAP.releaseAll()
        tileLP.releaseAll()
    }
    
    // MARK: - override
    override var description: String {
        get {
            let properties = self.propertyDic()
            
            var descriptionString = "FRTile - \n"
            for key in Array(properties.keys) {
                descriptionString += key + " : " + properties[key].debugDescription
                descriptionString += "\n"
            }
            
            return descriptionString
        }
    }
}
