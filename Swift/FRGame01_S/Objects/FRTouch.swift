//
//  FRTouch.swift
//  FRGame01_S
//
//  Created by 강상우 on 26/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRTouch: NSObject {
    // MARK: - Properties
    public private(set) var x       : NSInteger = 0
    public private(set) var y       : NSInteger = 0
    public private(set) var position: CGPoint   = .zero
    
    // MARK: -
    class func calcTouchedPoint(location: CGPoint, cellWidth:CGFloat, cellHeight:CGFloat) -> CGPoint {
        let cellX: Int = Int(floor(location.x/cellWidth));
        let cellY: Int = Int(floor(location.y/cellHeight));
        
        let innerLocation_X: CGFloat = location.x - (cellWidth * CGFloat(cellX));
        let innerLocation_Y: CGFloat = location.y - (cellHeight * CGFloat(cellY));
        
        var isSelected = false
        
        // extract Quadrant
        if (innerLocation_X > cellWidth/2 && innerLocation_Y > cellHeight/2) {
            // Quadrant 2
            if (innerLocation_Y < -innerLocation_X + 93.75 ) {
                isSelected = true;
            }
        }
        else if (innerLocation_X < cellWidth/2 && innerLocation_Y > cellHeight/2) {
            // Quadrant 3
            if (innerLocation_Y < innerLocation_X + 31.25) {
                isSelected = true;
            }
        }
        else if (innerLocation_X < cellWidth/2 && innerLocation_Y < cellHeight/2) {
            // Quadrant 4
            if (innerLocation_Y > -innerLocation_X + 31.25 ) {
                isSelected = true;
                
            }
        }
        else {
            // Quadrant 1
            if (innerLocation_Y > innerLocation_X - 31.25) {
                isSelected = true;
            }
        }
        
        var touchedPoint: CGPoint;
        if (isSelected) {
            touchedPoint = CGPoint(x:cellX, y:cellY);
        }
        else {
            touchedPoint = CGPoint(x:-1, y:-1);
        }
        
        return touchedPoint
    }
    
    
    // MARK: - Initializer
    class func getTouch( dimension: CGPoint!, viewSize: CGSize!, location: inout CGPoint!) -> FRTouch {
        var cellWidth : CGFloat, cellHeight: CGFloat
        var _location = location!
        
        cellWidth = viewSize.width / dimension.x
        cellHeight = viewSize.height / dimension.y
        
        if _location.x >= viewSize.width    { _location.x = viewSize.width-1 }
        if _location.x <= 0                 { _location.x = 0 }
        if _location.y >= viewSize.height   { _location.y = viewSize.height-1; }
        if _location.y <= 0                 { _location.y = 0 }
        
        let touchedPoint = FRTouch.calcTouchedPoint(location: _location, cellWidth: cellWidth, cellHeight: cellHeight)
        
        return FRTouch(point: touchedPoint, position: _location)
    }
    
    public init(point: CGPoint, position: CGPoint) {
        self.x = Int(floor(point.x))
        self.y = Int(floor(point.y))
        self.position = position;
    }
    
    
    // MARK: - public
    func isEqual(touch: FRTouch) -> Bool {
        if self.x == touch.x, self.y == touch.y {
            return true
        }
        
        return false
    }
    
    // MARK: - Override
    override var description: String {
        get {
            return "x : " + String(x) + ", y : " + String(y)
        }
    }
}
