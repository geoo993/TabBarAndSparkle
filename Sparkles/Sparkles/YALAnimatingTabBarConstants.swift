//  Converted with Swiftify v1.0.6171 - https://objectivec2swift.com/
// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project
import UIKit



let YALBottomSelectedDotDefaultSize: CGFloat = 4.0

let YALBottomSelectedDotOffset: CGFloat = 16.0

let YALTabBarViewDefaultHeight: CGFloat = 80.0

let YALExtraTabBarItemsDefaultHeight: CGFloat = 48.0

let YALForExtraTabBarItemsDefaultOffset: CGFloat = 15.0

let YALTabBarViewHDefaultEdgeInsets = UIEdgeInsets.init(top: 10.0, left: 14.0, bottom: 10.0, right: 14.0) 

let YALTabBarViewItemsDefaultEdgeInsets = UIEdgeInsets()

let kYALExpandAnimationDuration : CFTimeInterval = 1.0 //CFTimeInterval()

let kDegreeToRadiansRatio: CGFloat = .pi / 180.0


struct YALAnimationParameters {
    
    var beginTime : CFTimeInterval
    var duration: CFTimeInterval
    var fromValue: Double
    var toValue : Double
    var damping : Double
    var velocity: Double
    
    init() {
        self.beginTime = CFTimeInterval()
        self.duration = kYALExpandAnimationDuration * 2.0 / 3.0
        self.fromValue = Double()
        self.toValue = Double()
        self.damping = 0.5
        self.velocity = 3.0
    }
    init(duration: CFTimeInterval, fromValue: Double, toValue : Double){
        
        self.beginTime = CFTimeInterval()
        self.duration = duration
        self.fromValue = fromValue
        self.toValue = toValue
        self.damping = 0.5
        self.velocity = 3.0
    }
    
    init(beginTime: CFTimeInterval, fromValue: Double, toValue : Double){
     
        self.beginTime = beginTime
        self.duration = CFTimeInterval()
        self.fromValue = fromValue
        self.toValue = toValue
        self.damping = Double()
        self.velocity = Double()
    }
    
    
    init(duration: CFTimeInterval, damping : Double, velocity: Double){
        
        self.beginTime = CFTimeInterval()
        self.duration = duration
        self.fromValue = Double()
        self.toValue = Double()
        self.damping = damping
        self.velocity = velocity
    }
    init(duration: CFTimeInterval, fromValue: Double, toValue : Double, damping : Double, velocity: Double){
        
        self.beginTime = CFTimeInterval()
        self.duration = duration
        self.fromValue = fromValue
        self.toValue = toValue
        self.damping = damping
        self.velocity = velocity
    }
    init(beginTime: CFTimeInterval, duration: CFTimeInterval, fromValue: Double, toValue : Double, damping : Double, velocity: Double){
        
        self.beginTime = beginTime
        self.duration = duration
        self.fromValue = fromValue
        self.toValue = toValue
        self.damping = damping
        self.velocity = velocity
    }
    
    
}
let kYALBounceAnimationParameters = YALAnimationParameters()



struct YALAdditionalButtonsAnimationsParameters {
    var scaleX : YALAnimationParameters
    var scaleY : YALAnimationParameters
    var rotation: YALAnimationParameters
    var bounce : YALAnimationParameters
    
    init(){
        self.scaleX = YALAnimationParameters()
        self.scaleY = YALAnimationParameters()
        self.rotation = YALAnimationParameters()
        self.bounce = YALAnimationParameters()
    }
    
    init(scaleX : YALAnimationParameters, scaleY : YALAnimationParameters, rotation : YALAnimationParameters, bounce : YALAnimationParameters){
        self.scaleX = scaleX
        self.scaleY = scaleY
        self.rotation = rotation
        self.bounce = bounce
    }
    
}

struct YALCenterButtonAnimationsParameters {
    let rotation : YALAnimationParameters
    let bounce : YALAnimationParameters
    
    init(){
        self.rotation = YALAnimationParameters()
        self.bounce = YALAnimationParameters()
    }
    
    init(rotation : YALAnimationParameters, bounce : YALAnimationParameters){
        self.rotation = rotation
        self.bounce = bounce
    }
    
}

struct YALExtraTabBarItemViewAnimationParameters {
    var duration : TimeInterval
    var delay : TimeInterval 
    var damping : CGFloat
    var velocity: CGFloat
    var options : UIViewAnimationOptions
    
    init(){
        self.duration = 0.0
        self.delay = 0.0
        self.damping = 0.0
        self.velocity = 0.0
        self.options = UIViewAnimationOptions()
    }
    
    init(duration : TimeInterval){
        self.duration = duration
        self.delay = TimeInterval()
        self.damping = CGFloat()
        self.velocity = CGFloat()
        self.options = UIViewAnimationOptions()
    }
    init(duration : TimeInterval, damping : CGFloat){
        self.duration = duration
        self.delay = TimeInterval()
        self.damping = damping
        self.velocity = CGFloat()
        self.options = UIViewAnimationOptions()
    }
    init(duration : TimeInterval, delay : TimeInterval, damping : CGFloat, velocity: CGFloat, options : UIViewAnimationOptions){
        self.duration = duration
        self.delay = delay
        self.damping = damping
        self.velocity = velocity
        self.options = options
    }
    
}



