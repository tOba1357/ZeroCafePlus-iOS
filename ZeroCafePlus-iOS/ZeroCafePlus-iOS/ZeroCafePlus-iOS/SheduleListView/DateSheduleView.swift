//
//  DateSheduleView.swift
//  ExsampleCafe
//
//  Created by Shohei_Hayashi on 2015/12/14.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DateSheduleDlegae{
    func pushDateShedule(checkDateStr:String)
}

class DateSheduleView: UIView, UIScrollViewDelegate,TimeSheduleDelegate{
    
    var timeCellView:TimeSheduleView!
    var dateSheeduleDelegate:DateSheduleDlegae?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,year:Int,month:Int,day:Int) {
        super.init(frame:frame)
        
        print("--cellTime--\(year)-\(month)-\(day)")
        
        var timeCellPosY:CGFloat = (frame.size.height-40)/11+20
        for hour in 11...21 {
            timeCellView = TimeSheduleView(frame: CGRectMake(0, timeCellPosY, self.frame.size.width, self.frame.size.height/27*2), year:year,month:month,day:day,hour:hour)
            timeCellView.hourDelegate = self
            self.addSubview(timeCellView)
            
            let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
            Alamofire.request(.GET, url)
                .responseJSON { response in
                    if (response.result.isSuccess){
                        let json = JSON((response.result.value)!)
                        let eventArray = json["events"].array! as Array
                        for events in eventArray{
                            let startTime = events["event"]["start_time"].string! as String
                            let startTimeArray = startTime.componentsSeparatedByString("T")
                            let startDateData = startTimeArray[0].componentsSeparatedByString("-")
                            let startTimeData = startTimeArray[1].componentsSeparatedByString(":")
                            let endTime = events["event"]["end_time"].string! as String
                            let endTimeArray = endTime.componentsSeparatedByString("T")
                            let endTimeData = endTimeArray[1].componentsSeparatedByString(":")
                            
                            if Int(startDateData[0])! == year && Int(startDateData[1])! == month && Int(startDateData[2])! == day{
                                
                                if Int(startTimeData[0])! == hour {
                                    
                                    print("-----------jsontime::------")
                                    print("--cellTime--\(year)-\(month)-\(day)-\(hour)")
                                    print(startTime)
                                    print(startTimeData[0])
                                    print(startTimeData[1])
                                    print(startTimeData[2])
                                    print(endTime)
                                    print(endTimeData[0])
                                    print(endTimeData[1])
                                    print(endTimeData[2])
                                    
                                    var diffHour = Int(endTimeData[0])!-Int(startTimeData[0])!
                                    var diffMinuts = Int(endTimeData[1])!-Int(startTimeData[1])!
                                    if diffMinuts < 0{
                                        diffHour--
                                        diffMinuts+=60
                                    }
                                    
                                    let eventsLabel = UILabel(frame: CGRectMake(
                                        frame.size.width/3,
                                        timeCellPosY,
                                        frame.size.width/5*3,
                                        self.timeCellView.frame.size.height*CGFloat(60*diffHour+diffMinuts)/60
                                        ))
                                    eventsLabel.backgroundColor = UIColor.greenColor()
                                    self.addSubview(eventsLabel)
                                }
                            }
                        }
                    }else{
                        
                    }
            }
            timeCellPosY += (frame.size.height-40)/11
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
