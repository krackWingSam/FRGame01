//
//  NSObjectExtension.swift
//  FRGame01_S
//
//  Created by 강상우 on 27/02/2019.
//  Copyright © 2019 강상우. All rights reserved.
//

import Foundation

extension NSObject {
    func propertyDic() -> [String: Any] {
        let keys = Mirror(reflecting: self).children.compactMap { $0.label }
        let values = Mirror(reflecting: self).children.compactMap { $0.value }
        
        var dictionary: [String: AnyObject] = [:]
        for (index, key) in keys.enumerated() {
            dictionary[key] = values[index] as AnyObject
        }
        
        return dictionary
    }
}
