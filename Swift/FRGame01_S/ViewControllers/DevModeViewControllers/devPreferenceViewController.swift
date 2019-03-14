//
//  devPreferenceViewController.swift
//  FRGame01_S
//
//  Created by 강상우 on 28/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class devPreferenceViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var text_AxisX: UITextField!
    @IBOutlet weak var text_AxisY: UITextField!
    @IBOutlet weak var switch_Debug: UISwitch!
    @IBOutlet weak var slider_AnimationDuration: UISlider!
    @IBOutlet weak var slider_AnimationDelay: UISlider!
    @IBOutlet weak var segment_TileCount: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: fill preference value
        let preference = FRPreference.shared
        text_AxisX.text = String(preference.axisX)
        text_AxisY.text = String(preference.axisY)
        
        switch_Debug.isOn = preference.isDebug
        
        slider_AnimationDuration.value = Float(preference.tileAnimationDuration)
        slider_AnimationDelay.value = Float(preference.tileAnimationDelay)
        
        segment_TileCount.selectedSegmentIndex = preference.tileRange - 2
    }
    

    // MARK: - IBActions
    @IBAction func action_Done(_ sender: UIButton) {
        dismiss(animated: true) {}
    }
    
    @IBAction func action_Slide(_ sender: UISlider) {
        if (sender === slider_AnimationDuration) {
            FRPreference.shared.tileAnimationDuration = CGFloat(sender.value)
        }
        else if (sender === slider_AnimationDelay) {
            FRPreference.shared.tileAnimationDelay = CGFloat(sender.value)
        }
    }
    
    @IBAction func action_TileCount(_ sender: UISegmentedControl) {
        FRPreference.shared.tileRange = sender.selectedSegmentIndex + 2
    }
    
    @IBAction func action_DebugSwitch(_ sender: UISwitch) {
        FRPreference.shared.isDebug = switch_Debug.isOn
    }
    
    @IBAction func action_BackgroundTouch(_ sender: Any) {
        text_AxisX.resignFirstResponder()
        text_AxisY.resignFirstResponder()
    }

    
    //MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let value: Int = Int(textField.text!)!
        textField.text = String(value)
        
        if textField === text_AxisX {
            FRPreference.shared.axisX = UInt(value)
        }
        else if textField === text_AxisY {
            FRPreference.shared.axisY = UInt(value)
        }
    }
}
