//
//  FRImageViewManager.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import UIKit

class FRImageViewManager: NSObject {
    
    /// Singleton object
    static let shared: FRImageViewManager = FRImageViewManager()
    
    /// allocated image view array
    var array_ImageView: Array<UIImageView> = []
    
    /// make new image view
    func makeImageView() -> UIImageView {
        let width = FRPreference.shared.cellWidth
        let height = FRPreference.shared.cellHeight
        return UIImageView(frame: CGRect(x: -width, y: -height, width: width, height: height))
    }
    
    /**
     이미지 뷰의 요청
     - Returns:
        - 배열내에 있는 이미지 뷰중 보드에 더해지지 않은 이미지뷰를 하나 선택하여 리턴한다.
        - 배열에 사용가능한 이미지 뷰가 없는 경우에는 새로 만들어 리턴한다.
     */
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
