//
//  DayView.swift
//  SwiftCalenderDemo
//
//  Created by kitano on 2014/12/05.
//  Copyright (c) 2014年 OneWorld Inc. All rights reserved.
//

import UIKit

protocol DayViewDelegate {
    // デリゲートメソッド定義
    func pushDay(checkDateStr:String)
}

class DayView: UIView {
    
    let checkDateStr:String!
    
     var dayDelegate :DayViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame:CGRect,year:Int,month:Int,day:Int,weekday:Int){
        checkDateStr = String(format:"%04d%02d%02d",year,month,day)
        super.init(frame: frame)
        let dayWidth:Int = Int( (UIScreen.mainScreen().bounds.size.width) / 7.0 )
        let dayHeight: Int = Int((UIScreen.mainScreen().bounds.size.height) / 7.0 )
        let dayButton:UIButton = UIButton()
        //テキストの色
        dayButton.frame = CGRectMake(0, 0, CGFloat(dayWidth/2),CGFloat(dayHeight/2))
        dayButton.layer.cornerRadius = 15
//        dayButton.layer.borderColor = UIColor.blackColor().CGColor
//        dayButton.layer.borderWidth = 1
        dayButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dayButton.addTarget(self, action: "makeAlert:", forControlEvents:.TouchUpInside)
        dayButton.setTitle("\(day)", forState: .Normal)
        if weekday == 1 {
            //日曜日は赤
            dayButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        } else if weekday == 7 {
            //土曜日は青
            dayButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        }
        self.addSubview(dayButton)
    }
    
    func makeAlert(sender: UIButton){
        
        self.dayDelegate?.pushDay(checkDateStr)
        print(checkDateStr)
        
    }
}

extension SheduleAlertView{
    
}
