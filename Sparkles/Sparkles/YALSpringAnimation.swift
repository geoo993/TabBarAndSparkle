//
//  YALSpringAnimation.swift
//  Example-Swift
//
//  Created by GEORGE QUENTIN on 24/11/2016.
//  Copyright © 2016 Yalantis. All rights reserved.
//


//  Converted with Swiftify v1.0.6171 - https://objectivec2swift.com/
import UIKit
import QuartzCore

//class YALSpringAnimation: CAKeyframeAnimation {
//    convenience init(keyPath: String, duration: CFTimeInterval, damping: Double, velocity: Double, fromValue: Double, toValue: Double) {
//    }
//    
//    convenience init(duration: CFTimeInterval, damping: Double, velocity: Double, fromValue: CGRect, toValue: CGRect) {
//    }
//}



let kNumberOfPoints = 50

let kDampingMutiplier: Double = 10

let kVelocityMutiplier: Double = 10

var yal_normalizeAnimationValue: Double = 0.0


class YALSpringAnimation: CAKeyframeAnimation {
    
//    override init() {
//        super.init()
//        
//        self.keyPath = ""
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    

    convenience init?(keyPath path: String?){
        
        return nil
    }
    
    
    init(keyPath: String, duration: CFTimeInterval, damping: Double, velocity: Double, fromValue: Double, toValue: Double) 
    {
        super.init()
        self.keyPath =  keyPath
        self.isRemovedOnCompletion = false
        self.fillMode = kCAFillModeForwards
        self.duration = duration
        self.values = self.animationValues(fromValue: fromValue, toValue: toValue, withDamping: damping, andVelocity: velocity)
        
    }
    
    init(duration: CFTimeInterval, damping: Double, velocity: Double, fromValue: CGRect, toValue: CGRect) 
    {
        super.init()
        self.keyPath = "path"
        self.isRemovedOnCompletion = false
        self.fillMode = kCAFillModeForwards
        self.duration = duration
        self.values = self.animationValuesForPath(fromValue: fromValue, toValue: toValue, withDamping: damping, andVelocity: velocity)
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func animationValues(fromValue: Double, toValue: Double, withDamping damping: Double, andVelocity velocity: Double) -> [Any] {
        var values = [Any]()
        let res = Double(toValue) - fromValue
        let distanceBetweenValues: CGFloat = CGFloat(res)
        
        //velocity *= kVelocityMutiplier
        var vel = velocity
        vel *= kVelocityMutiplier
        
        //damping *= kDampingMutiplier
        var damp = damping
        damp *= kDampingMutiplier
        
        
        for i in 0..<kNumberOfPoints {
            let x: Double = Double(i / kNumberOfPoints)
            let normalizedValue: Double = yal_normalizeAnimationValue(value: x, damping: damp, velocity: vel)
            let value: Double = toValue - Double(distanceBetweenValues) * normalizedValue
            values.append((value))
        }
        //  with different arguments alghorithm above produces values where
        //  last values not equal to toValue therefore line below is required(not a perfect fix for issue but will do for now)
        values.append((toValue))
        return [Any](arrayLiteral: values)
    }
    
    func animationValuesForPath(fromValue: CGRect, toValue: CGRect, withDamping damping: Double, andVelocity velocity: Double) -> [Any] {
        
        var xValues = self.animationValues(fromValue: Double(fromValue.origin.x), toValue: Double(toValue.origin.x), withDamping: damping, andVelocity: velocity)
        var widthValues = self.animationValues(fromValue: Double(fromValue.size.width), toValue: Double(toValue.size.width), withDamping: damping, andVelocity: velocity)
        
        
        var pathValues = [Any]()
        let cornerRadius: CGFloat = fromValue.size.height / 2.0
        var rect = fromValue
        for i in 0..<xValues.count {
            
            let x : CGFloat = (xValues[i] as! CGFloat)
           
            let width: CGFloat = (widthValues[i] as! CGFloat)
            //var x: CGFloat = CFloat( Int(xValues[i]) )
            //var width: CGFloat = CFloat(Int(widthValues[i]))
            rect.origin.x = x
            rect.size.width = width
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            pathValues.append((path.cgPath as Any))
        }
        return [Any](arrayLiteral: pathValues)
    }
    
    /*
     *  code below borrowed SpringAnimation.swift from:https://github.com/evgenyneu/SpringAnimationCALayer
     */
        
   
//    init(keyPath: String, duration: CFTimeInterval, damping: Double, velocity: Double, fromValue: Double, toValue: Double) {
//        
//        self.keyPathh = keyPath
//        self.isRemovedOnCompletionn = false
//        self.fillModee = kCAFillModeForwards
//        self.durationn = duration
//        self.valuess = self.animationValues(fromValue: fromValue, toValue: toValue, withDamping: damping, andVelocity: velocity)
//      
//    }
        
//    init(duration: CFTimeInterval, damping: Double, velocity: Double, fromValue: CGRect, toValue: CGRect) {
//        
//        self.keyPathh = "path"
//        self.isRemovedOnCompletionn = false
//        self.fillModee = kCAFillModeForwards
//        self.durationn = duration
//        //self.values = self.animationValuesForPath(fromValue: fromValue, toValue: toValue, withDamping: damping, andVelocity: velocity)
//        
//    }
    
  
    
//    convenience init(keyPath: String, duration: CFTimeInterval, damping: Double, velocity: Double, fromValue: Double, toValue: Double) 
//    {
//      
//        self.keyPath =  keyPath
//        self.isRemovedOnCompletion = false
//        self.fillMode = kCAFillModeForwards
//        self.duration = duration
//        //self.values = self.animationValues(fromValue: fromValue, toValue: toValue, withDamping: damping, andVelocity: velocity)
//        
//    }
//    
//     init(duration: CFTimeInterval, damping: Double, velocity: Double, fromValue: CGRect, toValue: CGRect) 
//    {
//        //self.init()
//        self.keyPath = "path"
//        self.isRemovedOnCompletion = false
//        self.fillMode = kCAFillModeForwards
//        self.duration = duration
//        //self.values = self.animationValuesForPath(fromValue: fromValue, toValue: toValue, withDamping: damping, andVelocity: velocity)
//    }
//   

//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//    }
//    
    
    
    
}


func yal_normalizeAnimationValue(value: Double, damping: Double, velocity: Double) -> Double {
    return pow(M_E, -damping * value) * cos(velocity * value)
}
