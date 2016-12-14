//  Converted with Swiftify v1.0.6171 - https://objectivec2swift.com/
// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project


import UIKit
import QuartzCore

extension CAAnimation {
    
    //// MARK: - Additional buttons animations
    static func animationForAdditionalButton() -> CAAnimation {
    
        let scaleX = CABasicAnimation(keyPath: "transform.scale.x")
        scaleX.fromValue = (kYALAdditionalButtonsAnimationsParameters.scaleX.fromValue)
        scaleX.toValue = (kYALAdditionalButtonsAnimationsParameters.scaleX.toValue)
        scaleX.duration = kYALAdditionalButtonsAnimationsParameters.scaleX.duration
        let scaleY = CABasicAnimation(keyPath: "transform.scale.y")
        scaleY.fromValue = (kYALAdditionalButtonsAnimationsParameters.scaleY.fromValue)
        scaleY.toValue = (kYALAdditionalButtonsAnimationsParameters.scaleY.toValue)
        scaleY.duration = kYALAdditionalButtonsAnimationsParameters.scaleY.duration
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = (kYALAdditionalButtonsAnimationsParameters.rotation.fromValue)
        rotation.toValue = (kYALAdditionalButtonsAnimationsParameters.rotation.toValue)
        rotation.duration = kYALAdditionalButtonsAnimationsParameters.rotation.duration
        rotation.fillMode = kCAFillModeForwards
        rotation.isRemovedOnCompletion = false
        let bouncedRotation = self.rotationBouncedAnimation(fromValue: kYALAdditionalButtonsAnimationsParameters.bounce.fromValue, toValue: kYALAdditionalButtonsAnimationsParameters.bounce.toValue)
        
        
        bouncedRotation.beginTime = kYALAdditionalButtonsAnimationsParameters.bounce.beginTime
        return self.groupWithAnimations(animations: [scaleX, scaleY, rotation, bouncedRotation], andDuration: kYALExpandAnimationDuration)
    }
   
// MARK: - Extra buttons animations

    static func animationForExtraLeftBarItem() -> CAAnimation {
        return YALSpringAnimation(keyPath: "transform.rotation.z", duration: kYALExtraLeftTabBarItemAnimationParameters.duration, damping: kYALExtraLeftTabBarItemAnimationParameters.damping, velocity: kYALExtraLeftTabBarItemAnimationParameters.velocity, fromValue: kYALExtraLeftTabBarItemAnimationParameters.fromValue, toValue: kYALExtraLeftTabBarItemAnimationParameters.toValue)
    }

    static func animationForExtraRightBarItem() -> CAAnimation {
        return YALSpringAnimation(keyPath: "transform.rotation.z", duration: kYALExtraRightTabBarItemAnimationParameters.duration, damping: kYALExtraRightTabBarItemAnimationParameters.damping, velocity: kYALExtraRightTabBarItemAnimationParameters.velocity, fromValue: kYALExtraRightTabBarItemAnimationParameters.fromValue, toValue: kYALExtraRightTabBarItemAnimationParameters.toValue)
    }
// MARK: - Tab bar view animations

    static func animationForTabBarExpandFromRect(for fromRect: CGRect, to toRect: CGRect) -> CAAnimation {
        return YALSpringAnimation(duration: kYALTabBarExpandAnimationParameters.duration, damping: kYALTabBarExpandAnimationParameters.damping, velocity: kYALTabBarExpandAnimationParameters.velocity, fromValue: fromRect, toValue: toRect)
    }

    static func animationForTabBarCollapseFromRect(for fromRect: CGRect, to toRect: CGRect) -> CAAnimation {
        return YALSpringAnimation(duration: kYALTabBarCollapseAnimationParameters.duration, damping: kYALTabBarCollapseAnimationParameters.damping, velocity: kYALTabBarCollapseAnimationParameters.velocity, fromValue: fromRect, toValue: toRect)
    } 

// MARK: - Center button animation

    static func animationForCenterButtonExpand() -> CAAnimation {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = (kYALCenterButtonExpandAnimationParameters.rotation.fromValue)
        rotation.toValue = (kYALCenterButtonExpandAnimationParameters.rotation.toValue)
        rotation.duration = kYALCenterButtonExpandAnimationParameters.rotation.duration
        rotation.fillMode = kCAFillModeForwards
        rotation.isRemovedOnCompletion = false
        let bouncedRotation = self.rotationBouncedAnimation(fromValue: kYALCenterButtonExpandAnimationParameters.bounce.fromValue, toValue: kYALCenterButtonExpandAnimationParameters.bounce.toValue)
        bouncedRotation.beginTime = kYALCenterButtonExpandAnimationParameters.bounce.beginTime
        return self.groupWithAnimations(animations: [rotation, bouncedRotation], andDuration: kYALExpandAnimationDuration)
    }

    static func animationForCenterButtonCollapse() -> CAAnimation {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = (kYALCenterButtonCollapseAnimationParameters.rotation.fromValue)
        rotation.toValue = (kYALCenterButtonCollapseAnimationParameters.rotation.toValue)
        rotation.duration = kYALCenterButtonCollapseAnimationParameters.rotation.duration
        rotation.fillMode = kCAFillModeForwards
        rotation.isRemovedOnCompletion = false
        let bouncedRotation = self.rotationBouncedAnimation(fromValue: kYALCenterButtonCollapseAnimationParameters.bounce.fromValue, toValue: kYALCenterButtonCollapseAnimationParameters.bounce.toValue)
        bouncedRotation.beginTime = kYALCenterButtonCollapseAnimationParameters.bounce.beginTime
        return self.groupWithAnimations(animations: [rotation, bouncedRotation], andDuration: kYALExpandAnimationDuration)
    }

    static func showSelectedDotAnimation() -> CAAnimation {
        let scaleX = CABasicAnimation(keyPath: "transform.scale.x")
        scaleX.fromValue = (kYALSelectedDotAnimationsParameters.scaleX.fromValue)
        scaleX.toValue = (kYALSelectedDotAnimationsParameters.scaleX.toValue)
        scaleX.duration = kYALSelectedDotAnimationsParameters.scaleX.duration
        let scaleY = CABasicAnimation(keyPath: "transform.scale.y")
        scaleY.fromValue = (kYALSelectedDotAnimationsParameters.scaleY.fromValue)
        scaleY.toValue = (kYALSelectedDotAnimationsParameters.scaleY.toValue)
        scaleY.duration = kYALSelectedDotAnimationsParameters.scaleY.duration
        
        let duration : CFTimeInterval = (kYALExpandAnimationDuration / 2)
        return self.groupWithAnimations(animations: [scaleX, scaleY], andDuration: duration)
    }

    
    // MARK: - Helpers -
    // MARK: Group
    
    static func groupWithAnimations( animations: [CAAnimation], andDuration duration: CFTimeInterval) -> CAAnimationGroup {
        
        let group = CAAnimationGroup()
        group.duration = duration
        group.animations = animations
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        return group
    }
    
    // MARK: Rotation bounce animation
    
    static func rotationBouncedAnimation(fromValue: Double, toValue: Double) -> YALSpringAnimation {
        
        return YALSpringAnimation(keyPath: "transform.rotation.z", duration: kYALBounceAnimationParameters.duration, damping: kYALBounceAnimationParameters.damping, velocity: kYALBounceAnimationParameters.velocity, fromValue: fromValue, toValue: toValue)
    }
    
    
}
