//
//  ThirdViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by Kento Takemoto on 2015/12/11.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIScrollViewDelegate ,CreateEventDelegate, CheckCalenderDelegate{
    
    let scrollView = UIScrollView()
    var createEvetView :CreateEventView!
    var checkCalenderView :CheckCalenderView!
    var viewCount = 0
    
    // Status Barの高さを取得する.
    let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
    
    // Viewの高さと幅を取得する.
    var displayWidth: CGFloat!
    var displayHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWidth = self.view.frame.width
        displayHeight = self.view.frame.height
        
        scrollView.frame = CGRectMake(0, barHeight, displayWidth-69, displayHeight)
        scrollView.delegate = self
        scrollView.contentSize   = CGSizeMake(0, 0)
        scrollView.contentOffset = CGPointMake(0.0 , 0.0)
        scrollView.pagingEnabled = false
        self.view.addSubview(scrollView)
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColorFromRGB(0xFFFFFF)
        label.text = "イベントを企画する"
        
        createEvetView = CreateEventView(frame: CGRectMake(0, 0, scrollView.frame.size.width,displayHeight))
        createEvetView.delegate = self
        scrollView.addSubview(createEvetView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createEventNameExposition(eventName:String,exposition:String) {
        scrollView.contentSize   = CGSizeMake(0, self.view.frame.height)
        
        checkCalenderView = CheckCalenderView(frame: CGRectMake(0, displayHeight, scrollView.frame.size.width, displayHeight))
        checkCalenderView.checkCalenderDelegate = self
        scrollView.addSubview(checkCalenderView)
        nextScroll(self.view.frame.size.height)
    }
    
    func checkedCalender(checkDate:[String]){
        nextScroll(self.view.frame.size.height*2)
    }
    
    //    func scrollViewDidScroll(scrollView:UIScrollView)
    //    {
    //        let pos:CGFloat  = scrollView.contentOffset.y / scrollView.bounds.size.height
    //        let deff:CGFloat = pos - 1.0
    //        if fabs(deff) >= 1.0 {
    //            if (deff > 0) {
    //                scrollView.setContentOffset(CGPointMake(0, scrollView.contentOffset.y + displayHeight), animated: true)
    //            }else{
    //                if scrollView.contentOffset.y > 0{
    //                    scrollView.setContentOffset(CGPointMake(0, scrollView.contentOffset.y - displayHeight), animated: true)
    //                }
    //            }
    //        }
    //    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func nextScroll(nextPosY:CGFloat){
        scrollView.contentSize = CGSizeMake(0, nextPosY)
        scrollView.setContentOffset(CGPointMake(0, nextPosY), animated: true)
    }
    
}
