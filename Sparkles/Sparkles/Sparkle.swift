//
//  Sparkle.swift
//  Twinkle
//
//  Created by GEORGE QUENTIN on 23/11/2016.
//  Copyright © 2016 patrickpiemonte. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Foundation
import CoreGraphics


private let SparkleLayerEmitterShapeKey = "circle"
private let SparkleLayerEmitterModeKey = "surface"
private let SparkleLayerRenderModeKey = "unordered"
private let SparkleLayerMagnificationFilter = "linear"
private let SparkleLayerMinificationFilter = "trilinear"

private let SparkleLayerPositionAnimationKey = "positionAnimation"
private let SparkleLayerTransformAnimationKey = "transformAnimation"
private let SparkleLayerOpacityAnimationKey = "opacityAnimation"


class SparkleLayer: CAEmitterLayer {

    override init() {
        super.init()
        
        var sparkleImage :UIImage?
        
        let frameworkBundle = Bundle(for: self.classForCoder)
        if let imagePath = frameworkBundle.path(forResource: "TwinkleImage", ofType: "png")
        {
            sparkleImage = UIImage(contentsOfFile: imagePath)
        }
        
        let emitterCells: [CAEmitterCell] = [CAEmitterCell(), CAEmitterCell()]
        for cell in emitterCells {
            cell.birthRate = 8
            cell.lifetime = 1.25
            cell.lifetimeRange = 0
            cell.emissionRange = CGFloat(M_PI_4)
            cell.velocity = 2
            cell.velocityRange = 18
            cell.scale = 0.65
            cell.scaleRange = 0.7
            cell.scaleSpeed = 0.6
            cell.spin = 0.9
            cell.spinRange = CGFloat(M_PI)
            cell.color = UIColor(white: 1.0, alpha: 0.3).cgColor
            cell.alphaSpeed = -0.8
            cell.contents = sparkleImage?.cgImage
            cell.magnificationFilter = SparkleLayerMagnificationFilter
            cell.minificationFilter = SparkleLayerMinificationFilter
            cell.isEnabled = true
        }
        
        self.emitterCells = emitterCells
        self.emitterPosition = CGPoint(x: (bounds.size.width * 0.5), y: (bounds.size.height * 0.5))
        self.emitterSize = bounds.size
        
        self.emitterShape = SparkleLayerEmitterShapeKey
        self.emitterMode = SparkleLayerEmitterModeKey
        self.renderMode = SparkleLayerRenderModeKey
    }
    
