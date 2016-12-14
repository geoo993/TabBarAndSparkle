//
//  YALdataSource.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 26/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit

//protocol YALTabBarDelegate: UITabBarControllerDelegate 
protocol YALTabBarDataSource: NSObjectProtocol 
{
    
    func leftTabBarItemsInTabBarView(tabBarView: UIView) -> [UITabBarItem]
    
    func rightTabBarItemsInTabBarView(tabBarView: UIView) -> [UITabBarItem]
    
    func centerImageInTabBarView(tabBarView: UIView) -> UIImage
}

//extension YALTabBarDataSource {
//    
//    func leftTabBarItemsInTabBarView(tabBarView: YALFoldingTabBar) -> [UIView]
//    {
//        
//    }
//    
//    func rightTabBarItemsInTabBarView(tabBarView: YALFoldingTabBar) -> [UIView]
//    {
//        
//    }
//    
//    func centerImageInTabBarView(tabBarView: YALFoldingTabBar) -> UIImage{
//        
//    }
//}
