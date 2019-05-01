//
//  FRScore.swift
//  FRGame01_S
//
//  Created by 강상우 on 01/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRScore: NSObject {
    static let shared = FRScore()
    
    var tileCount: Int = 0
    var tilePoint: [Int] = []
    
    override private init() {
        super.init()
        
        tileCount = FRPreference.shared.tileRange.value
        tilePoint = []
        for i in 0..<tileCount {
            tilePoint[i] = 0
        }
    }
    
    
    public func clearPoint() {
        tilePoint = []
    }
    
}
