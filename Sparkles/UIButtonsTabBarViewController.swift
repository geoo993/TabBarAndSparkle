//
//  UIButtonsTabBarViewController.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 28/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import EasyAnimation


class UIButtonsTabBarViewController: UIViewController{
    
    var currentButtonView : UIView!
    var mainView : UIView!
    var insetLeftRight = CGFloat()
    var tabBarColor = UIColor(red: 72.0/255.0, green: 211.0/255.0, blue: 178.0/255.0, alpha: 1)
    var tabBarViewEdgeInsets = UIEdgeInsets() 
    var tabBarItemsEdgeInsets = UIEdgeInsets()
    var tabBarViewHeight: CGFloat = 49.0
    var roundness = CGFloat()
    var selectedColor = UIColor.blue
    
    var centerButton : UIButton!
    var leftBarItems = [UITabBarItem]()
    var rightBarItems = [UITabBarItem]()
    var centerButtonBarItem = UITabBarItem()
    
    var centerButtonImage: UIImage!
    var tabBarFrame = CGRect()
    
    var leftButtonsArray = [UIButton]()
    var rightButtonsArray = [UIButton]()
    var allAdditionalButtons = [UIButton]()
    
    var feedbackLayer = UIButton()
    var feedbackLayerFrame = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBarImages()
        setupMainView()
        setupCurrentButtonView()
        centerButtonSetup()
        leftButtonsSetup()
        rightButtonsSetup()
        addButtonToArray()
        setupFeedbackLayer()
        switchTabBar(index: 0)
        
    }
    
    
    func setUpTabBarImages(){
        
        
        // Create Tab one
        let image1 = "reading2"
        let tabOneBarItem = YALTabBarItem(itemImage: UIImage(named: image1))//"profile_icon"))
        
        // Create Tab two
        //let image2 = "listening"
        //let tabTwoBarItem = YALTabBarItem(itemImage: UIImage(named: image2))//"chats_icon"))
               
        // Create Tab three
        let image3 = "teaching"
        let tabThreeBarItem = YALTabBarItem( itemImage: UIImage(named: image3))//"edit_icon"))
        
        // Create Tab four
        //let image4 = "play"
        //let tabFourBarItem = YALTabBarItem(itemImage: UIImage(named: image4))//"settings_icon"))
        
        // Create Tab four
        let image5 = "feedback"
        let tabFiveBarItem = YALTabBarItem(itemImage: UIImage(named: image5))//"nearby_icon"))
        
        self.leftBarItems = [tabOneBarItem /*, tabTwoBarItem */]
        self.rightBarItems = [ /*tabFourBarItem,*/ tabFiveBarItem]
        centerButtonBarItem = tabThreeBarItem
        roundness = tabBarViewHeight / 2.0
        
    }
    
    func setupMainView() {
        
        if (self.mainView != nil) {
            self.mainView.removeFromSuperview()
            self.mainView = nil
        }
        
        insetLeftRight = self.view.frame.width / 4.0
        tabBarViewEdgeInsets = UIEdgeInsets.init(top: 0.0, left: insetLeftRight, bottom: 0.0, right: insetLeftRight) 
        
        tabBarFrame = CGRect(x: 0.0, y: self.view.frame.height - tabBarViewHeight, width: self.view.frame.width, height: tabBarViewHeight)
        
        self.mainView = UIView(frame: UIEdgeInsetsInsetRect(tabBarFrame, self.tabBarViewEdgeInsets))
        self.mainView.layer.cornerRadius = roundness
        self.mainView.layer.masksToBounds = true
        self.mainView.backgroundColor = self.tabBarColor
        self.view.addSubview(self.mainView)
        
    }
    
    func setupCurrentButtonView(){
        
        if (self.currentButtonView != nil) {
            self.currentButtonView.removeFromSuperview()
            self.currentButtonView = nil
        }
        currentButtonView = UIView(frame: CGRect.zero)
        currentButtonView.backgroundColor = selectedColor
        currentButtonView.layer.cornerRadius = roundness
        self.mainView.addSubview(currentButtonView)
    }
   
    func centerButtonSetup(){
        
        if (self.centerButton != nil) {
            self.centerButton.removeFromSuperview()
            self.centerButton = nil
        }
        
        let centerButtonSize = CGFloat(self.mainView.frame.height)
        self.centerButton = UIButton(frame: CGRect(x: CGFloat(self.mainView.frame.midX - centerButtonSize / 2.0) - tabBarViewEdgeInsets.left, y: 0, width: centerButtonSize, height: centerButtonSize))
        
        //self.centerButton.layer.cornerRadius = roundness
        
        self.centerButton.addTarget(self, action: #selector(self.centerButtonPressed(_:)), for: .touchUpInside)
        self.centerButton.adjustsImageWhenHighlighted = false
        //self.centerButton.backgroundColor = selectedColor
        centerButton.setTitle("Explore",for: .normal)
        centerButton.titleLabel?.font = UIFont.systemFont(ofSize: 7)
        centerButton.alignImageAndTitleVertically()
        self.centerButton.setImage(centerButtonBarItem.image , for: .normal)
        self.mainView.addSubview(self.centerButton)
        
    }
    
    
    func leftButtonsSetup(){
        
        let availableSpaceForAdditionalBarButtonItemLeft: CGFloat = (self.mainView.frame.width / 2.0) - (self.centerButton.frame.width / 2.0) //- self.tabBarItemsEdgeInsets.left
        
        let maxWidthForLeftBarButonItem: CGFloat = (availableSpaceForAdditionalBarButtonItemLeft / CGFloat(leftBarItems.count))
        
        var reverseArrayLeft = [UITabBarItem]()  
        for element: UITabBarItem in leftBarItems.reversed() {
            reverseArrayLeft.append(element) 
        }
        
        var deltaLeft: CGFloat = 0.0
        if maxWidthForLeftBarButonItem > self.centerButton.frame.width {
            deltaLeft = maxWidthForLeftBarButonItem - self.centerButton.frame.width
        }
        var startPositionLeft: CGFloat = self.mainView.bounds.width / 2.0 - self.centerButton.frame.width / 2.0 - self.tabBarItemsEdgeInsets.left - deltaLeft / 2.0
        for i in 0..<leftBarItems.count {
            
            
            let buttonOriginX: CGFloat = startPositionLeft - maxWidthForLeftBarButonItem * (CGFloat(i) + 1)
            startPositionLeft -= self.tabBarItemsEdgeInsets.right
            let leftAdditionOffset = (maxWidthForLeftBarButonItem - centerButton.frame.width) / 2.0
            let button = UIButton(frame: CGRect(x: buttonOriginX + leftAdditionOffset, y: 0.0, width: maxWidthForLeftBarButonItem, height: self.mainView.frame.height))
//            if leftBarItems.count == 1 {
//                var rect = button.frame
//                rect.size.width = self.mainView.frame.height
//                button.bounds = rect
//            }
            button.setImage(reverseArrayLeft[i].image , for: .normal)
            button.setTitle("Reading",for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 7)
            button.alignImageAndTitleVertically(padding: 5)
            button.addTarget(self, action: #selector(self.didTapBarItem), for: .touchUpInside)
            
            //button.backgroundColor = UIColor.randomColor()
            //button.layer.cornerRadius = roundness
            self.leftButtonsArray.append(button)
            button.adjustsImageWhenHighlighted = false
            self.mainView.addSubview(button)
        }
        
    }
    
    func rightButtonsSetup(){
        
        let availableSpaceForAdditionalBarButtonItemRight: CGFloat = (self.mainView.frame.width / 2.0) - (self.centerButton.frame.width / 2.0) //- self.tabBarItemsEdgeInsets.right
        let maxWidthForRightBarButonItem: CGFloat = (availableSpaceForAdditionalBarButtonItemRight / CGFloat(rightBarItems.count))
        var rightDelta: CGFloat = 0.0
        if maxWidthForRightBarButonItem > self.centerButton.frame.width {
            rightDelta = maxWidthForRightBarButonItem - self.centerButton.frame.width
        }
        let rightOffset: CGFloat = self.tabBarItemsEdgeInsets.right
        var startPositionRight: CGFloat = self.mainView.bounds.width / 2.0 + self.centerButton.frame.width / 2.0 + self.tabBarItemsEdgeInsets.right + rightDelta / 2.0
        for i in 0..<rightBarItems.count {
            let buttonOriginX: CGFloat = startPositionRight
            startPositionRight = buttonOriginX + maxWidthForRightBarButonItem + rightOffset
            let rightAdditionOffset = (maxWidthForRightBarButonItem - centerButton.frame.width) / 2.0
            let button = UIButton(frame: CGRect(x: buttonOriginX - rightAdditionOffset, y: 0, width: maxWidthForRightBarButonItem, height: self.mainView.frame.height))
//            if rightBarItems.count == 1 {
//                var rect = button.frame
//                rect.size.width = self.mainView.frame.height
//                button.bounds = rect
//            }
            button.setImage(rightBarItems[i].image, for: .normal)
            button.setTitle("Feedback",for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 7)
            button.alignImageAndTitleVertically(padding: 5)
            button.addTarget(self, action: #selector(self.didTapBarItem), for: .touchUpInside)
            
            //button.backgroundColor = UIColor.randomColor()
            //button.layer.cornerRadius = roundness
            self.rightButtonsArray.append(button)
            button.adjustsImageWhenHighlighted = false
            self.mainView.addSubview(button)
        }
        
        
    }
    
    func addButtonToArray() {
        
        var tempArray = [UIButton]()
        var reverseArray = [UIButton]() 
        
        for element in  self.leftButtonsArray.reversed()
        {
            reverseArray.append(element)
        }
        
        reverseArray.append(centerButton)
        
        let arr = (reverseArray + self.rightButtonsArray)
        for button: UIButton in arr {
            tempArray.append(button)
        }
        self.allAdditionalButtons = tempArray 
        
    }
    
    func setupFeedbackLayer(){
        feedbackLayerFrame = CGRect(x: self.view.frame.midX -  ((self.view.frame.width / 1.5) / 2.0), 
                                    y: self.view.frame.midY -  (180 / 2.0), width: (self.view.frame.width / 1.5), height: 180)
        feedbackLayer = UIButton(frame: feedbackLayerFrame)
        feedbackLayer.layer.cornerRadius = roundness
        feedbackLayer.backgroundColor = UIColor.randomColor()
        self.view.addSubview(feedbackLayer)
        
        hideFeedbacklayer()
    }
    
    func showFeedbacklayer(){
        
        feedbackLayer.isHidden = false
        feedbackLayer.frame = feedbackLayerFrame
        feedbackLayer.sparkle()
    }
    
    func hideFeedbacklayer(){
        
        feedbackLayer.layer.sublayers?.removeAll()
        feedbackLayer.isHidden = true
        feedbackLayer.layer.frame = CGRect(x: (self.view.frame.width / 2.0) + self.allAdditionalButtons[2].frame.width, y:self.view.frame.height - self.allAdditionalButtons[2].frame.midY , width: self.allAdditionalButtons[2].frame.width, height: self.allAdditionalButtons[2].frame.height)
        
    }
    
    func switchTabBar(index: Int){
        
        if (index < self.allAdditionalButtons.count ) {
        
            UIView.animate(withDuration: 0.2, animations: {
                switch  index {
                case 0:
                    print("read buttons")
                    self.hideFeedbacklayer()
                case 1:
                    print("explore button")
                    self.hideFeedbacklayer()
                case 2:
                    print("feedback buttons")
                    self.showFeedbacklayer()
                default:
                    print("other buttons")
                }
                
                self.selectedColor = UIColor.randomColor()
                self.currentButtonView.backgroundColor = self.selectedColor
                self.currentButtonView.frame = self.allAdditionalButtons[index].frame
            })
        
    
        }
    }
    
    
    func centerButtonPressed(_ button: UIButton!) {
        
        //print("Center Button ")
        
        switchTabBar(index: 1)

    }
    
    func didTapBarItem(_ sender: UIButton) {
        
        
        guard let index = self.allAdditionalButtons.index(of: sender) else { return }
        //print("Other Buttons", index)
        
        switchTabBar(index: index)
       
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
