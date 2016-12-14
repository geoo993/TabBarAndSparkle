//
//  ViewController.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 23/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//


import UIKit
import RxSwift
import Foundation
import CoreGraphics
import EasyAnimation
import QuartzCore

class ViewController: UIViewController {

//    let sparkle = SparkleLayer()
//    
//    convenience init() {
//        self.init(nibName: nil, bundle:nil)
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//    }
//    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }

    let disposeBag = DisposeBag()
    
    
    private let SparkleLayerEmitterShapeKey = "circle"
    private let SparkleLayerEmitterModeKey = "surface"
    private let SparkleLayerRenderModeKey = "unordered"
    private let SparkleLayerMagnificationFilter = "linear"
    private let SparkleLayerMinificationFilter = "trilinear"
    
    //let danim = CAAnimation(coder: NSCoder.init())
    //let s = CAAnimation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.view.backgroundColor = UIColor.orange
        
        let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 240, height: 50))
        button.center = self.view.center
        button.setTitle("Tap to Twinkle", for: UIControlState())
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 32)
        button.addTarget(self, action: #selector(ViewController.handleButton(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.sparkle()
        
//        let frameworkBundle = Bundle(for: self.classForCoder)
//        
//        guard let imagePath = frameworkBundle.path(forResource: "TwinkleImage", ofType: "png")
//            , let sparkleImage = UIImage(contentsOfFile: imagePath) else { print("no image path or UIimage"); return }
//       
//       
//        
//        var sparkleLayers: [CAEmitterLayer]! = []
//        
//        let upperBound: UInt32 = 40
//        let lowerBound: UInt32 = 10
//        let count: UInt = UInt(arc4random_uniform(upperBound) + lowerBound)
//        
//        
//        for i in 0..<count {
//            let sparkleLayer: CAEmitterLayer = CAEmitterLayer()
//            _ = sparkleLayer.layerEmit(img: sparkleImage)
//            
//            let x: Int = Int(arc4random_uniform(UInt32(button.layer.bounds.size.width)))
//            let y: Int = Int(arc4random_uniform(UInt32(button.layer.bounds.size.height)))
//            sparkleLayer.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
//            sparkleLayer.opacity = 0
//            sparkleLayers.append(sparkleLayer)
//            button.layer.addSublayer(sparkleLayer)
//            
//            sparkleLayer.addPositionAnimation()
//            sparkleLayer.addRotationAnimation()
//            sparkleLayer.addFadeInOutAnimation( CACurrentMediaTime() + CFTimeInterval(0.15 * Float(i)) )
//            
//        }
//        
//        sparkleLayers.removeAll(keepingCapacity: false)
//        print("sparkleLayers count: ", sparkleLayers.count)
//        
//        guard let allLayers = button.layer.sublayers else { print("No Layers"); return }
//        print("button layers: ", allLayers.count)
//
//        for i in 0..<allLayers.count {
//            
//            if i > 0 {
//                
//                self.sparkleAnimate(mylayer: button.layer, sublayer: allLayers[i])
//            }
//            
//        }
        
        
//        let myView = UIView(frame: CGRect(x: 0, y: 100, width: 50, height: 50))
//        myView.backgroundColor = UIColor.red
//        self.view.addSubview(myView)
//        
//        animate(myView: myView)
        
        
    }

    func animate (myView: UIView){
        
        let alpha = CGFloat.random(min: 0.2, max: 1.0)
        let pos = CGFloat.random(min: 50.0, max: 300.0)
        let cornerRad = CGFloat.random(min: 20, max: 40.0)
        let scale = CGFloat.random(min: 0.5, max: 4.0)
        UIView.animate(withDuration: 2.0, delay: 0.0, 
                       usingSpringWithDamping: 0.25, 
                       initialSpringVelocity: 0.0, 
                       options: [], 
                       animations: {
                        myView.layer.position.x = pos
                        myView.layer.cornerRadius = cornerRad
                        myView.layer.transform = CATransform3DMakeScale(scale, scale, 1.0)
                        myView.backgroundColor = UIColor.randomColor()
                        myView.alpha = CGFloat(alpha)
                        
        }, completion: { _ in
            
            self.animate(myView: myView)
        })   
    }
    
    func sparkleAnimate (mylayer: CALayer, sublayer: CALayer){
        
        let scale = CGFloat.random(min: 0.5, max: 2.0)
        let x: Int = Int(arc4random_uniform(UInt32(mylayer.bounds.size.width)))
        let y: Int = Int(arc4random_uniform(UInt32(mylayer.bounds.size.height)))
        
        
        UIView.animate(withDuration: 10.0, animations: {
              
            sublayer.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
            sublayer.transform = CATransform3DMakeScale(scale, scale, 1.0)
                        
        }, completion: { _ in
            
            self.sparkleAnimate(mylayer: mylayer, sublayer: sublayer)
        })   
    }
    
    func handleButton(_ button: UIButton!) {
        //button.sparkle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