    /*override*/ required init(lay layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension CGPoint {
    
    func twinkleRandom(_ range: Float)->CGPoint {
        let x = Int(-range + (Float(arc4random_uniform(1000)) / 1000.0) * 2.0 * range)
        let y = Int(-range + (Float(arc4random_uniform(1000)) / 1000.0) * 2.0 * range)
        return CGPoint(x: x, y: y)
    }
    
}


extension CAEmitterLayer { //SparkleLayer {
    
    func layerEmit(img: UIImage) -> CAEmitterLayer
    {
        
        
        let emitterCells: [CAEmitterCell] = [CAEmitterCell(), CAEmitterCell()]
        for cell in emitterCells {
            cell.birthRate = 8
            cell.lifetime = 1.25
            cell.lifetimeRange = 0
            cell.emissionRange = CGFloat(M_PI_4)
            cell.velocity = 2
            cell.velocityRange = 18
            cell.scale = 0.65
            cell.scaleRange = 0.7
            cell.scaleSpeed = 0.6
            cell.spin = 0.9
            cell.spinRange = CGFloat(M_PI)
            cell.color = UIColor(white: 1.0, alpha: 0.3).cgColor
            cell.alphaSpeed = -0.8
            cell.contents = img.cgImage
            cell.magnificationFilter = SparkleLayerMagnificationFilter
            cell.minificationFilter = SparkleLayerMinificationFilter
            cell.isEnabled = true
        }
        
        self.emitterCells = emitterCells
        self.emitterPosition = CGPoint(x: (bounds.size.width * 0.5), y: (bounds.size.height * 0.5))
        self.emitterSize = bounds.size
        
        self.emitterShape = SparkleLayerEmitterShapeKey
        self.emitterMode = SparkleLayerEmitterModeKey
        self.renderMode = SparkleLayerRenderModeKey
        
        return self
    }
    
    
    
    func addPositionAnimation() {
        CATransaction.begin()
        
        let keyFrameAnim = CAKeyframeAnimation(keyPath: "position")
        keyFrameAnim.duration = 0.3
        keyFrameAnim.isAdditive = true
        keyFrameAnim.repeatCount = MAXFLOAT
        keyFrameAnim.isRemovedOnCompletion = false
        keyFrameAnim.beginTime = CFTimeInterval(arc4random_uniform(1000) + 1) * 0.2 * 0.25 // random start time, non-zero
        let points: [NSValue] = [NSValue(cgPoint: CGPoint().twinkleRandom(0.25)),
                                 NSValue(cgPoint: CGPoint().twinkleRandom(0.25)),
                                 NSValue(cgPoint: CGPoint().twinkleRandom(0.25)),
                                 NSValue(cgPoint: CGPoint().twinkleRandom(0.25)),
                                 NSValue(cgPoint: CGPoint().twinkleRandom(0.25))]
        keyFrameAnim.values = points
        self.add(keyFrameAnim, forKey: SparkleLayerPositionAnimationKey)
        CATransaction.commit()
        
    }
    
    func addRotationAnimation() {
        CATransaction.begin()
        let keyFrameAnim = CAKeyframeAnimation(keyPath: "transform")
        keyFrameAnim.duration = 0.3
        keyFrameAnim.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
        keyFrameAnim.isAdditive = true
        keyFrameAnim.repeatCount = MAXFLOAT
        keyFrameAnim.isRemovedOnCompletion = false
        keyFrameAnim.beginTime = CFTimeInterval(arc4random_uniform(1000) + 1) * 0.2 * 0.25 // random start time, non-zero
        let radians: Float = 0.104 // ~6 degrees
        keyFrameAnim.values = [-radians, radians, -radians]
        self.add(keyFrameAnim, forKey: SparkleLayerTransformAnimationKey)
        CATransaction.commit()
       
        
    }
    
    func addFadeInOutAnimation(_ beginTime: CFTimeInterval) {
        CATransaction.begin()
        
        let fadeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        fadeAnimation.fromValue = 0
        fadeAnimation.toValue = 1
        fadeAnimation.repeatCount = 10
        fadeAnimation.autoreverses = true // fade in then out
        fadeAnimation.duration = 0.4
        fadeAnimation.fillMode = kCAFillModeForwards
        fadeAnimation.beginTime = beginTime
        
        CATransaction.setCompletionBlock({
            self.removeFromSuperlayer()
            
        })
        self.add(fadeAnimation, forKey: SparkleLayerOpacityAnimationKey)
        
        CATransaction.commit()
        
    }
    
}

extension UIView {
    
    public func sparkle()
    {
        var sparkleLayers: [SparkleLayer]! = []
        
        
        let upperBound: UInt32 = 20
        let lowerBound: UInt32 = 10
        let count: UInt = UInt(arc4random_uniform(upperBound) + lowerBound)
        
        
        for i in 0..<count {
            let sparkleLayer: SparkleLayer = SparkleLayer()
            let x: Int = Int(arc4random_uniform(UInt32(self.layer.bounds.size.width)))
            let y: Int = Int(arc4random_uniform(UInt32(self.layer.bounds.size.height)))
            sparkleLayer.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
            sparkleLayer.opacity = 0
            sparkleLayers.append(sparkleLayer)
            self.layer.addSublayer(sparkleLayer)
            
            sparkleLayer.addPositionAnimation()
            sparkleLayer.addRotationAnimation()
            sparkleLayer.addFadeInOutAnimation( CACurrentMediaTime() + CFTimeInterval(0.15 * Float(i)) )
            
        }
        
        sparkleLayers.removeAll(keepingCapacity: false)
       // print(sparkleLayers.count)
    
    }

    public func shakeView(){
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.isHidden = true
        })
        
        let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 21
        shake.autoreverses = true
        
        let from_point:CGPoint = CGPoint(x: self.center.x - 5, y: self.center.y)
        let from_value:NSValue = NSValue(cgPoint: from_point)
        
        let to_point:CGPoint = CGPoint(x: self.center.x + 5, y: self.center.y)
        let to_value:NSValue = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        self.layer.add(shake, forKey: "position")
        CATransaction.commit()
    }
    
}
