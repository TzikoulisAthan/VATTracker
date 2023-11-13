//
//  CustomTabbarController.swift
//  VATTracker
//
//  Created by Athanasios Tzikoulis on 9/4/23.
//

import UIKit

class CustomTabbarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillLayoutSubviews() {
        var tabBar: UITabBar?

        var tabFrame: CGRect = self.tabBar.frame
        tabFrame.size.height = 60
        tabFrame.origin.y = self.view.frame.size.height - 60
        self.tabBar.frame = tabFrame
    }
    
}
