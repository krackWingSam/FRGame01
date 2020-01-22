//
//  FRAnimation.swift
//  FRGame01_S
//
//  Created by 상우강 on 2020/01/22.
//  Copyright © 2020 강상우. All rights reserved.
//

import UIKit

class FRAnimation: NSObject {
    private var images: [CGImage]   = []
    private var delays: [Int]       = []
    private var repeatCount: Int    = 1
    private var observer: NSKeyValueObservation?
    var duration: TimeInterval {
        get {
            var sum = 0
            for val: Int in delays { sum += val }
            return TimeInterval(sum) / 1000
        }
    }
    var animationImages: [CGImage] {
        get { return images }
    }
    
    var targetView: UIView?
    
    init(_ name: String) {
        super.init()
        
        guard let dataAsset = NSDataAsset.init(name: name) else {
            print("SwiftGif: This image named \"\(name)\" does not exist")
            return
        }
        
        guard let source = CGImageSourceCreateWithData(dataAsset.data as CFData, nil) else {
            print("image doesn't exist")
            return
        }
        
        let count = CGImageSourceGetCount(source)
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = delayForImageAtIndex(Int(i),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
    }
    
    // MARK: - Private Functions
    private func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        return delay
    }
    
    
    // MARK: - Public Functions
    func startAnimation() {
        guard let targetView = targetView else { return }
        let animation = CAKeyframeAnimation()
        animation.keyPath = "contents"
        animation.values = images
        animation.repeatCount = Float(repeatCount)
        animation.duration = CFTimeInterval(duration)
        animation.delegate = self
        targetView.layer.add(animation, forKey: nil)
    }
}


extension FRAnimation: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation end")
    }
}
