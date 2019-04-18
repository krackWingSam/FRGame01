//
//  FRTouchManager.swift
//  FRGame01_S
//
//  Created by 강상우 on 26/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRTouchManager: NSObject {
    
    /// Singleton object
    static let shared: FRTouchManager = FRTouchManager()
    
    /// 입력된 유효한 터치 오브젝트의 배열
    var array_Touches: Array<FRTouch> = []
    
    /// 마지막으로 입력된 터치 오브젝트
    var currentTouch: FRTouch!
    
    
    /**
     - 입력된 터치 오브젝트의 위치가 기 입력된 터치 오브젝트의 위치와 겹치는지 확인
     - Parameters:
        - touch: 입력된 터치 오브젝트
     - Returns: 겹치는 위치에 있는 터치라면 false를, 겹치지 않는다면 true를 리턴한다. 공격 타일과 적 타일은 동시에 선택이 가능해야 한다
     */
    private func checkSameTile(touch: FRTouch) -> Bool {
        let axisY = FRPreference.shared.axisY
        
        let firstTouch = array_Touches.first
        let x = firstTouch?.x
        let y = axisY.intValue-1 - (firstTouch?.y)!
        let tile = FRTileManager.shared.tileMap[x!][y]
        
        let currentX = touch.x
        let currentY = axisY.intValue-1 - touch.y
        let currentTile = FRTileManager.shared.tileMap[currentX][currentY]
        
        if (tile.type == .FRType_Sword || tile.type == .FRType_Enemy) && (currentTile.type == .FRType_Sword || currentTile.type == .FRType_Enemy) {
            return true
        }
        
        if tile.type.rawValue != currentTile.type.rawValue {
            return false
        }
        
        return true
    }
    
    
    /**
     - 입력된 터치 오브젝트의 유효성 검사
     - Parameters:
        - touch: 입력된 터치 오브젝트
     - Returns: 터치 오브젝트가 유효하다면 true를, 유효하지 않다면 false를 리턴
     */
    private func checkValidTouch(touch: FRTouch) -> Bool {
        if array_Touches.count <= 0 {
            return true
        }
        
        if touch.x < 0 || touch.y < 0 {
            return false
        }
        
        let lastTouch: FRTouch = array_Touches.last!
        if abs(Int(lastTouch.x) - Int(touch.x)) > 1 {
            return false
        }
        if abs(Int(lastTouch.y) - Int(touch.y)) > 1 {
            return false
        }
        
        //check smae position with old object
        for oldTouch: FRTouch in array_Touches {
            if oldTouch.isEqual(touch: touch) {
                return false
            }
        }
        
        //check same tile with first touch
        if !checkSameTile(touch: touch) {
            return false
        }
        
        
        return true
    }
    
    
    /**
     - 삭제가 가능한 터치 오브젝트인지 확인한다
     - Parameters:
        - touch: 입력된 터치 오브젝트
     - Returns: 입력된 터치 오브젝트가 삭제 가능한 경우에는 true를, 삭제하지 못하는 경우에는 false를 리턴한다.
     */
    private func checkRemovableTouch(touch: FRTouch) -> Bool {
        if array_Touches.count < 2 {
            return false
        }
        
        let previousTouch = array_Touches[array_Touches.count-2]
        if previousTouch.isEqual(touch: touch) {
            return true
        }
        
        return false;
    }
    
    
    /**
     터치 오브젝트가 FRInteractionView 내부에서 터치된 오브젝트인지 아닌지를 결정
     - Parameters:
        - touch: 입력된 터치 오브젝트
     - Returns: FRInteractionView 내부에서 터치된 경우라면 true를, 아니라면 false를 반환
     */
    private func checkInsideOfInteractionView(touch: FRTouch) -> Bool {
        if touch.x < 0 || touch.y < 0 {
            return false
        }
        
        if touch.x > FRPreference.shared.axisX || touch.y > FRPreference.shared.axisY {
            return false
        }
        
        return true
    }
    
    
    /**
     터치 오브젝트가 마지막으로 터치된 타일 위에 있는지 확인한다
     
     - Parameters:
        - touch: FRTouch object
     
     - Returns: 마지막으로 터치 된 타일 위에 좌표와 입력된 터치 오브젝트의 좌표가 동일하다면 true를, 아니라면 false를 반환
     */
    private func checkLastTouch(touch: FRTouch) -> Bool {
        guard let lastTouch = array_Touches.last else {
            return false
        }
        
        if touch.isEqual(touch:lastTouch) {
            return true
        }
        
        return false
    }
    
    
    // MARK: - Public
    
    /**
     - 첫번째 터치 오브젝트를 삽입한다.
     - 입력된 터치 오브젝트가 유효한 좌표인 경우에는 삽입을, 아닌 경우에는 삽입하지 않는다.
     - Parameters:
        - touch: 입력될 터치 오브젝트
     */
    func setFirstTouch(touch: FRTouch) {
        array_Touches.removeAll()
        
        if touch.x == -1 || touch.y == -1 {
            return
        }
        
//        if FRPreference.shared.isDebug {
//            print("set first touch add : " + touch.description)
//        }
        
        array_Touches.append(touch)
    }
    
    
    /**
     터치 오브젝트를 배열에 조건에 따라서 더하거나, 뺀다.
     - 직전에 배열에 추가된 오브젝트와 같은 타일 위치를 갖고 있다면 배열에서 마지막 터치 오브젝트를 제거하고, 서로 다르다면 배열에 추가한다.
     - 배열에 들어갈 오브젝트는 처음에 입력된 터치 오브젝트의 위치에 있는 타일과 같은 타입이어야 한다
     
     - Parameters:
        - touch: 배열에 더하고자 하는 터치 오브젝트
     
     - Returns: 배열에 더하거나 뺄 수 있는 오브젝트인 경우에는 true를, 유효하지 않은 Touch의 경우에는 false를 리턴한다.
     */
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
        
        return true
    }
    
    
    /**
     set last touch object
     - 마지막으로 터치된 위치에 따라서 해당 배열에 저장된 터치 오브젝트의 사용 유무를 결정 후 리턴
     - 처음부터 끝까지의 터치 오브젝트 배열의 사용 유무를 리턴
     
     - Parameters:
        - touch: 마지막 터치 오브젝트 (FRTouch)
     
     - Returns: 마지막 터치로 사용 가능한 오브젝트인 경우에는 true를, 불가능한 오브젝트인 경우에는 false를 리턴한다.
     */
    func setLastTouch(touch: FRTouch) -> Bool {
        if checkValidTouch(touch: touch) {
            array_Touches.append(touch)
        }
        
        if FRPreference.shared.isDebug {
            print("add ended : " + touch.description)
        }
        
//        마지막 터치 부분이 배열의 가장 마지막과 같은지 확인
//        if checkLastTouch(touch: touch) {       //check valid touch
            // make tile array for remove
        if array_Touches.count > 1 {
            var removeTiles : [FRTile] = []
            for touch in array_Touches {
                let dimensionY = Int(FRPreference.shared.axisY - 1)
                let tile = FRTileManager.shared.tileMap[touch.x][dimensionY - touch.y]
                removeTiles.append(tile)
            }
            
            Score.shared.turn.value += 1
            
            // remove tiles using tile manager
            FRTileManager.shared.removeTile(tiles: removeTiles)
            array_Touches.removeAll()
            return true
        }
        else {
            array_Touches.removeAll()

            if FRPreference.shared.isDebug {
                print("last touch failed")
            }

            return false
        }
    }
    
    /// 배열을 초기화 한다.
    func clearTouchArray() {
        array_Touches.removeAll()
    }
}
