//
//  devFRTileViewController.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class devFRTileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tile = FRTile.init(type: FRTileType.FRType_Shield)
        tile.imageView.frame = CGRect(x: 30, y: 130, width: 50, height: 50)
        self.view.addSubview(tile.imageView)
        
        print(FRTileManager.shared.tileMap)
    }

}
