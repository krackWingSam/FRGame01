//
//  FRUserInfo.swift
//  FRGame01_S
//
//  Created by Fermata 강상우 on 22/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import FRBinder

class FRUserInfo: FRModel {
    static let shared = FRUserInfo()
    
    let lifeFull    = FRProperty(Int.self)
    let life        = FRProperty(Int.self)      // Life Point
    
    let Shield      = FRProperty(Int.self)
    let ShieldFull  = FRProperty(Int.self)      // Shield Point
    
    let AP          = FRProperty(Int.self)      // Atack Point
    let WP          = FRProperty(Int.self)      // Weapon Point
    
    let coin        = FRProperty(Int.self)      // Coin
    
    
    override init() {
        super.init()
        
        clear()
    }
    
    func clear() {
        lifeFull.value = 30
        life.value = 30
        AP.value = 1
        WP.value = 1
        ShieldFull.value = 30
        Shield.value = 10
        coin.value = 0
    }
    
    private func minusDamage() {
        if Shield.value == 0 {
            life.value -= 1
        }
        else {
            Shield.value -= 1
        }
    }
    
    func calcDamage(_ damage: Int) {
        for _ in 0..<damage {
            minusDamage()
        }
    }
    
    private func recoveryShield() {
        if Shield.value < ShieldFull.value {
            Shield.value += 1
        }
    }
    
    func recoveryShield(_ point: Int) {
        for _ in 0..<point {
            recoveryShield()
        }
    }
    
    private func recoveryLife() {
        if life.value < lifeFull.value {
            life.value += 1
        }
    }
    
    func recoveryLife(_ point: Int) {
        for _ in 0..<point {
            recoveryLife()
        }
    }
    
    func addCoin(_ point: Int) {
        coin.value += point
    }
}
