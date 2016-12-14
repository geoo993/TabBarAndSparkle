//
//  MainTabViewController.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 26/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import UIKit



class MainTabViewController: UITabBarController//, YALTabBarDataSource, YALTabBarDelegate 
{
  
/*
    var leftBarItems = [UITabBarItem]()
    var rightBarItems = [UITabBarItem]()
    var centerButtonImage: UIImage!
    var tabBarViewHeight: CGFloat = 0.0
    var tabBarView = UIView()
    
    weak var dataSource: YALTabBarDataSource?
    /**
     *  Default delegate is YALFoldingTabBarController.
     */
    weak var delegatee: YALTabBarDelegate?
    
    var centerButton : UIButton!
    var state = YALTabBarState(rawValue: 0)
    var selectedTabBarItemIndex = 0
    var tabBarColor = UIColor.red
    var dotColor = UIColor.magenta
    var tabBarViewEdgeInsets = UIEdgeInsets()
    var tabBarItemsEdgeInsets = UIEdgeInsets()
    var extraTabBarItemHeight: CGFloat = 0.0
    var offsetForExtraTabBarItems: CGFloat = 0.0
    
    var allBarItems = [UITabBarItem]()
    var animatingState = YALAnimatingState(rawValue: 0)
    var isFinishedCenterButtonAnimation = false
    var mainView : UIView!
    var isAnimating = false
    var collapsedFrame = CGRect.zero
    var expandedFrame = CGRect.zero
    var collapsedBounds = CGRect.zero
    var expandedBounds = CGRect.zero
    var counter = 0
    //buttons used instead of native tabBarItems to switch between controllers
    var leftButtonsArray = [UIButton]()
    var rightButtonsArray = [UIButton]()
    //extra buttons 'tabBarItems' for each 'tabBarItem'
    var extraLeftButton: UIButton!
    var extraRightButton: UIButton!
    //model representation of tabBarItems. also contains info for extraBarItems: image, color, etc
    var leftTabBarItems = [AnyHashable: UITabBarItem]()
    var rightTabBarItems = [AnyHashable: UITabBarItem]()
    //array of all buttons just for simple switching between controllers by index
    var allAdditionalButtons = [UIButton]()
    var allAdditionalButtonsBottomView = [UIView]()
    
    
    
    // MARK: - Initialization
    
    
//    convenience init() {
//        self.init()
//        
//        self.setupTabBarView()
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupTabBarView()
        
    }
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setupTabBarView()
        
    }
    
    func setupTabBarView() {
        
        //print("subview: ", self.tabBar.subviews.count)
        for view: UIView in self.tabBar.subviews {
            view.removeFromSuperview()
        }
        
        //self.tabBarView = YALFoldingTabBar.init(controller: self)
        self.tabBar.addSubview(self.tabBarView)
        
    }
    
    // MARK: - View & LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegatee = self
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        // Create Tab one
        let tabOne = TabOneViewController()
        let tabOneBarItem = YALTabBarItem(title: "Tab 1", itemImage: UIImage(named: "profile_icon"))
        tabOne.tabBarItem = tabOneBarItem
       
        
        // Create Tab two
        let tabTwo = TabTwoViewController()
        let tabTwoBarItem = YALTabBarItem(title: "Tab 2", itemImage: UIImage(named: "chats_icon"))
        tabTwo.tabBarItem = tabTwoBarItem
        
        // Create Tab three
        let tabThree = TabThreeViewController()
        let tabThreeBarItem = YALTabBarItem(title: "Tab 3", itemImage: UIImage(named: "edit_icon"))
        tabThree.tabBarItem = tabThreeBarItem
        
        // Create Tab four
        let tabFour = TabFourViewController()
        let tabFourBarItem = YALTabBarItem(title: "Tab 4", itemImage: UIImage(named: "settings_icon"))
        tabFour.tabBarItem = tabFourBarItem
        
        // Create Tab four
        let tabFive = TabFiveViewController()
        let tabFiveBarItem = YALTabBarItem(title: "Tab 5", itemImage: UIImage(named: "nearby_icon"))
        tabFive.tabBarItem = tabFiveBarItem

        self.leftBarItems = [tabOne.tabBarItem, tabTwo.tabBarItem]
        self.rightBarItems = [tabThree.tabBarItem, tabFour.tabBarItem]
        
        
