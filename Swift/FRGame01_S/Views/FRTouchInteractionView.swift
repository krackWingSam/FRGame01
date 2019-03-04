//
//  FRTouchInteractionView.swift
//  FRGame01_S
//
//  Created by 강상우 on 26/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRTouchInteractionView: UIView {
    
    var dimensionX      : UInt      = 0
    var dimensionY      : UInt      = 0
    var cellWidth       : CGFloat   = 0
    var cellHeight      : CGFloat   = 0
    
    var touchLinePath   : UIBezierPath!
    

    func initInterfaceParam() {
        dimensionX = FRPreference.shared.axisX
        dimensionY = FRPreference.shared.axisY
        
        cellWidth = FRPreference.shared.cellWidth
        cellHeight = FRPreference.shared.cellHeight
    }
    
    
    // MARK: - Override UIView
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isMultipleTouchEnabled = false
        self.initInterfaceParam()
        touchLinePath = UIBezierPath()
    }
    
    
    // MARK: - Draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawTouchs()
        if FRPreference.shared.isDebug {
            self.drawGrid()
        }
    }
    
    private func drawTouchs() {
        touchLinePath.removeAllPoints()
        touchLinePath.stroke()
        
        let touches = FRTouchManager.shared.array_Touches
        guard FRTouchManager.shared.currentTouch != nil else {
            return
        }
        
        if touches.count != 0 {
            touchLinePath.lineWidth = 5.0
            UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.5).set()
            
            let startTouch = touches[0]
            touchLinePath.move(to: CGPoint(x: startTouch.x.floatValue * cellWidth + cellWidth/2, y: startTouch.y.floatValue * cellHeight + cellHeight/2))
            
            for i in 1..<touches.count {
                let targetTouch = touches[i]
                touchLinePath.addLine(to: CGPoint(x: targetTouch.x.floatValue * cellWidth + cellWidth/2, y: targetTouch.y.floatValue * cellHeight + cellHeight/2))
            }
            
//            touchLinePath.addLine(to: CGPoint(x: lastTouch.position.x, y: lastTouch.position.y))
            touchLinePath.stroke()
        }
    }
    
    private func drawGrid() {
        UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).set()
        var path: UIBezierPath = UIBezierPath()
        path.lineWidth = 1.0
        
        //draw x-axis
        for i in 0..<dimensionY+1 {
            path.move(to: CGPoint(x: 0, y: cellHeight * CGFloat(i)))
            path.addLine(to: CGPoint(x: self.frame.size.width, y: cellHeight * CGFloat(i)))
        }
        
        //draw y-axis
        for i in 0..<dimensionX+1 {
            path.move(to: CGPoint(x: cellWidth * CGFloat(i), y: 0))
            path.addLine(to: CGPoint(x: cellWidth * CGFloat(i), y: self.frame.size.width))
        }
        path.stroke()
        
        //switch path for switch color
        path = UIBezierPath()
        UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5).set()
        //draw square
        for x in 0..<dimensionX {
            for y in 0..<dimensionY {
                let startPointX: CGFloat = cellWidth * CGFloat(x)
                let startPointY: CGFloat = (cellHeight * CGFloat(y)) + cellHeight/2
                var movePointX : CGFloat = (cellWidth * CGFloat(x)) + cellWidth/2
                var movePointY : CGFloat = cellHeight * CGFloat(y)
                
                path.move(to: CGPoint(x: startPointX, y: startPointY))
                path.addLine(to: CGPoint(x: movePointX, y: movePointY))
                
                movePointX = cellWidth * CGFloat(x + 1)
                movePointY = cellHeight * CGFloat(y) + cellHeight / 2
                
                path.addLine(to: CGPoint(x: movePointX, y: movePointY))
                
                movePointX = cellWidth * CGFloat(x) + cellWidth / 2
                movePointY = cellHeight * CGFloat(y + 1)
                
                path.addLine(to: CGPoint(x: movePointX, y: movePointY))
                
                movePointX = cellWidth * CGFloat(x)
                movePointY = cellHeight * CGFloat(y) + cellHeight / 2
                
                path.addLine(to: CGPoint(x: movePointX, y: movePointY))
            }
        }
        
        path.stroke()
    }
    
    
    // TODO: - have to find some bugs when fast movement touches, touchesended not work.
    // MARK: - Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let dimension: CGPoint = CGPoint(x: CGFloat(dimensionX), y: CGFloat(dimensionY))
        var location : CGPoint! = (touches.first?.location(in: self))!
        let firstTouch: FRTouch = FRTouch.getTouch(dimension: dimension, viewSize: self.frame.size, location: &location)
        
        if firstTouch.x >= 0 {
            FRTouchManager.shared.setFirstTouch(touch: firstTouch)
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        let dimension: CGPoint = CGPoint(x: CGFloat(dimensionX), y: CGFloat(dimensionY))
        var location : CGPoint! = (touches.first?.location(in: self))!
        let nextTouch = FRTouch.getTouch(dimension: dimension, viewSize: self.frame.size, location: &location)
        
        if nextTouch.x >= 0 {
            _ = FRTouchManager.shared.addNextTouch(touch: nextTouch)
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let dimension: CGPoint = CGPoint(x: CGFloat(dimensionX), y: CGFloat(dimensionY))
        var location : CGPoint! = (touches.first?.location(in: self))!
        let lastTouch = FRTouch.getTouch(dimension: dimension, viewSize: self.frame.size, location: &location)
        
        if lastTouch.x >= 0 {
            _ = FRTouchManager.shared.setLastTouch(touch: lastTouch)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        FRTouchManager.shared.clearTouchArray()
        self.setNeedsDisplay()
    }
    
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        super.touchesEstimatedPropertiesUpdated(touches)
        
        print()
    }
}
