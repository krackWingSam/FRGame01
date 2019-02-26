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
    var isDebug     : Bool      = true
    var axisX       : UInt      = 1 {
        didSet {
            let frame:CGRect = (UIApplication.shared.delegate?.window!!.screen.bounds)!
            cellWidth = frame.size.width / CGFloat(axisX)
        }
    }
    
    var axisY       : UInt      = 1 {
        didSet {
            let frame:CGRect = (UIApplication.shared.delegate?.window!!.screen.bounds)!
            cellHeight = frame.size.width / CGFloat(axisY)
        }
    }
    var cellWidth   : CGFloat   = 0
    var cellHeight  : CGFloat   = 0
    
    // MARK: - initialize
    override private init() {
        super.init()
        print("FRPreference class initialize")
        print(self)
    }
    
    override var description: String {
        get {
            let properties = self.propertyDic()
            
            return properties.description
        }
    }
}