//        self.viewControllers = [tabOne, tabTwo, tabThree, tabFour, tabFive]
        
    
        self.centerButtonImage = UIImage(named:"plus_icon")!
        self.selectedIndex = 2
        
        //customize tabBarView
        self.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
        self.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
        self.tabBarView.backgroundColor = UIColor(red: 94.0/255.0, green: 91.0/255.0, blue: 149.0/255.0, alpha: 1)
        
        self.tabBarColor = UIColor(red: 72.0/255.0, green: 211.0/255.0, blue: 178.0/255.0, alpha: 1)
        self.tabBarViewHeight = YALTabBarViewDefaultHeight;
        self.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
        self.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
        
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBarView.frame = self.tabBar.bounds
        
        print("bounds: ", self.tabBar.bounds)
        for view: UIView in self.tabBar.subviews {
            view.removeFromSuperview()
        }
        self.tabBar.addSubview(self.tabBarView)
        
        print("subviews: ", self.tabBar.subviews.count)
        self.setupUI()
    }
    
    func setSelectedIndex(selectedIndex: Int) {
        super.selectedIndex = selectedIndex
        //self.tabBarView.selectedTabBarItemIndex = selectedIndex
        self.selectedTabBarItemIndex = selectedIndex
        self.tabBarView.setNeedsLayout()
    }
    
    func setTabBarViewHeight(tabBarViewHeight: CGFloat) {
        var newFrame = self.tabBar.frame
        newFrame.size.height = tabBarViewHeight
        self.tabBar.frame = newFrame
    }
    
    func setState(_ state: YALTabBarState) {
        
        print("State changing")
        
        if state == state {
            return
        }
        switch state {
        case .YALTabBarStateCollapsed:
            self.collapse()
            
        case .YALTabBarStateExpanded:
            self.expand()
            
        }
        
        self.state = state
    }
    
    func setupUI() {
        self.removeViewsBeforeUpdateUI()
        self.setupMainView()
        self.setupCenterButton()
        
        self.collapsedFrame = self.centerButton.frame
        self.setupAdditionalTabBarItems()
        self.updateMaskLayer()
        self.setupExtraTabBarItems()
        self.setupTabBarItemsViewRepresentation()
        self.setupBarItemsModelRepresentation()
        self.prepareViewForInitialState()
        
    }
    
    func setupCenterButton() 
    {
        self.centerButton = UIButton(frame: CGRect(x: CGFloat(self.mainView.frame.midX - self.mainView.frame.height / 2.0), y: CGFloat(self.mainView.frame.midY - self.mainView.frame.height / 2.0), width: CGFloat(self.mainView.frame.height), height: CGFloat(self.mainView.frame.height)))
        
        self.centerButton.layer.cornerRadius = self.mainView.bounds.height / 2.0
        
        if (self.dataSource?.responds(to: #selector(self.centerImageInTabBarView(tabBarView:) )))!  {
            self.centerButton.setImage(self.dataSource?.centerImageInTabBarView(tabBarView: self.tabBarView), for: .normal)
        }
        self.centerButton.addTarget(self, action: #selector(self.centerButtonPressed(_:)), for: .touchUpInside)
        self.centerButton.adjustsImageWhenHighlighted = false
        self.tabBarView.addSubview(self.centerButton)
    }
   
    
    func removeViewsBeforeUpdateUI() {
        if (self.mainView != nil) {
            self.mainView.removeFromSuperview()
            self.mainView = nil
        }
        if (self.extraLeftButton != nil) {
            self.extraLeftButton.removeFromSuperview()
            self.extraLeftButton = nil
        }
        if (self.extraRightButton != nil) {
            self.extraRightButton.removeFromSuperview()
            self.extraRightButton = nil
        }
        if (self.centerButton != nil) {
            self.centerButton.removeFromSuperview()
            self.centerButton = nil
        }
    }
    
    func setupMainView() {
        
        self.mainView = UIView(frame: UIEdgeInsetsInsetRect(self.tabBar.bounds, self.tabBarViewEdgeInsets))
        self.expandedFrame = self.mainView.frame
        self.mainView.layer.cornerRadius = self.mainView.bounds.height / 2.0
        self.mainView.layer.masksToBounds = true
        self.mainView.backgroundColor = self.tabBarColor
        self.tabBarView.addSubview(self.mainView)
    }
    
    func setupAdditionalTabBarItems() {
        
        guard let leftTabBarItems = self.dataSource?.leftTabBarItemsInTabBarView(tabBarView: self.tabBarView),
            let rightTabBarItems = self.dataSource?.rightTabBarItemsInTabBarView(tabBarView: self.tabBarView) 
            else { 
                print("ERROR, no left or right items"); 
                return 
        }
        
        let numberOfLeftTabBarButtonItems = leftTabBarItems.count
        let numberOfRightTabBarButtonItems = rightTabBarItems.count
        //calculate available space for left and right side
        let availableSpaceForAdditionalBarButtonItemLeft: CGFloat = self.mainView.frame.width / 2.0 - self.centerButton.frame.width / 2.0 - self.tabBarItemsEdgeInsets.left
        let availableSpaceForAdditionalBarButtonItemRight: CGFloat = self.mainView.frame.width / 2.0 - self.centerButton.frame.width / 2.0 - self.tabBarItemsEdgeInsets.right
        let maxWidthForLeftBarButonItem: CGFloat = (availableSpaceForAdditionalBarButtonItemLeft / CGFloat(numberOfLeftTabBarButtonItems))
        let maxWidthForRightBarButonItem: CGFloat = (availableSpaceForAdditionalBarButtonItemRight / CGFloat(numberOfRightTabBarButtonItems))
        var reverseArrayLeft = [UITabBarItem]() //[NSMutableArray.init(capacity: self.leftButtonsArray.count)] 
        
        for element: UITabBarItem in leftTabBarItems.reversed() {
            reverseArrayLeft.append(element) 
        }
        
        print("Left bar items: ", leftTabBarItems.count)
        
        var mutableArray = [UIButton]()
        var mutableDotsArray = [UITabBarItem]()
        var deltaLeft: CGFloat = 0.0
        if maxWidthForLeftBarButonItem > self.centerButton.frame.width {
            deltaLeft = maxWidthForLeftBarButonItem - self.centerButton.frame.width
        }
        var startPositionLeft: CGFloat = self.mainView.bounds.width / 2.0 - self.centerButton.frame.width / 2.0 - self.tabBarItemsEdgeInsets.left - deltaLeft / 2.0
        for i in 0..<numberOfLeftTabBarButtonItems {
            let buttonOriginX: CGFloat = startPositionLeft - maxWidthForLeftBarButonItem * (CGFloat(i) + 1)
            let buttonOriginY: CGFloat = 0.0
            let buttonWidth: CGFloat = maxWidthForLeftBarButonItem
            let buttonHeight: CGFloat = self.mainView.frame.height
            startPositionLeft -= self.tabBarItemsEdgeInsets.right
            let item = (reverseArrayLeft[i] as? YALTabBarItem)
            let image = item?.itemImage
            let button = UIButton(frame: CGRect(x: buttonOriginX, y: buttonOriginY, width: buttonWidth, height: buttonHeight))
            if numberOfLeftTabBarButtonItems == 1 {
                var rect = button.frame
                rect.size.width = self.mainView.frame.height
                button.bounds = rect
            }
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(self.didTapBarItem), for: .touchUpInside)
            if self.state == YALTabBarState.YALTabBarStateCollapsed {
                button.isHidden = true
            }
            mutableArray.append(button)
            button.adjustsImageWhenHighlighted = false
            self.mainView.addSubview(button)
        }
        let reverseArrayLeftDotViews = [UITabBarItem]() /* capacity: mutableDotsArray.count */
        let reverseDot = mutableDotsArray.reversed()
        for element: UITabBarItem in reverseDot {
            reverseArrayLeft.append(element)
        }
        mutableDotsArray = reverseArrayLeftDotViews
        self.leftButtonsArray = mutableArray 
        
        
        mutableArray.removeAll()
        var rightDelta: CGFloat = 0.0
        if maxWidthForRightBarButonItem > self.centerButton.frame.width {
            rightDelta = maxWidthForRightBarButonItem - self.centerButton.frame.width
        }
        let rightOffset: CGFloat = self.tabBarItemsEdgeInsets.right
        var startPositionRight: CGFloat = self.mainView.bounds.width / 2.0 + self.centerButton.frame.width / 2.0 + self.tabBarItemsEdgeInsets.right + rightDelta / 2.0
        for i in 0..<numberOfRightTabBarButtonItems {
            let buttonOriginX: CGFloat = startPositionRight
            let buttonOriginY: CGFloat = 0.0
            let buttonWidth: CGFloat = maxWidthForRightBarButonItem
            let buttonHeight: CGFloat = self.mainView.frame.height
            startPositionRight = buttonOriginX + maxWidthForRightBarButonItem + rightOffset
            let item = rightTabBarItems[i] //as? YALTabBarItem)
            let image = item.image//item.itemImage
            let button = UIButton(frame: CGRect(x: buttonOriginX, y: buttonOriginY, width: buttonWidth, height: buttonHeight))
            if numberOfLeftTabBarButtonItems == 1 {
                var rect = button.frame
                rect.size.width = self.mainView.frame.height
                button.bounds = rect
            }
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(self.didTapBarItem), for: .touchUpInside)
            if self.state == YALTabBarState.YALTabBarStateCollapsed {
                button.isHidden = true
            }
            mutableArray.append(button)
            button.adjustsImageWhenHighlighted = false
            self.mainView.addSubview(button)
        }
        self.rightButtonsArray = mutableArray
    }

    
    func setupBarItemsModelRepresentation() {
        var tempMutableArrayOfBarItems = [UITabBarItem]()
        guard let leftTabBarItems = self.dataSource?.leftTabBarItemsInTabBarView(tabBarView: self.tabBarView), 
        let rightTabBarItems = self.dataSource?.rightTabBarItemsInTabBarView(tabBarView: self.tabBarView)
            else{ 
                print("could not get left or right bar items"); return
        }
        
        
        for item : UITabBarItem in leftTabBarItems {
            tempMutableArrayOfBarItems.append(item)
        }
        
        for item : UITabBarItem in rightTabBarItems {
            tempMutableArrayOfBarItems.append(item)
        }
        self.allBarItems = tempMutableArrayOfBarItems 
        print("allBarItems: ", self.allBarItems.count)
    }
    
    func setupExtraTabBarItems() {
        self.extraLeftButton = UIButton(frame: CGRect(x: CGFloat(0.0), y: CGFloat(self.mainView.frame.midY - self.mainView.frame.height / 2.0), width: CGFloat(self.extraTabBarItemHeight), height: CGFloat(self.extraTabBarItemHeight)))
        self.extraLeftButton.center = CGPoint(x: CGFloat(-self.extraLeftButton.frame.width / 2), y: CGFloat(self.mainView.center.y))
        self.extraLeftButton.backgroundColor = self.tabBarColor
        self.extraLeftButton.layer.cornerRadius = self.extraLeftButton.frame.width / 2.0
        self.extraLeftButton.layer.masksToBounds = true
        self.extraLeftButton.addTarget(self, action: #selector(self.didPressExtraLeftButton), for: .touchUpInside)
        self.extraLeftButton.isHidden = true
        self.tabBarView.addSubview(self.extraLeftButton)
        self.extraRightButton = UIButton(frame: CGRect(x: CGFloat(self.tabBarView.frame.width - self.centerButton.frame.width), y: CGFloat(self.mainView.frame.midY - self.mainView.frame.height / 2.0), width: CGFloat(self.extraTabBarItemHeight), height: CGFloat(self.extraTabBarItemHeight)))
        self.extraRightButton.center = CGPoint(x: CGFloat(self.extraRightButton.center.x + self.extraRightButton.frame.width), y: CGFloat(self.mainView.center.y))
        self.extraRightButton.layer.cornerRadius = self.extraLeftButton.frame.width / 2.0
        self.extraLeftButton.layer.masksToBounds = true
        self.extraRightButton.backgroundColor = self.tabBarColor
        self.extraRightButton.addTarget(self, action: #selector(self.didPressExtraRightButton), for: .touchUpInside)
        self.extraRightButton.isHidden = true
        self.tabBarView.addSubview(self.extraRightButton)
    }
    
    func changeExtraLeftTabBarItem(with image: UIImage?) {
        if (image != nil) {
            self.extraLeftButton.isHidden = false
            self.extraLeftButton.setImage(image, for: .normal)
        }
        else {
            self.extraLeftButton.isHidden = true
        }
    }
    
    func changeExtraRightTabBarItem(with image: UIImage?) {
        if (image != nil)  {
            self.extraRightButton.isHidden = false
            self.extraRightButton.setImage(image, for: .normal)
        }
        else {
            self.extraRightButton.isHidden = true
        }
    }
    
    func setupTabBarItemsViewRepresentation() {
        var tempArray = [UIButton]()
        var reverseArray = [UIButton]() /* capacity: self.leftButtonsArray.count */
        
        for element in  self.leftButtonsArray.reversed()
        {
            reverseArray.append(element)
        }
        
        let arr = (reverseArray + self.rightButtonsArray)
        for button: UIButton in arr {
            tempArray.append(button)
        }
        self.allAdditionalButtons = tempArray 
        self.allAdditionalButtonsBottomView = [UIButton]()
        for button: UIButton in self.allAdditionalButtons {
            
            let dotView = UIView(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(YALBottomSelectedDotDefaultSize), height: CGFloat(YALBottomSelectedDotDefaultSize)))
            dotView.center = CGPoint(x: CGFloat(button.center.x), y: CGFloat(button.center.y + YALBottomSelectedDotOffset))
            dotView.layer.cornerRadius = dotView.frame.height / 2.0
            dotView.backgroundColor = self.dotColor
            dotView.isHidden = true
            self.mainView.addSubview(dotView)
            
            self.allAdditionalButtonsBottomView.append(dotView)
        }
    }

    func prepareViewForInitialState() {
        if !self.hasTabBarItems() {
            return
        }
        //collapse mainView. tabBarItams are hidden.
        if self.state == YALTabBarState.YALTabBarStateExpanded {
            self.centerButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
        }
        self.mainView.frame = self.expandedFrame
        //prepare current selected tabBarItem
        let index = self.selectedTabBarItemIndex
        if self.selectedTabBarItemIndex != index {
            let previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex]
            previousSelectedDotView.isHidden = true
            self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex] = previousSelectedDotView
        }
        if self.state == YALTabBarState.YALTabBarStateExpanded {
            let previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex]
            previousSelectedDotView.isHidden = false
            self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex] = previousSelectedDotView
        }
        if self.state == YALTabBarState.YALTabBarStateExpanded && self.selectedTabBarItemIndex == index {
            self.hideExtraLeftTabBarItem()
            self.hideExtraRightTabBarItem()
        }
        self.selectedTabBarItemIndex = index
        //check if selected view controller needs extraLeftButton or extraRightButton
        let defaultSelectedTabBarItem = (self.allBarItems[index] as? YALTabBarItem)
        self.configureExtraTabBarItem(withModel: defaultSelectedTabBarItem!)
        if self.state == YALTabBarState.YALTabBarStateCollapsed {
            if (defaultSelectedTabBarItem?.leftImage != nil) {
                self.extraLeftButton.center = CGPoint(x: CGFloat(self.offsetForExtraTabBarItems + self.extraLeftButton.frame.width / 2.0), y: CGFloat(self.extraLeftButton.center.y))
            }
            if (defaultSelectedTabBarItem?.rightImage != nil) {
                self.extraRightButton.center = CGPoint(x: CGFloat(self.tabBarView.frame.width - self.offsetForExtraTabBarItems - self.extraRightButton.frame.width / 2.0), y: CGFloat(self.extraRightButton.center.y))
            }
        }
    }
    
    func configureExtraTabBarItem(withModel item: YALTabBarItem) {
        if (item.leftImage != nil) {
            self.extraLeftButton.isHidden = false
            self.extraLeftButton.setImage(item.leftImage, for: .normal)
        }
        else {
            self.extraLeftButton.isHidden = true
        }
        if (item.rightImage != nil) {
            self.extraRightButton.isHidden = false
            self.extraRightButton.setImage(item.rightImage, for: .normal)
        }
        else {
            self.extraRightButton.isHidden = true
        }
    }
    
    
    func hasTabBarItems() -> Bool {
        return (self.allBarItems.count != 0)
    }
    
    
    func centerButtonPressed(_ button: UIButton!) {
        //we should wait until animation cycle is finished
        if !self.hasTabBarItems() {
            return
        }
        
        print("Center Button ")
        guard let st = self.state, let aSt = self.animatingState 
        else {
            print("no State or animatingState" )
            return
        }
        
        self.counter += 1
        if !self.isAnimating {
            
            if self.state == YALTabBarState.YALTabBarStateCollapsed {
                self.state = YALTabBarState.YALTabBarStateExpanded
            }
            else {
                self.state = YALTabBarState.YALTabBarStateCollapsed
            }
            self.expand()
        }
        else {
            
            if self.animatingState == YALAnimatingState.YALAnimatingStateCollapsing{
                self.state = YALTabBarState.YALTabBarStateExpanded
            }
            else if self.animatingState == YALAnimatingState.YALAnimatingStateExpanding {
                self.state = YALTabBarState.YALTabBarStateCollapsed
            }
        }
        
        print("State:  ", st, " animatingState: ", aSt )
    }
    
   
    
    func didTapBarItem(_ sender: UIButton) {
        
        guard let index = self.allAdditionalButtons.index(of: sender) else { return }
        
        if !((self.delegatee?.tabBar(self.tabBarView, shouldSelectItemAt: index))!) || self.isAnimating {
            return
        }
        if self.selectedTabBarItemIndex != index {
            let item = self.allBarItems[index]
            self.configureExtraTabBarItem(withModel: item as! YALTabBarItem)
            let previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex]
            previousSelectedDotView.isHidden = true
            self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex] = previousSelectedDotView
        }
        self.selectedTabBarItemIndex = index
        
        if (self.delegatee?.responds(to: #selector(MainTabViewController.tabBarWillCollapse(_:))))! {
            self.delegatee?.tabBarWillCollapse(self.tabBarView)
        }
        self.state = YALTabBarState.YALTabBarStateCollapsed
        if (self.delegatee?.responds(to: Selector.init(("tabBar:didSelectItemAtIndex:"))))! {
            self.delegatee?.tabBar(self.tabBarView, didSelectItemAt: index)
        }
    }
    
    func didPressExtraLeftButton(_ sender: UIButton) {
        if (self.delegatee?.responds(to: #selector(MainTabViewController.tabBarDidSelectExtraLeftItem(_:))))! {
            self.delegatee?.tabBarDidSelectExtraLeftItem(self.tabBarView)
        }
    }
    
    func didPressExtraRightButton(_ sender: UIButton) {
        if (self.delegatee?.responds(to: #selector(MainTabViewController.tabBarDidSelectExtraRightItem(_:))))! {
            self.delegatee?.tabBarDidSelectExtraRightItem(self.tabBarView)
        }
    }
    
   
    // MARK: - expand/collapse
    
    func expand() {
        
        self.isFinishedCenterButtonAnimation = false
        self.animatingState = YALAnimatingState.YALAnimatingStateExpanding
        
        if (self.delegatee?.responds(to: #selector(MainTabViewController.tabBarWillExpand(_:))))! {
            self.delegatee?.tabBarWillExpand(self.tabBarView)
        }
        let counterCurrentValue = self.counter
        _ = CATransaction(animations: {
            self.isAnimating = true
            self.animateViewExpand()
            self.hideExtraLeftTabBarItem()
            self.hideExtraRightTabBarItem()
            self.animateCenterButtonExpand()
            self.animateAdditionalButtons()
            self.showSelectedDotView()
        }, andCompletion: {
            if counterCurrentValue == self.counter {
                if (self.delegatee?.responds(to: #selector(MainTabViewController.tabBarDidExpand(_:))))! {
                    self.delegatee?.tabBarDidExpand(self.tabBarView)
                }
                self.isAnimating = false
            }
        })
    }
    
    
    
    func collapse() {
        self.isFinishedCenterButtonAnimation = false
        self.animatingState = YALAnimatingState.YALAnimatingStateCollapsing
        if (self.delegatee?.responds(to: #selector(MainTabViewController.tabBarWillCollapse(_:))))!
        {
            self.delegatee?.tabBarWillCollapse(self.tabBarView)
        }
        let counterCurrentValue = self.counter
        _ = CATransaction(animations: { 
            
            self.isAnimating = true
            self.animateViewCollapse()
            self.showExtraLeftTabBarItem()
            self.showExtraRightTabBarItem()
            self.animateCenterButtonCollapse()
            self.hideSelectedDotView()
            self.animateAdditionalButtons()
        }, andCompletion: {
            if counterCurrentValue == self.counter {
                
                let selector = #selector(MainTabViewController.tabBarDidCollapse(_:))
                
                if (self.delegatee?.responds(to: selector))! {
                    self.delegatee?.tabBarDidCollapse(self.tabBarView)
                }
            }
            self.isAnimating = false
        })
    }
    
    func hideSelectedDotView() {
        let previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex]
        previousSelectedDotView.isHidden = true
        self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex] = previousSelectedDotView
    }
    
    func showSelectedDotView() {
        let previousSelectedDotView = self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex]
        previousSelectedDotView.isHidden = false
        previousSelectedDotView.layer.add(CAAnimation.showSelectedDotAnimation(), forKey: nil)
        self.allAdditionalButtonsBottomView[self.selectedTabBarItemIndex] = previousSelectedDotView
    }
    // MARK: - Animations
    
    func animateAdditionalButtons() {
        for button: UIButton in self.allAdditionalButtons {
            
            if button.isHidden {
                button.layer.add(CAAnimation(), forKey: nil)
            }
            button.isHidden = !button.isHidden
        }
    }
    
    func animateViewExpand() {
        let animation = CAAnimation.animationForTabBarExpandFromRect(for: self.collapsedBounds, to: self.expandedBounds)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.mainView.layer.mask?.add(animation, forKey: nil)
    }
    
    func animateViewCollapse() {
        let animation = CAAnimation.animationForTabBarCollapseFromRect(for: self.expandedBounds, to: self.collapsedBounds)
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        self.mainView.layer.mask?.add(animation, forKey: nil)
    }
    
    func showExtraLeftTabBarItem() {
        UIView.animate(withDuration: kYALShowExtraTabBarItemViewAnimationParameters.duration, delay: kYALShowExtraTabBarItemViewAnimationParameters.delay, usingSpringWithDamping: kYALShowExtraTabBarItemViewAnimationParameters.damping, initialSpringVelocity: kYALShowExtraTabBarItemViewAnimationParameters.velocity, options: kYALShowExtraTabBarItemViewAnimationParameters.options, animations: {() -> Void in
            self.extraLeftButton.center = CGPoint(x: CGFloat(self.extraLeftButton.frame.width / 2.0 + self.offsetForExtraTabBarItems), y: CGFloat(self.extraLeftButton.center.y))
        }, completion: { _ in })
        let animation = CAAnimation()
        self.extraLeftButton.layer.add(animation, forKey: nil)
    }
    
    func showExtraRightTabBarItem() {
        UIView.animate(withDuration: kYALShowExtraTabBarItemViewAnimationParameters.duration, delay: kYALShowExtraTabBarItemViewAnimationParameters.delay, usingSpringWithDamping: kYALShowExtraTabBarItemViewAnimationParameters.damping, initialSpringVelocity: kYALShowExtraTabBarItemViewAnimationParameters.velocity, options: kYALShowExtraTabBarItemViewAnimationParameters.options, animations: {() -> Void in
            self.extraRightButton.center = CGPoint(x: CGFloat(self.tabBarView.frame.width - self.extraRightButton.frame.width / 2.0 - self.offsetForExtraTabBarItems), y: CGFloat(self.extraRightButton.center.y))
        }, completion: { _ in })
        let animation = CAAnimation()
        self.extraRightButton.layer.add(animation, forKey: nil)
    }
    
    func hideExtraLeftTabBarItem() {
        UIView.animate(withDuration: kYALHideExtraTabBarItemViewAnimationParameters.duration, animations: {() -> Void in
            self.extraLeftButton.center = CGPoint(x: CGFloat(-self.extraLeftButton.frame.width / 2.0), y: CGFloat(self.extraLeftButton.center.y))
        })
    }
    
    func hideExtraRightTabBarItem() {
        UIView.animate(withDuration: kYALHideExtraTabBarItemViewAnimationParameters.duration, animations: {() -> Void in
            self.extraRightButton.center = CGPoint(x: CGFloat(self.extraRightButton.center.x + self.extraRightButton.frame.width + self.offsetForExtraTabBarItems), y: CGFloat(self.extraRightButton.center.y))
        })
    }
    
    func animateCenterButtonExpand() {
        let animation = CAAnimation()
        self.centerButton.layer.add(animation, forKey: nil)
    }
    
    func animateCenterButtonCollapse() {
        let animation = CAAnimation()
        self.centerButton.layer.add(animation, forKey: nil)
    }
    // MARK: - Mutators
    
    func setTabBarColor(tabBarColor: UIColor) {
        self.tabBarColor = tabBarColor
        self.mainView.backgroundColor = self.tabBarColor
        self.extraLeftButton.backgroundColor = self.tabBarColor
        self.extraRightButton.backgroundColor = self.tabBarColor
    }
    
    func setCollapsedFrame(collapsedFrame: CGRect) {
        self.collapsedFrame = collapsedFrame
        
        var collapsedBounds = collapsedFrame
        collapsedBounds.origin = CGPoint.zero
        collapsedBounds.origin.x = self.expandedFrame.width / 2 - collapsedBounds.width / 2
        self.collapsedBounds = collapsedBounds
        
        self.updateMaskLayer()
    }
    
    func setExpandedFrame(expandedFrame: CGRect) {
        self.expandedFrame = expandedFrame
        
        var expandedBounds = expandedFrame
        expandedBounds.origin = CGPoint.zero
        self.expandedBounds = expandedBounds
        
        
        self.updateMaskLayer()
    }
    // MARK: - Private
    
    func updateMaskLayer() {
        let layer = CAShapeLayer()
        let rect = (self.state == YALTabBarState.YALTabBarStateExpanded) ? self.expandedBounds : self.collapsedBounds
        layer.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.size.height / 2).cgPath
        
        self.mainView.layer.mask = layer
        
    }
    
    func hitTest(_ point: CGPoint, with event: UIEvent) -> Any {
        
        let hitView = self.tabBar.hitTest(point, with: event)
        if hitView == self.mainView {
            return UIView()
        }
        else {
            return hitView ?? UIView()
        }
    }

    
    
    
    
   
     
    
    
    // MARK: - YALTabBarViewDataSource
    
    func leftTabBarItemsInTabBarView(tabBarView: UIView) -> [UITabBarItem] {
        return self.leftBarItems
    }
    
    func rightTabBarItemsInTabBarView(tabBarView: UIView) -> [UITabBarItem] {
        return self.rightBarItems
    }
    
    func centerImageInTabBarView(tabBarView: UIView) -> UIImage {
        return self.centerButtonImage
    }
    
    
    func currentInteractingViewController() -> YALTabBarDelegate?
    {
  
        if  let selectedVC = self.selectedViewController as? UINavigationController,
            let topVC = selectedVC.topViewController as? YALTabBarDelegate {
            return topVC
        }
        else if let selectedVC = self.selectedViewController as? YALTabBarDelegate {
            return selectedVC
        } else {
            fatalError("Oh no!")
            return nil
        }
    
    // MARK: - YALTabBarViewDelegate
    
    func tabBarWillCollapse(_ tabBarView: UIView) {
        if let viewController = self.currentInteractingViewController()
            , viewController.responds(to: #selector(viewController.tabBarWillCollapse)) {
            viewController.tabBarWillCollapse(self.tabBarView)
        }
    }
    
    func tabBarDidCollapse(_ tabBarView: UIView) {
        if let viewController = self.currentInteractingViewController()
            , viewController.responds(to: #selector(viewController.tabBarDidCollapse)) {
            viewController.tabBarDidCollapse(self.tabBarView)
        }
    }
    
    func tabBarWillExpand(_ tabBarView: UIView) {
        if let viewController = self.currentInteractingViewController()
            , viewController.responds(to: #selector(viewController.tabBarWillExpand)) {
            viewController.tabBarWillExpand(self.tabBarView)
        }
    }
    
    func tabBarDidExpand(_ tabBarView: UIView) {
        if let viewController = self.currentInteractingViewController()
            , viewController.responds(to: #selector(viewController.tabBarDidExpand)) {
            viewController.tabBarDidExpand(self.tabBarView)
        }
    }
    //TODO: fix
    
    func tabBarDidSelectExtraLeftItem(_ tabBarView: UIView) {
        if let viewController = self.currentInteractingViewController()
            , viewController.responds(to: #selector(viewController.tabBarDidSelectExtraLeftItem)) {
            viewController.tabBarDidSelectExtraLeftItem(self.tabBarView)
        }
    }
    
    func tabBarDidSelectExtraRightItem(_ tabBarView: UIView) {
        if let viewController = self.currentInteractingViewController()
            , viewController.responds(to: #selector(viewController.tabBarDidSelectExtraRightItem)) {
            viewController.tabBarDidSelectExtraRightItem(self.tabBarView)
        }
    }
    
    func tabBar(_ tabBar: UIView, shouldSelectItemAt index: Int) -> Bool {
        let viewControllerToSelect = self.viewControllers?[index]
        guard let shouldAskForPermission = self.delegate?.responds(to: #selector(UITabBarControllerDelegate.tabBarController(_:shouldSelect:))) else { print("shouldAskForPermission not working"); return false }
        
        var selectionAllowed = true
        if shouldAskForPermission {
            selectionAllowed = (self.delegate?.tabBarController!(self, shouldSelect: viewControllerToSelect!))! 
            
        }
        
        print("selection allowed: ", selectionAllowed)
        return selectionAllowed
    }
    
    func tabBar(_ tabBar: UIView, didSelectItemAt index: Int) {
        self.selectedViewController = self.viewControllers?[index]
        
        print("Index: ", index)
    }
    
    
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.tabBarItem.title)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 */

}
 
