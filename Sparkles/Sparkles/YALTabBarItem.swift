//
//  YALTabBarItem.swift
//  Sparkles
//
//  Created by GEORGE QUENTIN on 25/11/2016.
//  Copyright © 2016 GEORGE QUENTIN. All rights reserved.
//

import Foundation
import UIKit
class YALTabBarItem: UITabBarItem {
    
    
    var itemImage: UIImage?
    var leftImage: UIImage?
    var rightImage: UIImage?

    override init(){
        super.init()
        
    }
    
    init(itemImage: UIImage?, leftItemImage: UIImage?, rightItemImage: UIImage?) {
        super.init()
        self.itemImage = itemImage
        self.leftImage = leftItemImage
        self.rightImage = rightItemImage
       
    }
  
    init(itemImage: UIImage?) {
        super.init()
        
        self.image = itemImage
    }
    
    init(itemImage: UIImage?, selectedImage: UIImage?){
        super.init()
        
        self.image = itemImage
        self.selectedImage = selectedImage
     
    }
    
    init(title: String, itemImage: UIImage?) {
        super.init()
        self.title = title
        self.image = itemImage
        self.selectedImage = itemImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
}
