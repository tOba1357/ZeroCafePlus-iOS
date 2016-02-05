//
//  ViewPagerElement2.swift
//  ZeroCafePlus-iOS
//
//  Created by 紺谷和正 on 2016/02/05.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class ViewPagerElement2{
    
    var selectedTitleView: UIView
    var noSelectedTitleView: UIView
    var mainView :UIView
    
    init(selectedTitleView:UIView, noSelectedTitleView: UIView, mainView: UIView) {
        self.selectedTitleView = selectedTitleView
        self.noSelectedTitleView = noSelectedTitleView
        self.mainView = mainView
        
        
        /*
        // Only override drawRect: if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        override func drawRect(rect: CGRect) {
        // Drawing code
        }
        */
        
    }
}
