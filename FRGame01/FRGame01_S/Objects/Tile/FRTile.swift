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
         FRType_Shield,
         FRType_Potion,
         FRType_Coin,
         FRType_Test_6,
         FRType_Test_7
}

class FRTile: NSObject {
    
    typealias Closure_TurnOverAction = (FRTile) -> Void
    typealias Closure_TileWillDisappearAction = (FRTile) -> Void
    typealias Closure_TileWillAppearAction = (FRTile) -> Void
    
    var axisX       : UInt          = 0
    var axisY       : UInt          = 0
    
    // Life Point.
    var tileLP                      = EXProperty(Int.self)
    
    // Property Point.
    // property can be any value. example, attack or healing or shield ...
    var tilePP                      = EXProperty(Int.self)
    
    var label_LP    : UILabel?
    var label_AP    : UILabel?
    var type        : FRTileType!
    var imageView   : UIImageView!
    
    var tileWillAppear: Closure_TileWillAppearAction?
    var tileWillDisappear: Closure_TileWillDisappearAction?
    var tileTurnOver: Closure_TileWillAppearAction?
    
    var frame       : CGRect {
        get {
            return imageView.frame
        }
    }
    
    var animatedFrame : CGRect {
        get {
            let dimensionY = FRPreference.shared.axisY.value - 1
            let width = FRPreference.shared.cellWidth
            let height = FRPreference.shared.cellHeight
            let x = width * CGFloat(axisX)
            let y = height * CGFloat(Int(dimensionY) - Int(axisY))
            
            return CGRect(x: x, y: y, width: width, height: height)
        }
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
        tilePP.value = 0
        
        if type == .FRType_Enemy {
            initLP()
            initAP()
            // test code
            tileLP.value = 3
        }
        if type == .FRType_Sword {
            initAP()
            tilePP.value = FRUserInfo.shared.WP.value
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
        
        tilePP.bind(userInterface: label_AP, propertyToInterface: { (property, label) in
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
        tilePP.releaseAll()
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
