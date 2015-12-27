//
//  CalenderVC.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2015/12/22.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class CalenderVC: UIViewController , CalenderViewDelegate{
    
    var yearMonthLabel:UILabel!

    var getTitle:String!
    var getDetail:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var dates:[String] = dateData()
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColorFromRGB(0xFFFFFF)
        label.text = "イベントを企画する"
        self.navigationItem.titleView = label
        
        yearMonthLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width/3, self.view.frame.height/10))
        yearMonthLabel.text = "\(dates[0])/\(dates[1])月"
        yearMonthLabel.textAlignment = NSTextAlignment.Center
        yearMonthLabel.layer.position = CGPointMake(self.view.frame.size.width/3 , self.view.frame.size.height/5);
        
        
        let calenderView:CalenderView = CalenderView(frame: CGRectMake(0, 0,
            UIScreen.mainScreen().bounds.size.width*0.9, UIScreen.mainScreen().bounds.size.height*0.5))
        calenderView.calenderdelegate = self
        
        calenderView.center = CGPointMake(self.view.frame.width * 0.5, self.view.frame.height*0.5)
        
        self.view.addSubview(yearMonthLabel)
        self.view.addSubview(calenderView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        if let scheduleVC = self.storyboard?.instantiateViewControllerWithIdentifier("ScheduleVC") as? ScheduleVC{
            scheduleVC.getTitle = getTitle
            scheduleVC.getDetail = getDetail
            scheduleVC.getDate = checkDate
            self.navigationController?.pushViewController(scheduleVC, animated: true)
        }
        
    }
    func changDateCalender(checkYearInt:Int,checkMonthInt:Int){
        yearMonthLabel.text = "\(checkYearInt)/\(checkMonthInt)月"
    }
}

