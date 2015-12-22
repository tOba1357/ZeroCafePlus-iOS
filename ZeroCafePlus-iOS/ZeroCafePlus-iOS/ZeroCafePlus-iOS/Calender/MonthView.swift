//
//  CalenderView.swift
//  SwiftCalenderDemo
//
//  Created by kitano on 2014/12/05.
//  Copyright (c) 2014年 OneWorld Inc. All rights reserved.
//

import UIKit

protocol MonthViewDelegate {
    // デリゲートメソッド定義
    func pushMonth(checkDateStr:String)
}

class MonthView: UIView ,DayViewDelegate{
    
    var monthDelegate :MonthViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame: CGRect,year:Int,month:Int) {
        super.init(frame:frame)

        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1
        
        self.setUpDays(year,month:month,boolLabel: true)
    }
    
    func setUpDays(year:Int,month:Int,boolLabel:Bool){
        
        let subViews:[UIView] = self.subviews as [UIView]
        for view in subViews {
            if view.isKindOfClass(DayView) {
                view.removeFromSuperview()
            }
        }
        
        
        let day:Int? = self.getLastDay(year,month:month);
        let dayWidth:Int = Int( frame.size.width / 7.0 )
        let dayHeight:Int = dayWidth + 5
        if day != nil {
            //初日の曜日を取得
            var weekday:Int = self.getWeekDay(year,month: month,day:1)
            for var i:Int = 0; i < day!;i++ {
                let week:Int    = self.getWeek(year,month: month,day:i+1)
                let x:Int       = ((weekday - 1 ) * (dayWidth));
                let y:Int       = (week-1) * dayHeight + Int(self.frame.height/7/2)
                let frame:CGRect = CGRectMake(CGFloat(x),
                    CGFloat(y),
                    CGFloat(dayWidth),
                    CGFloat(dayHeight)
                );
                
                let dayView:DayView = DayView(frame: frame, year:year,month:month,day:i+1,weekday:weekday)
                self.addSubview(dayView)
                dayView.dayDelegate = self
                weekday++
                if weekday > 7 {
                    weekday = 1
                }
                
            }
        }
    }
    
    //その月の最終日の取得
    func getLastDay(var year:Int,var month:Int) -> Int?{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        if month == 12 {
            month = 0
            year++
        }
        let targetDate:NSDate? = dateFormatter.dateFromString(String(format:"%04d/%02d/01",year,month+1));
        if targetDate != nil {
            //月初から一日前を計算し、月末の日付を取得
            let orgDate = NSDate(timeInterval:(24*60*60)*(-1), sinceDate: targetDate!)
            let str:String = dateFormatter.stringFromDate(orgDate)
            //lastPathComponentを利用するのは目的として違う気も。。
            return Int((str as NSString).lastPathComponent);
        }
        
        return nil;
    }
    
    //曜日の取得
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
    
    //第何週の取得
    func getWeekDay(year:Int,month:Int,day:Int) ->Int{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let date:NSDate? = dateFormatter.dateFromString(String(format:"%04d/%02d/%02d",year,month,day));
        if date != nil {
            let calendar:NSCalendar = NSCalendar.currentCalendar()
            let dateComp:NSDateComponents = calendar.components(NSCalendarUnit.NSWeekdayCalendarUnit, fromDate: date!)
            return dateComp.weekday;
        }
        return 0;
    }
    func pushDay(checkDateStr:String){
        self.monthDelegate?.pushMonth(checkDateStr)
    }
}
