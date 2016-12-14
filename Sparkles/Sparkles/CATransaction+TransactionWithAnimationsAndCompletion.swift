//  Converted with Swiftify v1.0.6171 - https://objectivec2swift.com/
// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project
import QuartzCore


extension CATransaction {
    
    convenience init(animations: @escaping () -> Void, andCompletion completion: @escaping () -> Void) {
        self.init()
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock(completion)
         
//        if animations {
            animations()
//        }
        
        CATransaction.commit()
    }
}
