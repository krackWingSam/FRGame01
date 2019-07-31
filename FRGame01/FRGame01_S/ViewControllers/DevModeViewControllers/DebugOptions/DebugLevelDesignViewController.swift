//
//  DebugLevelDesignViewController.swift
//  FRGame01_S
//
//  Created by Fermata 강상우 on 01/05/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit
import FRBinder

class DebugLevelDesignViewController: UIViewController, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FRLevelDesign.shared.gravityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "level_design") as? LevelDesignTableViewCell else { return UITableViewCell() }
        cell.title = String(format: "Tile Gravity : %d", indexPath.row)
        cell.property = FRLevelDesign.shared.gravityArray[indexPath.row]
        return cell
    }
    
}


class LevelDesignTableViewCell: UITableViewCell {
    @IBOutlet weak var label_Title: UILabel!
    @IBOutlet weak var slider_Value: UISlider!
    @IBOutlet weak var label_Value: UILabel!
    
    var property: FRProperty<Int>? {
        didSet {
            // bind. after
            property?.bind(userInterface: slider_Value, propertyToInterface: { (property, slider) in
                slider?.value = Float(property.value)
            }, interfaceToProperty: { (property, slider) in
                property.value = Int(slider!.value)
            })
            
            property?.bind(userInterface: label_Value, propertyToInterface: { (property, label) in
                label?.text = String(property.value)
            }, interfaceToProperty: { (property, label) in })
            
            
            // release
            guard let oldValue = oldValue else { return }
            oldValue.release(userInterface: slider_Value)
            oldValue.release(userInterface: label_Value)
        }
    }
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            label_Title.text = title
        }
    }
}
