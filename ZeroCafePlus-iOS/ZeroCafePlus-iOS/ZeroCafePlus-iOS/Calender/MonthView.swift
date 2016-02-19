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
        self.layer.borderWidth = 1
        self.layer.borderColor = CommonFunction().UIColorFromRGB(rgbValue: 0xD3D3D3).CGColor
        
        let subViews:[UIView] = self.subviews as [UIView]
        for view in subViews {
            if view.isKindOfClass(DayView) {
                view.removeFromSuperview()
            }
        }
        
        let day:Int? = CommonFunction().getLastDay(year,month:month);
        dayWidth = frame.size.width / 7.0
        dayHeight = frame.size.width / 6.0
        if day != nil {
            //初日の曜日を取得
            var weekday:Int = CommonFunction().getWeekDay(year,month: month,day:1)
            for var i:Int = 0; i < day!;i++ {
                let week:Int    = CommonFunction().getWeek(year,month: month,day:i+1)
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
    
    
    func checkMoreEvents(year:Int,month:Int){
        var nowDate:[String] = CommonFunction().nowDateData()
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
                        let day:Int? = CommonFunction().getLastDay(year,month:month)
                        if day != nil {
                            var weekday:Int = CommonFunction().getWeekDay(year,month: month,day:1)
                            for var i:Int = 0; i < day!;i++ {
                                var eventBool = true
                                for listevent in listeventsData{
                                    if (Int(nowDate[0]) <= year && Int(nowDate[1]) <= month && (i+1) == Int(listevent)) ||
                                    (Int(nowDate[0]) == year && Int(nowDate[1]) == month && (i+1) <= Int(nowDate[2])) ||
                                        Int(nowDate[0]) > year ||
                                        (Int(nowDate[0]) == year && Int(nowDate[1]) > month)
                                    {
                                        eventBool = false
                                    }
                                    
                                }
                                
                                let dateFormatter = NSDateFormatter()
                                dateFormatter.dateFormat = "yyyy/MM/dd"
                                let nsNowDate = dateFormatter.dateFromString(String(format:"%04d/%02d/%02d",year,month,i+1))
                                
                                let week:Int    = CommonFunction().getWeek(year,month: month,day:i+1)
                                let x:CGFloat       = CGFloat(weekday-1) * (self.dayWidth/2)
                                let y:CGFloat       = CGFloat(week-1) * self.dayHeight/2
                                
                                if weekday == 1 || nsNowDate!.holiday() != nil
                                {
                                    eventBool = false
                                }
                                if eventBool{
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
    
    func pushDay(checkDateStr:String){
        self.monthDelegate?.pushMonth(checkDateStr)
    }
}
