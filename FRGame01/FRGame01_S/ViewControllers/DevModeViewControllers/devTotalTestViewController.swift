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
    @IBOutlet weak var label_1          : UILabel!
    @IBOutlet weak var label_2          : UILabel!
    @IBOutlet weak var label_3          : UILabel!
    @IBOutlet weak var label_4          : UILabel!
    @IBOutlet weak var label_5          : UILabel!
    @IBOutlet weak var label_6          : UILabel!
    @IBOutlet weak var label_7          : UILabel!
    @IBOutlet weak var label_Turn       : UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        releaseUI()
    }
    

    // MARK: - Actions
    @IBAction func action_Close(_ sender: UIButton) {
        dismiss(animated: true) {}
    }
    
    @IBAction func action_Reset(_ sender: UIButton) {
        Score.shared.clearPoints()
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
    
    // MARK: - UI Bind
    func bindUI() {
        Score.shared.tile01.bind(userInterface: label_1, propertyToInterface: { (property, label) in
            label?.text = String(format: "%d", property.value)
        }) { (property, label) in }
        
        Score.shared.tile02.bind(userInterface: label_2, propertyToInterface: { (property, label) in
            label?.text = String(format: "%d", property.value)
        }) { (property, label) in }
        
        Score.shared.tile03.bind(userInterface: label_3, propertyToInterface: { (property, label) in
            label?.text = String(format: "%d", property.value)
        }) { (property, label) in }
        
        Score.shared.tile04.bind(userInterface: label_4, propertyToInterface: { (property, label) in
            label?.text = String(format: "%d", property.value)
        }) { (property, label) in }
        
        Score.shared.tile05.bind(userInterface: label_5, propertyToInterface: { (property, label) in
            label?.text = String(format: "%d", property.value)
        }) { (property, label) in }
        
        Score.shared.tile06.bind(userInterface: label_6, propertyToInterface: { (property, label) in
            label?.text = String(format: "%d", property.value)
        }) { (property, label) in }
        
        Score.shared.tile07.bind(userInterface: label_7, propertyToInterface: { (property, label) in
            label?.text = String(format: "%d", property.value)
        }) { (property, label) in }
        
        Score.shared.turn.bind(userInterface: label_Turn, propertyToInterface: { (property, label) in
            label?.text = String(format: "%d", property.value)
        }) { (property, label) in }
    }
    
    func releaseUI() {
        Score.shared.tile01.release(userInterface: label_1)
        Score.shared.tile02.release(userInterface: label_2)
        Score.shared.tile03.release(userInterface: label_3)
        Score.shared.tile04.release(userInterface: label_4)
        Score.shared.tile05.release(userInterface: label_5)
        Score.shared.tile06.release(userInterface: label_6)
        Score.shared.tile07.release(userInterface: label_7)
    }
}
