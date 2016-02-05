//
//  CalenderView.swift
//  SwiftCalenderDemo
//
//  Created by kitano on 2014/12/05.
//  Copyright (c) 2014年 OneWorld Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol MonthViewDelegate {
    func pushMonth(checkDateStr:String)
}

class MonthView: UIView ,DayViewDelegate{
    
    var dayWidth:CGFloat!
    var dayHeight:CGFloat!
    
    var monthDelegate :MonthViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame: CGRect,year:Int,month:Int) {
        super.init(frame:frame)
        self.setUpDays(year,month:month,boolLabel: true)
        self.layer.borderWidth = 1
        self.layer.borderColor = CommonFunction().UIColorFromRGB(rgbValue: 0xD3D3D3).CGColor
    }
    
    func setUpDays(year:Int,month:Int,boolLabel:Bool){
        
        let subViews:[UIView] = self.subviews as [UIView]
        for view in subViews {
            if view.isKindOfClass(DayView) {
                view.removeFromSuperview()
            }
        }
        
        let day:Int? = self.getLastDay(year,month:month);
        dayWidth = frame.size.width / 7.0
        dayHeight = frame.size.width / 6.0
        if day != nil {
            //初日の曜日を取得
            var weekday:Int = self.getWeekDay(year,month: month,day:1)
            for var i:Int = 0; i < day!;i++ {
                let week:Int    = self.getWeek(year,month: month,day:i+1)
                let x:CGFloat       = CGFloat(weekday - 1 ) * (dayWidth)
                let y:CGFloat       = CGFloat(week-1) * dayHeight
                let frame:CGRect = CGRectMake(x,y,dayWidth,dayHeight)
                
                let dayView:DayView = DayView(frame: frame, year:year,month:month,day:i+1,weekday:weekday)
                self.addSubview(dayView)
                dayView.dayDelegate = self
                weekday++
                if weekday > 7 {
                    weekday = 1
                }
            }
        }
        
        for i in 0...7{
            let vertLine = UILabel(frame: CGRectMake(frame.size.width/7*CGFloat(i),0,1.5,frame.size.height))
            vertLine.backgroundColor = CommonFunction().UIColorFromRGB(rgbValue: 0xD3D3D3)
            self.addSubview(vertLine)
        }
        
        for i in 1...5{
            let horiLine = UILabel(frame: CGRectMake(0,frame.size.width/6*CGFloat(i),frame.size.width,1.5))
            horiLine.backgroundColor = CommonFunction().UIColorFromRGB(rgbValue: 0xD3D3D3)
            self.addSubview(horiLine)
        }
        
        checkMoreEvents(year,month: month)
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
        return 0
    }
    
    func checkMoreEvents(year:Int,month:Int){
        var eveDateData:[String] = dateData()
        var listeventsData:[String] = []
        let url = "https://zerocafe.herokuapp.com/api/v1/events/\(year)/\(month).json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if (response.result.isSuccess){
                    let json = JSON((response.result.value)!)
                    let eventArray = json["events"].array! as Array
                    if eventArray.count > 0{
                        for events in eventArray{
                            let startTime = events["start_time"].string! as String
                            let startTimeArray = startTime.componentsSeparatedByString("T")
                            let moreDateData = startTimeArray[0].componentsSeparatedByString("-")
                            listeventsData.append(moreDateData[2])
                        }
                        let day:Int? = self.getLastDay(year,month:month)
                        if day != nil {
                            var weekday:Int = self.getWeekDay(year,month: month,day:1)
                            for var i:Int = 0; i < day!;i++ {
                                var eventBool = true
                                for listevent in listeventsData{
                                    if i == Int(listevent) || i < Int(eveDateData[2]){
                                        eventBool = false
                                    }
                                }
                                let week:Int    = self.getWeek(year,month: month,day:i+1)
                                let x:CGFloat       = CGFloat(weekday - 1 ) * (self.dayWidth/2)
                                let y:CGFloat       = CGFloat(week-1) * self.dayHeight/2
                                if (eventBool){
                                    let cirView = UIView(frame: CGRectMake(x,y,self.frame.width/30,self.frame.height/30))
                                    self.addSubview(cirView)
                                    
                                    let cirShapeLayer = CAShapeLayer()
                                    cirShapeLayer.fillColor = CommonFunction().UIColorFromRGB(rgbValue: 0x33CCFF).CGColor
                                    cirShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: x+self.frame.width/60, y: y+self.frame.width/60, width: self.frame.width/30, height: self.frame.height/30)).CGPath
                                    cirView.layer.addSublayer(cirShapeLayer)
                                }
                                weekday++
                                if weekday > 7 {
                                    weekday = 1
                                }
                            }
                        }
                    }
                }
        }
    }
    
    func dateData() -> [String]{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let dateString:String = dateFormatter.stringFromDate(NSDate());
        let dates:[String] = dateString.componentsSeparatedByString("/")
        
        return dates
    }
    
    
    func pushDay(checkDateStr:String){
        self.monthDelegate?.pushMonth(checkDateStr)
    }
}
