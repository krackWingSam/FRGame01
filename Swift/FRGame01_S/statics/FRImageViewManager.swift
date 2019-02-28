//
//  FRImageViewManager.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRImageViewManager: NSObject {
    
    static let shared: FRImageViewManager = FRImageViewManager()
    
    var array_ImageView: Array<UIImageView> = []
    
    func makeImageView() -> UIImageView {
        let width = FRPreference.shared.cellWidth
        let height = FRPreference.shared.cellHeight
        return UIImageView(frame: CGRect(x: -width, y: -height, width: width, height: height))
    }
    
    func getImageView() -> UIImageView {
        var imageView: UIImageView?
        
        for view in array_ImageView {
            let rc = CFGetRetainCount(view)
            if rc < 4 {
                imageView = view
                break
            }
        }
        
        if imageView == nil {
            imageView = makeImageView()
            array_ImageView.append(imageView!)
        }
        
        return imageView!
    }
}
