//
//  UILabelExtension.swift
//  FRGame01_S
//
//  Created by 강상우 on 14/03/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    @IBAction func action_ChangeText(_ sender: UISlider) {
        self.text = String(sender.value)
    }
}
