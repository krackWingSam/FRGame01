//
//  FRAnimationBlock.swift
//  FRGame01_S
//
//  Created by exs-mobile 강상우 on 23/04/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import Foundation
import UIKit

enum FRAnimationFlag: Double {
    case AnimationFlag_Atack = 1.0
}

struct FRAnimationBlock {
    typealias FRAnimation = () -> Void
    
    var animation: FRAnimation?
    var animationFlag: FRAnimationFlag
    
    func doAnimation() {
        guard let animation = self.animation else { return }
        animation()
    }
}
