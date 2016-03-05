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
    func pushDateShedule(checkDateStr:String,alreadyStertTimeData:[String],alreadyEndTimeData:[String])
}

public class DateSheduleView: UIView, UIScrollViewDelegate,TimeSheduleDelegate{
    
    var timeCellView:TimeSheduleView!
    var dateSheeduleDelegate:DateSheduleDlegae?
    var eventsLabel:UILabel!
    var myEventLavel:UILabel!
    var alrStertTimeData = [String]()
    var alrEndTimeData = [String]()
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,year:Int,month:Int,day:Int) {
        super.init(frame:frame)
        
        let subViews:[UIView] = self.subviews as [UIView]
        for view in subViews {
            if view.isKindOfClass(TimeSheduleView) {
                view.removeFromSuperview()
            }
        }
        
        var timeCellPosY:CGFloat = (frame.size.height-30)/11
        for hour in 11...21 {
            timeCellView = TimeSheduleView(frame: CGRectMake(0, timeCellPosY, self.frame.size.width, self.frame.size.height/25*2), year:year,month:month,day:day,hour:hour)
            timeCellView.hourDelegate = self
            self.addSubview(timeCellView)
            timeCellPosY += timeCellView.frame.size.height
        }
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events/\(year)/\(month)/\(day).json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if (response.result.isSuccess){
                    let json = JSON((response.result.value)!)
                    let eventArray = json["events"].array! as Array
                    if eventArray.count > 0{
                        for events in eventArray{
                            let startTime = events["start_time"].string! as String
                            let startTimeArray = startTime.componentsSeparatedByString("T")
                            let startDateData = startTimeArray[0].componentsSeparatedByString("-")
                            let startTimeData = startTimeArray[1].componentsSeparatedByString(":")
                            let endTime = events["end_time"].string! as String
                            let endTimeArray = endTime.componentsSeparatedByString("T")
                            let endTimeData = endTimeArray[1].componentsSeparatedByString(":")
                            
                            if Int(startDateData[0])! == year && Int(startDateData[1])! == month && Int(startDateData[2])! == day{
                                
                                var diffHour = Int(endTimeData[0])!-Int(startTimeData[0])!
                                var diffMinuts = Int(endTimeData[1])!-Int(startTimeData[1])!
                                if diffMinuts < 0{
                                    diffHour--
                                    diffMinuts+=60
                                }
                                var alreadyTimePosY:CGFloat = (frame.size.height-30)/11
                                alreadyTimePosY += self.timeCellView.frame.size.height*CGFloat(Int(startTimeData[0])!-11)
                                alreadyTimePosY += self.timeCellView.frame.size.height/60*CGFloat(Int(startTimeData[1])!)
                                alreadyTimePosY += self.timeCellView.frame.size.height/4
                                
                                self.eventsLabel = UILabel(frame: CGRectMake(frame.size.width/3,alreadyTimePosY,frame.size.width/5*3,self.timeCellView.frame.size.height*(CGFloat(60*diffHour+diffMinuts)/60)))
                                self.eventsLabel.backgroundColor = UIColor.grayColor()
                                self.eventsLabel.text = "予約済み"
                                self.eventsLabel.textAlignment = NSTextAlignment.Center
                                self.eventsLabel.textColor = UIColor.whiteColor()
                                self.eventsLabel.layer.masksToBounds = true
                                self.eventsLabel.layer.cornerRadius = 5
                                self.addSubview(self.eventsLabel)
                                self.bringSubviewToFront(self.eventsLabel)
                                
                                self.alrStertTimeData.append("\(startTimeData[0]):\(startTimeData[1])")
                                self.alrEndTimeData.append("\(endTimeData[0]):\(endTimeData[1])")
                            }
                        }
                    }
                }else{
                    
                }
        }
        
    }
    
    func createMyTime(startStr:String, endStr:String){
        
        if myEventLavel != nil{
            myEventLavel.removeFromSuperview()
        }
        
        let myStartTimeData = startStr.componentsSeparatedByString(":")
        let myEndTimeData = endStr.componentsSeparatedByString(":")
        
        var diffHour = Int(myEndTimeData[0])!-Int(myStartTimeData[0])!
        var diffMinuts = Int(myEndTimeData[1])!-Int(myStartTimeData[1])!
        if diffMinuts < 0{
            diffHour--
            diffMinuts+=60
        }
        var alreadyTimePosY:CGFloat = (frame.size.height-30)/11
        alreadyTimePosY += self.timeCellView.frame.size.height*CGFloat(Int(myStartTimeData[0])!-11)
        alreadyTimePosY += self.timeCellView.frame.size.height/60*CGFloat(Int(myStartTimeData[1])!)
        alreadyTimePosY += self.timeCellView.frame.size.height/4
        
        myEventLavel = UILabel(frame: CGRectMake(frame.size.width/3,alreadyTimePosY,frame.size.width/5*3,self.timeCellView.frame.size.height*(CGFloat(60*diffHour+diffMinuts)/60)))
        myEventLavel.backgroundColor = UIColor.orangeColor()
        myEventLavel.text = "ここに追加"
        myEventLavel.textAlignment = NSTextAlignment.Center
        myEventLavel.textColor = UIColor.whiteColor()
        myEventLavel.layer.masksToBounds = true
        myEventLavel.layer.cornerRadius = 5
        self.addSubview(myEventLavel)
    }
    
    func pushHour(checkDateStr:String) {
        self.dateSheeduleDelegate?.pushDateShedule(checkDateStr,alreadyStertTimeData: alrStertTimeData,alreadyEndTimeData: alrEndTimeData)
    }
}
