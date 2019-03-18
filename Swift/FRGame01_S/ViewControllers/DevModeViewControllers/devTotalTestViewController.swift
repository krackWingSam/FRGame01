//
//  devTotalTestViewController.swift
//  FRGame01_S
//
//  Created by 강상우 on 28/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class devTotalTestViewController: UIViewController {
    
    @IBOutlet weak var viewBoard        : FRBoardView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Actions
    @IBAction func action_Close(_ sender: UIButton) {
        dismiss(animated: true) {}
    }
    
    @IBAction func action_Reset(_ sender: UIButton) {
        viewBoard.initTileMap()
        viewBoard.addAllTile()
    }
    
    @IBAction func action_BreakPoint(_ sender: UIButton) {
        let tiles = FRTileManager.shared.tileMap
        for yArray in tiles {
            for tile in yArray {
                print("tile(\(tile.axisX), \(tile.axisY)) : " + tile.frame.debugDescription)
            }
        }
    }
}
