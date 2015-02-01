//
//  TabBarViewController.swift
//  EventHype
//
//  Created by Russ Fenenga on 1/31/15.
//  Copyright (c) 2015 SBHacks. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController,UITabBarDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    override func tabBar(tabBar: UITabBar, didBeginCustomizingItems items: [AnyObject]) {
        self.view.tintColor = UIColor.blackColor()
    }
    
}
