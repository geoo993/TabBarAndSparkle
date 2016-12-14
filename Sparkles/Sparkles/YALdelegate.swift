//
//  YALdelegate.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 26/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit

@objc 
protocol YALTabBarDelegate: NSObjectProtocol 
//protocol YALTabBarDelegate: UITabBarControllerDelegate 
{
    
    @objc func tabBar(_ tabBar: UIView, didSelectItemAt index: Int)
    
    @objc func tabBar(_ tabBar: UIView, shouldSelectItemAt index: Int) -> Bool
    
    @objc func tabBarWillCollapse(_ tabBar: UIView)
    
    @objc func tabBarWillExpand(_ tabBar: UIView)
    
    @objc func tabBarDidCollapse(_ tabBar: UIView)
    
    @objc func tabBarDidExpand(_ tabBar: UIView)
    
    @objc func tabBarDidSelectExtraLeftItem(_ tabBar: UIView)
    
    @objc func tabBarDidSelectExtraRightItem(_ tabBar: UIView)
}

//extension YALTabBarDelegate {
////    
//////    func tabBar(_ tabBar: YALFoldingTabBar, didSelectItemAt index: Int){
//////        
//////    }
//////    
//////    func tabBar(_ tabBar: YALFoldingTabBar, shouldSelectItemAt index: Int) -> Bool{
//////        
//////    }
//    
//    func tabBarWillExpand(_ tabBar: YALFoldingTabBar) {
//        print("will expand")
//    }
//    
//    func tabBarDidExpand(_ tabBar: YALFoldingTabBar) {
//        print("did expand")
//    }
//    
//    func tabBarWillCollapse(_ tabBar: YALFoldingTabBar) {
//        print("will collapse")
//    }
//    
//    func tabBarDidCollapse(_ tabBar: YALFoldingTabBar) {
//        print("did collapse")
//    }
//    
//    func tabBarDidSelectExtraLeftItem(_ tabBar: YALFoldingTabBar){
//        print("tabBarDidSelectExtraLeftItem")
//    }
//    
//    func tabBarDidSelectExtraRightItem(_ tabBar: YALFoldingTabBar){
//        print("tabBarDidSelectExtraRightItem")
//    }
//}

