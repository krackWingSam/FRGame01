//
//  FRPreference.swift
//  FRGame01_S
//
//  Created by 강상우 on 26/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import FRBinder

class FRPreference: FRModel {
    // MARK: -
    static let shared = FRPreference()
    
    // MARK: - variables
    /// 디버그모드를 위한 flag
    var isDebug                 = FRProperty(Bool.self)
    
    /// 보드의 X 좌표
    var axisX                   = FRProperty(Int.self)
    
    /// 보드의 Y 좌표
    var axisY                   = FRProperty(Int.self)
    
    // MARK: - test variables
    var tileRange               = FRProperty(Int.self)
    
    /// 타일 애니메이션의 길이
    var tileAnimationDuration   : CGFloat   = 0.1
    
    /// 각 타일 애니메이션의 실행전 delay
    var tileAnimationDelay      : CGFloat   = 0.02
    
    
    /// 타일의 너비
    var cellWidth   : CGFloat       {
        get {
            return UIScreen.main.bounds.size.width / axisX.value.floatValue
        }
    }
    
    /// 타일의 높이
    var cellHeight  : CGFloat       {
        get {
            return UIScreen.main.bounds.size.width / axisY.value.floatValue
        }
    }
    
    /// 보드의 높이
    var boardHeight : CGFloat       {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    
    // MARK: - initialize
    override private init() {
        super.init()
        
        isDebug.value = false
        axisX.value = 7
        axisY.value = 7
        tileRange.value = 5
        
        
        if isDebug.value {
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
