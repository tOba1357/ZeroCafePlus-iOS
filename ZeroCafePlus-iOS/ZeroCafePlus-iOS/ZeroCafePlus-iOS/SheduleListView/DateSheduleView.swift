//
//  DateSheduleView.swift
//  ExsampleCafe
//
//  Created by Shohei_Hayashi on 2015/12/14.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit

protocol DateSheduleDlegae{
    func pushDateShedule(checkDateStr:String)
}

class DateSheduleView: UIView, UIScrollViewDelegate,TimeSheduleDelegate{
    
    var timeCellView:TimeSheduleView!
    var scrollView:UIScrollView!
    var dateSheeduleDelegate:DateSheduleDlegae?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame: CGRect,year:Int,month:Int,day:Int) {
        super.init(frame:frame)
        
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1
        
        self.setUpSheduleList(year,month: month,day: day)
    }
    
    func setUpSheduleList(year:Int,month:Int,day:Int){
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.contentSize   = CGSizeMake(frame.size.width , frame.size.height * 2.0);
        scrollView.contentOffset = CGPointMake(0.0, 0.0);
        scrollView.delegate = self;
        scrollView.bounces = true
        scrollView.pagingEnabled = true;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.scrollsToTop = false;
        
        self.addSubview(scrollView)
        
        var timeCellPosY:CGFloat = frame.size.height/27*2
        for i in 8...21 {
            timeCellView = TimeSheduleView(frame: CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height / 27 * 2), year:year,month:month,day:i+1,hour:i)
            
            timeCellView.center = CGPointMake(frame.size.width / 2, timeCellPosY)
            timeCellView.hourDelegate = self
            timeCellPosY += frame.size.height / 27 * 4
            scrollView.addSubview(timeCellView)
        }
    }
    
    func getWeek(year:Int,month:Int,day:Int) ->Int{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let date:NSDate? = dateFormatter.dateFromString(String(format:"%04d/%02d/%02d",year,month,day));
        if date != nil {
            let calendar:NSCalendar = NSCalendar.currentCalendar()
            let dateComp:NSDateComponents = calendar.components(NSCalendarUnit.NSWeekOfMonthCalendarUnit, fromDate: date!)
            return dateComp.weekOfMonth;
        }
        return 0;
    }
    
    func pushHour(checkDateStr:String) {
        self.dateSheeduleDelegate?.pushDateShedule(checkDateStr)
    }

}