struct YALSelectedDotAnimationsParameters{
    let scaleX : YALAnimationParameters
    let scaleY : YALAnimationParameters
    
    init(){
        self.scaleX = YALAnimationParameters()
        self.scaleY = YALAnimationParameters()
    }
    
    init(scaleX : YALAnimationParameters, scaleY : YALAnimationParameters){
        self.scaleX = scaleX
        self.scaleY = scaleY
    }
} 


let kYALAdditionalButtonsAnimationsParameters = YALAdditionalButtonsAnimationsParameters(
    scaleX: YALAnimationParameters(duration: kYALExpandAnimationDuration / 4.0, fromValue: 0.0, toValue: 1.0), 
    scaleY: YALAnimationParameters(duration: kYALExpandAnimationDuration / 4.0, fromValue: 0.0, toValue: 1.0), 
    rotation: YALAnimationParameters(duration: kYALExpandAnimationDuration / 4.0, fromValue: 0.0, toValue: .pi * 2.0 * 5.0), 
    bounce: YALAnimationParameters(beginTime: kYALExpandAnimationDuration / 4.0, fromValue: .pi / 8.0, toValue: 0.0)
)


//let kYALSelectedDotAnimationsParameters = YALSelectedDotAnimationsParameters()
let kYALSelectedDotAnimationsParameters = YALSelectedDotAnimationsParameters(
    scaleX: YALAnimationParameters(beginTime: kYALExpandAnimationDuration / 4.0, fromValue: 0.0, toValue: 1.0), 
    scaleY: YALAnimationParameters(duration: kYALExpandAnimationDuration / 4.0, fromValue: 0.0, toValue: 1.0)
)



//let kYALExtraLeftTabBarItemAnimationParameters = YALAnimationParameters()
let kYALExtraLeftTabBarItemAnimationParameters = YALAnimationParameters(duration: kYALExpandAnimationDuration * 3.0 / 4.0, fromValue: 0.0, toValue: .pi * 2.0 * 2.0, damping: 0.74, velocity: 1.2)


//let kYALExtraRightTabBarItemAnimationParameters = YALAnimationParameters()
let kYALExtraRightTabBarItemAnimationParameters = YALAnimationParameters(duration: kYALExpandAnimationDuration * 3.0 / 4.0, fromValue: 0.0, toValue: .pi * 2.0 * -2.0, damping:  0.74, velocity: 1.2)

//let kYALTabBarExpandAnimationParameters = YALAnimationParameters()
let kYALTabBarExpandAnimationParameters = YALAnimationParameters(duration: kYALExpandAnimationDuration / 2.0, damping: 0.5, velocity: 0.6)

//let kYALTabBarCollapseAnimationParameters = YALAnimationParameters()
let kYALTabBarCollapseAnimationParameters = YALAnimationParameters(duration: kYALExpandAnimationDuration * 0.6, damping: 1, velocity: 0.2)

//let kYALCenterButtonExpandAnimationParameters = YALCenterButtonAnimationsParameters()
let kYALCenterButtonExpandAnimationParameters = YALCenterButtonAnimationsParameters(
    rotation: YALAnimationParameters(duration: kYALExpandAnimationDuration / 4.0, fromValue: 0.0, toValue: .pi * 2.0 + 45.0 * Double(kDegreeToRadiansRatio)), 
    bounce: YALAnimationParameters(beginTime: kYALExpandAnimationDuration / 4.0, fromValue: 45.0 * Double(kDegreeToRadiansRatio) + .pi / 8.0, toValue: 45.0 * Double(kDegreeToRadiansRatio))
)

//let kYALCenterButtonCollapseAnimationParameters = YALCenterButtonAnimationsParameters ()
let kYALCenterButtonCollapseAnimationParameters = YALCenterButtonAnimationsParameters(
    rotation: YALAnimationParameters(duration: kYALExpandAnimationDuration / 4.0, fromValue: 0.0, toValue: 315.0 * Double(kDegreeToRadiansRatio)), 
    bounce: YALAnimationParameters(beginTime: kYALExpandAnimationDuration / 4.0, fromValue: .pi / 8.0, toValue: 0.0)
)


//let kYALShowExtraTabBarItemViewAnimationParameters = YALExtraTabBarItemViewAnimationParameters()
let kYALShowExtraTabBarItemViewAnimationParameters = YALExtraTabBarItemViewAnimationParameters(duration: kYALExpandAnimationDuration / 2.0, damping: 0.5)


//let kYALHideExtraTabBarItemViewAnimationParameters = YALExtraTabBarItemViewAnimationParameters()
let kYALHideExtraTabBarItemViewAnimationParameters = YALExtraTabBarItemViewAnimationParameters(duration: kYALExpandAnimationDuration / 8.0)
