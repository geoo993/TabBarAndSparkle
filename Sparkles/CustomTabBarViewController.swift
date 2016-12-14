//
//  CustomTabBarViewController.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 28/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit
import EasyAnimation

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate{
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        setUpTabs()
    }
   
  
    func setUpTabs(){
        
        
        // Create Tab one
        let tabOne = TabOneViewController()
        let tabOneBarItem = YALTabBarItem(title: "Tab one", itemImage: UIImage(named: "profile_icon"))
        tabOne.tabBarItem = tabOneBarItem
        
        // Create Tab two
        let tabTwo = TabTwoViewController()
        let tabTwoBarItem = YALTabBarItem(title: "Tab two", itemImage: UIImage(named: "chats_icon"))
        tabTwo.tabBarItem = tabTwoBarItem
        
        // Create Tab three
        let tabThree = TabThreeViewController()
        let tabThreeBarItem = YALTabBarItem(title: "Tab three", itemImage: UIImage(named: "edit_icon"))
        tabThree.tabBarItem = tabThreeBarItem
        
        // Create Tab four
        let tabFour = TabFourViewController()
        let tabFourBarItem = YALTabBarItem(title: "Tab four",itemImage: UIImage(named: "settings_icon"))
        tabFour.tabBarItem = tabFourBarItem
        
        // Create Tab four
        let tabFive = TabFiveViewController()
        let tabFiveBarItem = YALTabBarItem(title: "Tab five", itemImage: UIImage(named: "nearby_icon"))
        tabFive.tabBarItem = tabFiveBarItem
        
        
        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour, tabFive]
        
        self.selectedIndex = 2
      
        
    }
   
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.tabBarItem.title)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
