//
//  CustomTabBarController.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2016/02/17.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.hexStr("#f39800", alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
