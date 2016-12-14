//  Converted with Swiftify v1.0.6171 - https://objectivec2swift.com/
// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project
import UIKit

/*
//view
class YALFoldingTabBarController: UITabBarController {
    
    var leftBarItems = [UITabBarItem]()
    var rightBarItems = [UITabBarItem]()
    var centerButtonImage: UIImage!
    var tabBarViewHeight: CGFloat = 0.0
    var tabBarView: YALFoldingTabBar!

    // MARK: - Initialization
    
    
    convenience init() {
        self.init()
        
        self.setupTabBarView()
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupTabBarView()
        
    }
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setupTabBarView()
        
    }

//    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
//        
//    }
    
    // MARK: - View & LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBarView.frame = self.tabBar.bounds
        for view: UIView in self.tabBar.subviews {
           view.removeFromSuperview()
        }
        self.tabBar.addSubview(self.tabBarView)
    }
    
    //override func setSelectedIndex(_ selectedIndex: Int) {
     func setSelectedIndex(selectedIndex: Int) {
        super.selectedIndex = selectedIndex
        self.tabBarView.selectedTabBarItemIndex = selectedIndex
        self.tabBarView.setNeedsLayout()
    }

    func setTabBarViewHeight(tabBarViewHeight: CGFloat) {
        var newFrame = self.tabBar.frame
        newFrame.size.height = tabBarViewHeight
        self.tabBar.frame = newFrame
    }
    

//    func tabBarViewHeight() -> CGFloat {
//        return self.tabBar.frame.size.height
//    }
    
    
  
    // MARK: - Private
    
    func setupTabBarView() {
        for view: UIView in self.tabBar.subviews {
            view.removeFromSuperview()
        }
        self.tabBarView = YALFoldingTabBar.init(controller: self)
        self.tabBar.addSubview(self.tabBarView)
    }
    
      
    func currentInteractingViewController() -> YALTabBarDelegate {
        
        if (self.selectedViewController! is UINavigationController) {
            return ((self.selectedViewController! as! UINavigationController).topViewController! as! YALTabBarDelegate)
        }
        else {
            return (self.selectedViewController! as! YALTabBarDelegate)
        }
    }
    
   
    // MARK: - YALTabBarViewDataSource
    
    func leftTabBarItemsInTabBarView(tabBarView: YALFoldingTabBar) -> [UITabBarItem] {
        return self.leftBarItems
    }
    
    func rightTabBarItemsInTabBarView(tabBarView: YALFoldingTabBar) -> [UITabBarItem] {
        return self.rightBarItems
    }
    
    func centerImageInTabBarView(tabBarView: YALFoldingTabBar) -> UIImage {
        return self.centerButtonImage
    }
    // MARK: - YALTabBarViewDelegate
    
    func tabBarWillCollapse(_ tabBarView: YALFoldingTabBar) {
        let viewController = self.currentInteractingViewController()
        if viewController.responds(to: #selector(self.tabBarWillCollapse)) {
            viewController.tabBarWillCollapse(self.tabBarView)
        }
    }
    
    func tabBarDidCollapse(_ tabBarView: YALFoldingTabBar) {
        let viewController = self.currentInteractingViewController()
        if viewController.responds(to: #selector(self.tabBarDidCollapse)) {
            viewController.tabBarDidCollapse(self.tabBarView)
        }
    }
    
    func tabBarWillExpand(_ tabBarView: YALFoldingTabBar) {
        let viewController = self.currentInteractingViewController()
        if viewController.responds(to: #selector(self.tabBarWillExpand)) {
            viewController.tabBarWillExpand(self.tabBarView)
        }
    }
    
    func tabBarDidExpand(_ tabBarView: YALFoldingTabBar) {
        let viewController = self.currentInteractingViewController()
        if viewController.responds(to: #selector(self.tabBarDidExpand)) {
            viewController.tabBarDidExpand(self.tabBarView)
        }
    }
    //TODO: fix
    
    func tabBarDidSelectExtraLeftItem(_ tabBarView: YALFoldingTabBar) {
        let viewController = self.currentInteractingViewController()
        if viewController.responds(to: #selector(self.tabBarDidSelectExtraLeftItem)) {
            viewController.tabBarDidSelectExtraLeftItem(self.tabBarView)
        }
    }
    
    func tabBarDidSelectExtraRightItem(_ tabBarView: YALFoldingTabBar) {
        let viewController = self.currentInteractingViewController()
        if viewController.responds(to: #selector(self.tabBarDidSelectExtraRightItem)) {
            viewController.tabBarDidSelectExtraRightItem(self.tabBarView)
        }
    }
    
    func tabBar(_ tabBar: YALFoldingTabBar, shouldSelectItemAt index: Int) -> Bool {
        let viewControllerToSelect = self.viewControllers?[index]
        guard let shouldAskForPermission = self.delegate?.responds(to: #selector(UITabBarControllerDelegate.tabBarController(_:shouldSelect:))) else { print("shouldAskForPermission not working"); return false }
        
        var selectionAllowed = true
        if shouldAskForPermission {
            selectionAllowed = (self.delegate?.tabBarController!(self, shouldSelect: viewControllerToSelect!))! 
                
        }
        
        return selectionAllowed
    }
    
    func tabBar(_ tabBar: YALFoldingTabBar, didSelectItemAt index: Int) {
        self.selectedViewController = self.viewControllers?[index]
    }
   
    
    
}

 
 */

