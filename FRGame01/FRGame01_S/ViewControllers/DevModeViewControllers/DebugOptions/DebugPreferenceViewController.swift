//
//  DebugPreferenceViewController.swift
//  FRGame01_S
//
//  Created by Fermata 강상우 on 01/05/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class DebugPreferenceViewController: UIViewController {
    
    @IBOutlet weak var switch_Debug: UISwitch!
    @IBOutlet weak var tf_XAxis: UITextField!
    @IBOutlet weak var tf_YAxis: UITextField!
    @IBOutlet weak var sc_CategoryCount: UISegmentedControl!
    
    let preference = FRPreference.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bindAll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        releaseAll()
    }
    
    
    // MARK: - Bind
    func bindAll() {
        preference.axisX.bind(userInterface: tf_XAxis, propertyToInterface: { (property, tf) in
            tf.text = String(property.value)
        }) { (property, tf) in
            property.value = Int(tf.text!)
        }
        
        preference.axisY.bind(userInterface: tf_YAxis, propertyToInterface: { (property, tf) in
            tf.text = String(property.value)
        }) { (property, tf) in
            property.value = Int(tf.text!)
        }
        
        preference.isDebug.bind(userInterface: switch_Debug, propertyToInterface: { (property, switch_Debug) in
            switch_Debug?.isOn = property.value
        }) { (property, switch_Debug) in
            property.value = switch_Debug?.isOn
        }
        
        preference.tileRange.bind(userInterface: sc_CategoryCount, propertyToInterface: { (property, sc) in
            sc?.selectedSegmentIndex = property.value - 2
        }) { (property, sc) in
            property.value = sc!.selectedSegmentIndex + 2
        }
    }
    
    func releaseAll() {
        preference.axisX.release(userInterface: tf_XAxis)
        preference.axisY.release(userInterface: tf_YAxis)
        preference.isDebug.release(userInterface: switch_Debug)
        preference.tileRange.release(userInterface: sc_CategoryCount)
    }
    
    
    // MARK: - IBActions
    @IBAction func action_BackgroundTouch(_ sender: Any) {
        tf_XAxis.resignFirstResponder()
        tf_YAxis.resignFirstResponder()
    }
}
