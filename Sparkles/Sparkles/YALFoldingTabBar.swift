import Foundation
import UIKit


enum YALTabBarState : Int {
    case YALTabBarStateCollapsed
    case YALTabBarStateExpanded
}
enum YALAnimatingState : Int {
    case YALAnimatingStateCollapsing
    case YALAnimatingStateExpanding
}



class YALFoldingTabBar: UIView {
    // MARK: - Instantiation
    
    
    //init(controller: YALFoldingTabBarController) {
    //}
//    required init?(coder aDecoder: NSCoder) {
    //    //        fatalError("init(coder:) has not been implemented")
    //    //    }
    //    
    //    init(frame frame: CGRect) {
    //        super.init(frame: frame)
    //    }
    //    
    //    
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //    }
    //    
    //    convenience init?(controller: YALFoldingTabBarController) {
    //        
    //        return nil
    //    }
       
        
    /**
     *  Default data source is YALFoldingTabBarController.
     */
    weak var dataSource: YALTabBarDataSource?
    /**
     *  Default delegate is YALFoldingTabBarController.
     */
    weak var delegate: YALTabBarDelegate?
    
    var state = YALTabBarState(rawValue: 0)
    var selectedTabBarItemIndex = 0
    var tabBarColor: UIColor!
    var dotColor: UIColor!
    var tabBarViewEdgeInsets = UIEdgeInsets()
    var tabBarItemsEdgeInsets = UIEdgeInsets()
    var extraTabBarItemHeight: CGFloat = 0.0
    var offsetForExtraTabBarItems: CGFloat = 0.0

