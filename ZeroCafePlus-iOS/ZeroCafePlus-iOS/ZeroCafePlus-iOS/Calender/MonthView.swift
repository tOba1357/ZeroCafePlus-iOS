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
        self.layer.borderColor = UIColor.hexStr("#D3D3D3", alpha: 1.0).CGColor
        var eventBool = true
        var listeventsData:[String] = []
        var nowDate:[String] = CommonFunction().nowDateData()
        
        let subViews:[UIView] = self.subviews as [UIView]
        for view in subViews {
            if view.isKindOfClass(DayView) {
                view.removeFromSuperview()
            }
        }
        
        let lastday:Int? = CommonFunction().getLastDay(year,month:month);
        dayWidth = frame.size.width / 7.0
        dayHeight = frame.size.width / 6.0
        
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
                    }
                    
                    if lastday != nil {
                        //初日の曜日を取得
                        var weekday:Int = CommonFunction().getWeekDay(year,month: month,day:1)
                        for var i:Int = 0; i < lastday!;i++ {
                            
                            let week:Int    = CommonFunction().getWeek(year,month: month,day:i+1)
                            let x:CGFloat       = CGFloat(weekday - 1 ) * (self.dayWidth)
                            let y:CGFloat       = CGFloat(week-1) * self.dayHeight
                            let frame:CGRect = CGRectMake(x,y,self.dayWidth,self.dayHeight)
                            
                            if Int(nowDate[0]) > year ||
                                (Int(nowDate[0]) == year && Int(nowDate[1]) > month)
                            {
                                eventBool = false
                            }
                            
                            
                            let dayView:DayView = DayView(frame: frame, year:year,month:month,day:i+1,weekday:weekday,eventBool:eventBool,listeventsData:listeventsData)
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
                        vertLine.backgroundColor = UIColor.hexStr("#D3D3D3", alpha: 1.0)
                        self.addSubview(vertLine)
                    }
                    
                    for i in 1...5{
                        let horiLine = UILabel(frame: CGRectMake(0,frame.size.width/6*CGFloat(i),frame.size.width,1.5))
                        horiLine.backgroundColor = UIColor.hexStr("#D3D3D3", alpha: 1.0)
                        self.addSubview(horiLine)
                    }
                }
        }
    }
    
    
    func pushDay(checkDateStr:String){
        self.monthDelegate?.pushMonth(checkDateStr)
    }
}
