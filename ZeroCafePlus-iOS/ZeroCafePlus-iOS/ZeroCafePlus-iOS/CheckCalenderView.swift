//
//  CalenderVC.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2015/12/22.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit

protocol CheckCalenderDelegate{
    func checkedCalender(checkDate:[String])
}

class CheckCalenderView: UIView , CalenderViewDelegate{
    
    var yearMonthLabel:UILabel!
    
    var getTitle:String!
    var getDetail:String!
    
    var checkCalenderDelegate:CheckCalenderDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        var dates:[String] = dateData()
        
        yearMonthLabel = UILabel(frame: CGRectMake(0, 0, self.frame.width/3, self.frame.height/10))
        yearMonthLabel.text = "\(dates[0])/\(dates[1])月"
        yearMonthLabel.textAlignment = NSTextAlignment.Center
        yearMonthLabel.layer.position = CGPointMake(self.frame.size.width/3 , self.frame.size.height/5);
        
        
        let calenderView:CalenderView = CalenderView(frame: CGRectMake(0, 0,
            UIScreen.mainScreen().bounds.size.width*0.9, UIScreen.mainScreen().bounds.size.height*0.5))
        calenderView.calenderdelegate = self
        
        calenderView.center = CGPointMake(self.frame.width * 0.5, self.frame.height*0.5)
        
        self.addSubview(yearMonthLabel)
        self.addSubview(calenderView)
        
    }
    
    func dateData() -> [String]{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let dateString:String = dateFormatter.stringFromDate(NSDate());
        let dates:[String] = dateString.componentsSeparatedByString("/")
        
        return dates
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func pushCalender(checkNowStr:String){
        
        let checkYearStr = checkNowStr.substringToIndex(checkNowStr.startIndex.advancedBy(4))
        var checkMonthStr = checkNowStr.substringFromIndex(checkNowStr.startIndex.advancedBy(4))
        let checkDateStr = checkMonthStr.substringFromIndex(checkMonthStr.startIndex.advancedBy(2))
        checkMonthStr = checkMonthStr.substringToIndex(checkMonthStr.startIndex.advancedBy(2))
        
        let checkDate :[String] = [checkYearStr,checkMonthStr,checkDateStr]
        
        //        if let scheduleVC = self.storyboard?.instantiateViewControllerWithIdentifier("ScheduleVC") as? ScheduleVC{
        //            scheduleVC.getDate = checkDate
        //            self.navigationController?.pushViewController(scheduleVC, animated: true)
        //        }
        
    }
    func changDateCalender(checkYearInt:Int,checkMonthInt:Int){
        yearMonthLabel.text = "\(checkYearInt)/\(checkMonthInt)月"
    }
    
}

