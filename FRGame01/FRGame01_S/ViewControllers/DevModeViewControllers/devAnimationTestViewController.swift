//
//  devAnimationTestViewController.swift
//  FRGame01_S
//
//  Created by 상우강 on 2020/01/22.
//  Copyright © 2020 강상우. All rights reserved.
//

import UIKit

class devAnimationTestViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    let testImage01 = FRAnimation("gif_01")
    let testImage02 = FRAnimation("gif_02")
    let testImage03 = FRAnimation("gif_03")
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func action_AddAnimation(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        let tag = button.tag
        switch tag {
        case 0:
            testImage01.targetView = imageView
            testImage01.startAnimation()
            break
        case 1:
            testImage02.targetView = imageView
            testImage02.startAnimation()
            break
        case 2:
            testImage03.targetView = imageView
            testImage03.startAnimation()
            break
        default:
            break
        }
    }
    

}
