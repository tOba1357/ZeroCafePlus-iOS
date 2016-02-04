//
//  DayView.swift
//  SwiftCalenderDemo
//
//  Created by kitano on 2014/12/05.
//  Copyright (c) 2014年 OneWorld Inc. All rights reserved.
//

import UIKit

protocol DayViewDelegate {
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
        
        let nowDate = dateData()
        
        let dayWidth:CGFloat = frame.size.width
        let dayHeight:CGFloat = frame.size.height
        let dayButton:UIButton = UIButton()
        dayButton.frame = CGRectMake(0, 0, dayWidth,dayHeight)
        dayButton.addTarget(self, action: "makeAlert:", forControlEvents:.TouchUpInside)
        dayButton.setTitle("\(day)", forState: .Normal)
        dayButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dayButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        dayButton.setTitleColor(CommonFunction().UIColorFromRGB(rgbValue: 0xD3D3D3), forState: .Normal)
        
        if weekday == 1
        {
            //日曜日
            dayButton.backgroundColor = CommonFunction().UIColorFromRGB(rgbValue: 0xF5F5F5)
            dayButton.setTitleColor(CommonFunction().UIColorFromRGB(rgbValue: 0x808080), forState: .Normal)
        }
        else if year > Int(nowDate[0]) ||
            (year == Int(nowDate[0]) && month > Int(nowDate[1])) ||
            (year == Int(nowDate[0]) && month == Int(nowDate[1]) && day > Int(nowDate[2]))
        {
            //今日以降
            dayButton.setTitleColor(CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A), forState: .Normal)
        }else if
            year == Int(nowDate[0]) && month == Int(nowDate[1]) && day == Int(nowDate[2])
        {
            //今日
            dayButton.setTitleColor(CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A), forState: .Normal)
            dayButton.backgroundColor = CommonFunction().UIColorFromRGB(rgbValue: 0xFFF8DC)
        }
        self.addSubview(dayButton)
    }
    
    func dateData() -> [String]{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let dateString:String = dateFormatter.stringFromDate(NSDate());
        let dates:[String] = dateString.componentsSeparatedByString("/")
        
        return dates
    }
    
    func makeAlert(sender: UIButton){
        
        self.dayDelegate?.pushDay(checkDateStr)
        print(checkDateStr)
        
    }
}
