//
//  ThirdViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by Kento Takemoto on 2015/12/11.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import Foundation

import UIKit

class ThirdViewController: UIViewController, UIScrollViewDelegate ,CreateEventDelegate{
    
    let scrollView = UIScrollView()
    
    var createEvetView :CreateEventView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = CGRectMake(0,0,self.view.frame.width,self.view.frame.height/10*8)
        scrollView.delegate = self;
        scrollView.contentSize   = CGSizeMake(0, 0)
        scrollView.contentOffset = CGPointMake(0.0 , 0.0)
        self.view.addSubview(scrollView)
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColorFromRGB(0xFFFFFF)
        label.text = "イベントを企画する"
        
        createEvetView = CreateEventView(frame: CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height))
        createEvetView.delegate = self
        scrollView.addSubview(createEvetView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createEventNameExposition(eventName:String,exposition:String){
        scrollView.contentSize   = CGSizeMake(0, self.view.frame.height)

    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}