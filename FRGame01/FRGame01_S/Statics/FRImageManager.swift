//
//  FRImageManager.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

public enum TileImageKey: String, CaseIterable {
    case ImageKey_1 = "t_sword"
    case ImageKey_2 = "t_skull"
    case ImageKey_3 = "t_3"
    case ImageKey_4 = "t_4"
    case ImageKey_5 = "t_5"
    case ImageKey_6 = "t_6"
    case ImageKey_7 = "t_7"
}

class FRImageManager: NSObject {
    
    static var shared = FRImageManager()
    
    var dic_Keys    : [FRTileType: String] = [:]
    var dic_Images  : [String: UIImage] = [:]
    
    override init() {
        super.init()
        
        self.initKeyDictionary()
        self.initImages()
    }
    
    func initKeyDictionary() {
        let arrayIndex = FRTileType.allCases
        let arrayKeys = TileImageKey.allCases
        
        if arrayIndex.count != arrayKeys.count {
            print("index and key wasn't match. plz check enums")
        }
        
        for (index, key) in arrayIndex.enumerated() {
            dic_Keys.updateValue(arrayKeys[index].rawValue, forKey: key)
        }
    }
    
    func initImages() {
        for key in dic_Keys.keys {
            let name: String = dic_Keys[key]!
            let path = Bundle.main.path(forResource: name, ofType: "png")
            guard let image = UIImage(contentsOfFile: path!) else {
                print("Error!! " + name + " are not exist file name.")
                continue
            }
            dic_Images.updateValue(image, forKey: name)
        }
    }
    
    func getImage(type: FRTileType) -> UIImage {
        let key = dic_Keys[type]!
        guard let image = dic_Images[key] else {
            if FRPreference.shared.isDebug {
                print(key + ".png does not exist.")
            }
            return UIImage()
        }
        return image
    }
}
