//
//  ViewPager2.swift
//  ZeroCafePlus-iOS
//
//  Created by 紺谷和正 on 2016/02/05.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class ViewPager2: UIView, UIScrollViewDelegate, ViewPagerTabDelegate {
    
    
    private let tabButtonView = UIView()
    private let scrollView = UIScrollView()
    private let uiPageController = UIPageControl()
    private var viewPageTab: ViewPagerTab2!
    private var tabHeigh:CGFloat = 0
    private var views: [ViewPagerElement2] = []
    private var viewNum = 3
    private var selectView = 0
    
    init(frame :CGRect, tabHeigh: CGFloat, views: [ViewPagerElement2], defaultPage: Int = 0) {
        super.init(frame: frame)
        self.tabHeigh = tabHeigh
        self.viewNum = views.count
        self.views = views
        let tabViewFrame = CGRect(
            x: 0,
            y: 0,
            width: self.frame.width,
            height: self.tabHeigh
        )
        self.viewPageTab = ViewPagerTab2(delegate: self, frame: tabViewFrame, views: views)
        self.addSubview(self.viewPageTab)
        let scrolleViewFrame = CGRect(x: 0, y: tabHeigh*1.3, width: frame.width, height: frame.height)
        self.scrollView.frame = scrolleViewFrame
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: frame.width * CGFloat(viewNum), height: frame.height)
        self.scrollView.pagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.showsHorizontalScrollIndicator = false
        views.enumerate().forEach {
            let mainView = $0.1.mainView
            let frame = CGRect(
                x: scrolleViewFrame.width * CGFloat($0.0),
                y: 0,
                width: scrolleViewFrame.width,
                height: mainView.frame.height/2
            )
            mainView.frame = frame
            self.scrollView.addSubview(mainView)
        }
        self.addSubview(scrollView)
        
        self.uiPageController.numberOfPages = viewNum
        changePage(defaultPage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTabButtonViewBackGroundColor(color: UIColor) {
        self.tabButtonView.backgroundColor = color
    }
    
    func changePage(pageIndex: Int) {
        self.selectView = pageIndex
        self.viewPageTab.changeSelectedIndex(pageIndex)
        let visibleRect = CGRect(
            x: self.scrollView.frame.width * CGFloat(pageIndex),
            y: 0,
            width: self.scrollView.frame.width,
            height: self.scrollView.frame.height
        )
        self.scrollView.scrollRectToVisible(visibleRect, animated: true)
    }
    
    func onClickTag(button :UIButton) {
        changePage(button.tag)
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let selectIndex = Int(self.scrollView.contentOffset.x / self.frame.width)
        changePage(selectIndex)
    }
    
    func removeAllSubviews(parentView: UIView){
        for subview in parentView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func onClickTabButton(index: Int) {
        self.changePage(index)
    }

}
