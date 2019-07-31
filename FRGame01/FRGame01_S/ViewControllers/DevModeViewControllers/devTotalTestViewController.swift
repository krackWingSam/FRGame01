//
//  devTotalTestViewController.swift
//  FRGame01_S
//
//  Created by 강상우 on 28/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import FRBinder

class devTotalTestViewController: UIViewController {
    
    @IBOutlet weak var viewBoard        : FRBoardView!
    @IBOutlet weak var label_LifeCurrent    : UILabel!
    @IBOutlet weak var label_LifeFull       : UILabel!
    @IBOutlet weak var label_ShieldCurrent  : UILabel!
    @IBOutlet weak var label_SheildFull     : UILabel!
    @IBOutlet weak var label_Coin           : UILabel!
    @IBOutlet weak var label_AP             : UILabel!
    @IBOutlet weak var label_WP             : UILabel!
    
    @IBOutlet weak var label_Turn           : UILabel!
    

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
    var UIBindClosure: (FRProperty<Int>, UILabel) -> Void = { (property: FRProperty<Int>, label: UILabel) -> Void in
        label.text = String(property.value)
    }
    
    var UIBindClosure_Empty:(FRProperty<Int>, UILabel) -> Void = { (property: FRProperty<Int>, label: UILabel) -> Void in }
    
    func bindUI() {
        FRUserInfo.shared.lifeFull.bind(userInterface: label_LifeFull, propertyToInterface: UIBindClosure, interfaceToProperty: UIBindClosure_Empty)
        FRUserInfo.shared.life.bind(userInterface: label_LifeCurrent, propertyToInterface: UIBindClosure, interfaceToProperty: UIBindClosure_Empty)
        
        FRUserInfo.shared.ShieldFull.bind(userInterface: label_SheildFull, propertyToInterface: UIBindClosure, interfaceToProperty: UIBindClosure_Empty)
        FRUserInfo.shared.Shield.bind(userInterface: label_ShieldCurrent, propertyToInterface: UIBindClosure, interfaceToProperty: UIBindClosure_Empty)
        
        FRUserInfo.shared.coin.bind(userInterface: label_Coin, propertyToInterface: UIBindClosure, interfaceToProperty: UIBindClosure_Empty)
        Score.shared.turn.bind(userInterface: label_Turn, propertyToInterface: UIBindClosure, interfaceToProperty: UIBindClosure_Empty)
        
        FRUserInfo.shared.AP.bind(userInterface: label_AP, propertyToInterface: UIBindClosure, interfaceToProperty: UIBindClosure_Empty)
        FRUserInfo.shared.WP.bind(userInterface: label_WP, propertyToInterface: UIBindClosure, interfaceToProperty: UIBindClosure_Empty)
    }
    
    func releaseUI() {
        FRUserInfo.shared.lifeFull.release(userInterface: label_LifeFull)
        FRUserInfo.shared.life.release(userInterface: label_LifeCurrent)
        FRUserInfo.shared.ShieldFull.release(userInterface: label_SheildFull)
        FRUserInfo.shared.Shield.release(userInterface: label_ShieldCurrent)
        
        FRUserInfo.shared.coin.release(userInterface: label_Coin)
        Score.shared.turn.release(userInterface: label_Turn)
        FRUserInfo.shared.AP.release(userInterface: label_AP)
        FRUserInfo.shared.WP.release(userInterface: label_WP)
    }
}
