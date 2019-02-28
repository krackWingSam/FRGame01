//
//  FRPreference.swift
//  FRGame01_S
//
//  Created by 강상우 on 26/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRPreference: NSObject {
    // MARK: -
    static let shared = FRPreference()
    
    // MARK: - variables
    var isDebug                 : Bool      = true
    var axisX                   : UInt      = 7
    var axisY                   : UInt      = 7
    var tileAnimationDuration   : CGFloat   = 0.1
    var tileAnimationDelay      : CGFloat   = 0.02
    
    // MARK: - test variables
    var tileRange               : Int       = 7
    
    
    var cellWidth   : CGFloat       {
        get {
            return UIScreen.main.bounds.size.width / axisX.floatValue
        }
    }
    var cellHeight  : CGFloat       {
        get {
            return UIScreen.main.bounds.size.width / axisY.floatValue
        }
    }
    var boardHeight : CGFloat       {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    
    // MARK: - initialize
    override private init() {
        super.init()
        
        if isDebug {
            print("FRPreference class initialize")
            print(self.description)
        }
    }
    
    
    // MARK: - override
    override var description: String {
        get {
            print("testing print description")
            let properties = self.propertyDic()
            var descriptionString = "\n######\nFRPreference\n"
            descriptionString += "variables -\n" + properties.description + "\n######\n"
            
            return descriptionString
        }
    }
}
