//
//  YALCustomHeightTabBar.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 25/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit

class YALCustomHeightTabBar: UITabBar {
    var _barHeight: CGFloat = 0.0

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = self.barHeight()
        return sizeThatFits
    }
    
    func barHeight() -> CGFloat {
        
        if _barHeight != 0.0 {
            return _barHeight
        }
        else {
            return YALTabBarViewDefaultHeight
        }
    }
}