    var allBarItems = [UITabBarItem]()
    var animatingState : YALAnimatingState!
    var isFinishedCenterButtonAnimation = false
    var centerButton: UIButton!
    var mainView: UIView!
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
    
    
    //init(controller: YALFoldingTabBarController) 
    init(controller: MainTabViewController)
    {
        
        super.init(frame: CGRect.zero)
    
        //self.delegate = controller
        //self.dataSource = controller
        self.selectedTabBarItemIndex = 0
        self.counter = 0
        self.dotColor = UIColor.black
        
    
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupUI()
    }


    
    func setState(_ state: YALTabBarState) {
        
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
// MARK: - Private

    func setupUI() {
        self.removeViewsBeforeUpdateUI()
        self.setupMainView()
        self.setupCenterButton()
        //collapsed frame equals to frame of the centerButton
        self.collapsedFrame = self.centerButton.frame
        self.setupAdditionalTabBarItems()
        self.updateMaskLayer()
        self.setupExtraTabBarItems()
        self.setupTabBarItemsViewRepresentation()
        self.setupBarItemsModelRepresentation()
        self.prepareViewForInitialState()
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

    func setupCenterButton() 
    {
        self.centerButton = UIButton(frame: CGRect(x: CGFloat(self.mainView.frame.midX - self.mainView.frame.height / 2.0), y: CGFloat(self.mainView.frame.midY - self.mainView.frame.height / 2.0), width: CGFloat(self.mainView.frame.height), height: CGFloat(self.mainView.frame.height)))
        
        self.centerButton.layer.cornerRadius = self.mainView.bounds.height / 2.0
        
        if (self.dataSource?.responds(to: Selector.init(("centerImageInTabBarView:"))))! {
            self.centerButton.setImage(self.dataSource?.centerImageInTabBarView(tabBarView: self), for: .normal)
        }
        self.centerButton.addTarget(self, action: #selector(self.centerButtonPressed), for: .touchUpInside)
        self.centerButton.adjustsImageWhenHighlighted = false
        self.addSubview(self.centerButton)
    }

    func setupMainView() {
        self.mainView = UIView(frame: UIEdgeInsetsInsetRect(self.bounds, self.tabBarViewEdgeInsets))
        self.expandedFrame = self.mainView.frame
        self.mainView.layer.cornerRadius = self.mainView.bounds.height / 2.0
        self.mainView.layer.masksToBounds = true
        self.mainView.backgroundColor = self.tabBarColor
        self.addSubview(self.mainView)
    }

    func setupAdditionalTabBarItems() {
        
        guard let leftTabBarItems = self.dataSource?.leftTabBarItemsInTabBarView(tabBarView: self),
            let rightTabBarItems = self.dataSource?.rightTabBarItemsInTabBarView(tabBarView: self) else { print("ERROR"); return }
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
            let item = (rightTabBarItems[i] as? YALTabBarItem)
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
        self.rightButtonsArray = mutableArray
    }
    //collect all tabBarItems (models) to one array

    func setupBarItemsModelRepresentation() {
        var tempMutableArrayOfBarItems = [UITabBarItem]()
        let leftTabBarItems = self.dataSource?.leftTabBarItemsInTabBarView(tabBarView: self) 
        let rightTabBarItems = self.dataSource?.rightTabBarItemsInTabBarView(tabBarView: self)
        
       
        for item : UITabBarItem in leftTabBarItems! {
            tempMutableArrayOfBarItems.append(item)
        }
        
        for item : UITabBarItem in rightTabBarItems! {
            tempMutableArrayOfBarItems.append(item)
        }
        self.allBarItems = tempMutableArrayOfBarItems 
        
    }

    func setupExtraTabBarItems() {
        self.extraLeftButton = UIButton(frame: CGRect(x: CGFloat(0.0), y: CGFloat(self.mainView.frame.midY - self.mainView.frame.height / 2.0), width: CGFloat(self.extraTabBarItemHeight), height: CGFloat(self.extraTabBarItemHeight)))
        self.extraLeftButton.center = CGPoint(x: CGFloat(-self.extraLeftButton.frame.width / 2), y: CGFloat(self.mainView.center.y))
        self.extraLeftButton.backgroundColor = self.tabBarColor
        self.extraLeftButton.layer.cornerRadius = self.extraLeftButton.frame.width / 2.0
        self.extraLeftButton.layer.masksToBounds = true
        self.extraLeftButton.addTarget(self, action: #selector(self.didPressExtraLeftButton), for: .touchUpInside)
        self.extraLeftButton.isHidden = true
        self.addSubview(self.extraLeftButton)
        self.extraRightButton = UIButton(frame: CGRect(x: CGFloat(self.frame.width - self.centerButton.frame.width), y: CGFloat(self.mainView.frame.midY - self.mainView.frame.height / 2.0), width: CGFloat(self.extraTabBarItemHeight), height: CGFloat(self.extraTabBarItemHeight)))
        self.extraRightButton.center = CGPoint(x: CGFloat(self.extraRightButton.center.x + self.extraRightButton.frame.width), y: CGFloat(self.mainView.center.y))
        self.extraRightButton.layer.cornerRadius = self.extraLeftButton.frame.width / 2.0
        self.extraLeftButton.layer.masksToBounds = true
        self.extraRightButton.backgroundColor = self.tabBarColor
        self.extraRightButton.addTarget(self, action: #selector(self.didPressExtraRightButton), for: .touchUpInside)
        self.extraRightButton.isHidden = true
        self.addSubview(self.extraRightButton)
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
                self.extraRightButton.center = CGPoint(x: CGFloat(self.frame.width - self.offsetForExtraTabBarItems - self.extraRightButton.frame.width / 2.0), y: CGFloat(self.extraRightButton.center.y))
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
// MARK: - Actions

    func centerButtonPressed() {
        //we should wait until animation cycle is finished
        if !self.hasTabBarItems() {
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
        }
        else {
            if self.animatingState == YALAnimatingState.YALAnimatingStateCollapsing{
                self.state = YALTabBarState.YALTabBarStateExpanded
            }
            else if self.animatingState == YALAnimatingState.YALAnimatingStateExpanding {
                self.state = YALTabBarState.YALTabBarStateCollapsed
            }
        }
    }

    func didTapBarItem(_ sender: AnyObject) {
        let index = self.allAdditionalButtons.index(sender as! Int, offsetBy: 0)
        if !((self.delegate?.tabBar(self, shouldSelectItemAt: index))!) || self.isAnimating {
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
        
        if (self.delegate?.responds(to: Selector.init(("tabBarWillCollapse:"))))! {
            self.delegate?.tabBarWillCollapse(self)
        }
        self.state = YALTabBarState.YALTabBarStateCollapsed
        if (self.delegate?.responds(to: Selector.init(("tabBar:didSelectItemAtIndex:"))))! {
            self.delegate?.tabBar(self, didSelectItemAt: index)
        }
    }

    func didPressExtraLeftButton(_ sender: AnyObject) {
        if (self.delegate?.responds(to: Selector.init(("tabBarDidSelectExtraLeftItem:"))))! {
            self.delegate?.tabBarDidSelectExtraLeftItem(self)
        }
    }

    func didPressExtraRightButton(_ sender: AnyObject) {
        if (self.delegate?.responds(to: Selector.init(("tabBarDidSelectExtraRightItem:"))))! {
            self.delegate?.tabBarDidSelectExtraRightItem(self)
        }
    }
// MARK: - expand/collapse

    func expand() {
        self.isFinishedCenterButtonAnimation = false
        self.animatingState = YALAnimatingState.YALAnimatingStateExpanding
        if (self.delegate?.responds(to: Selector.init(("tabBarWillExpand:"))))! {
            self.delegate?.tabBarWillExpand(self)
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
                if (self.delegate?.responds(to: Selector.init(("tabBarDidExpand:"))))! {
                    self.delegate?.tabBarDidExpand(self)
                }
                self.isAnimating = false
            }
        })
    }

   
    
    func collapse() {
        self.isFinishedCenterButtonAnimation = false
        self.animatingState = YALAnimatingState.YALAnimatingStateCollapsing
        if (self.delegate?.responds(to: Selector.init(("tabBarWillCollapse:"))))!
        {
            self.delegate?.tabBarWillCollapse(self)
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
                
                let selector = Selector.init(("tabBarDidCollapse:"))

                if (self.delegate?.responds(to: selector))! {
                    self.delegate?.tabBarDidCollapse(self)
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
            self.extraRightButton.center = CGPoint(x: CGFloat(self.frame.width - self.extraRightButton.frame.width / 2.0 - self.offsetForExtraTabBarItems), y: CGFloat(self.extraRightButton.center.y))
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
    
    // will "activate" touches behind tabBar or better between tabBarItems
    func hitTest(_ point: CGPoint, with event: UIEvent) -> Any {
        
        let hitView = super.hitTest(point, with: event)!
        if hitView == self.mainView {
            return UIView()
        }
        else {
            return hitView
        }
    }
}


