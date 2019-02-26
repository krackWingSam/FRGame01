//
//  FRTouchController.swift
//  FRGame01_S
//
//  Created by 강상우 on 26/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRTouchController: NSObject {
    
    static let shared: FRTouchController = FRTouchController()
    
    var array_Touches: Array<FRTouch> = []
    var currentTouch: FRTouch!
    
    override init() {
        
    }
    
    // MARK: - Public
    func checkValidTouch(touch: FRTouch) -> Bool {
        if array_Touches.count <= 0 {
            return true
        }
        
        let lastTouch: FRTouch = array_Touches.last!
        if abs(Int(lastTouch.x) - Int(touch.x)) > 1 {
            return false
        }
        if abs(Int(lastTouch.y) - Int(touch.y)) > 1 {
            return false
        }
        
        //chekc smae position with old object
        for oldTouch: FRTouch in array_Touches {
            if oldTouch.isEqual(touch: touch) {
                return false
            }
        }
        return true
    }
    
    func checkRemovableTouch(touch: FRTouch) -> Bool {
        if array_Touches.count < 2 {
            return false
        }
        
        let previousTouch = array_Touches[array_Touches.count-2]
        if previousTouch.isEqual(touch: touch) {
            return true
        }
        
        return false;
    }
    
    func setFirstTouch(touch: FRTouch) {
        array_Touches.removeAll()
        
        if touch.x == -1 || touch.y == -1 {
            return
        }
        
        if FRPreference.shared.isDebug {
            print("set first touch add : " + touch.description)
        }
        
        array_Touches.append(touch)
    }
    
    func addNextTouch(touch: FRTouch) -> Bool {
        currentTouch = touch
        
        if touch.x == -1 || touch.y == -1 {
            return false
        }
        
        if self.checkValidTouch(touch: touch) {
            array_Touches.append(touch)
        }
        else if self.checkRemovableTouch(touch: touch) {
            array_Touches.removeLast()
        }
        else {
            return false
        }
        
        if FRPreference.shared.isDebug {
            print("touches array start - ")
            for obj in array_Touches {
                print(obj)
            }
            print(" - touches array end")
        }
        
        return true
    }
    
    func setLastTouch(touch: FRTouch) -> Bool {
        if self.checkValidTouch(touch: touch) {
            array_Touches.append(touch)
            if FRPreference.shared.isDebug {
                print("add ended : " + touch.description)
            }
            
            return true
        }
        
        return false
    }
}
