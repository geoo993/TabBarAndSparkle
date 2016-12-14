//
//  Extensions.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 26/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit


extension CGFloat {
    
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        
        let rand = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
        let minimum = min < max ? min : max 
        return  rand * abs(min - max) + minimum
    }
}

extension UIColor {
    
    public static func randomColor() -> UIColor {
        
        return UIColor.init(red: CGFloat.random(min: 0.0, max: 1.0), green: CGFloat.random(min: 0.0,max: 1.0), blue: CGFloat.random(min: 0.0,max: 1.0), alpha: 1)
    }
}

extension UIButton {
    
    func alignImageAndTitleVertically(padding: CGFloat = 25.0) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -5,//-(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -20,//imageSize.width ,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
    
}
