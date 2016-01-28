//
//  TimeSheduleView.swift
//  ExsampleCafe
//
//  Created by Shohei_Hayashi on 2015/12/16.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol TimeSheduleDelegate {
    func pushHour(checkDateStr:String)
}

class TimeSheduleView: UIView {
    
    var checkDateStr:String!
    
    var hourDelegate : TimeSheduleDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame: CGRect,year:Int,month:Int,day:Int,hour:Int) {
        super.init(frame:frame)
        
        checkDateStr = String(format:"%04d/%02d/%02d/%02d",year,month,day,hour)
        
        let hourLabel = UILabel()
        hourLabel.text = "\(hour):00"
        
        let hourBar = UILabel()
        hourBar.backgroundColor = UIColor.blackColor()

        if hour == 21 {
            
            hourLabel.frame = CGRectMake(0,0,frame.size.width / 4,frame.size.height)
            hourLabel.layer.position = CGPointMake(frame.size.width / 4,frame.size.height / 4)
            
            hourBar.frame = CGRectMake(0,0,frame.size.width/5*3, 1)
            hourBar.layer.position = CGPointMake(frame.size.width / 3 * 2,frame.size.height * 0.25)
            
        } else {
            hourLabel.frame = CGRectMake(0,0,frame.size.width / 4,frame.size.height)
            hourLabel.layer.position = CGPointMake(frame.size.width / 4,frame.size.height / 4)
            
            hourBar.frame = CGRectMake(0,0,frame.size.width/5*3, 1)
            hourBar.layer.position = CGPointMake(frame.size.width / 3 * 2,frame.size.height * 0.25)
            
        }
        
        let cellButton = UIButton()
        cellButton.frame = frame
        cellButton.addTarget(self, action: "makeAlert:", forControlEvents:.TouchUpInside)
        cellButton.layer.position = CGPointMake(frame.size.width/2,frame.size.height/2)
        
        self.addSubview(hourLabel)
        self.addSubview(hourBar)
        self.addSubview(cellButton)

        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                debugPrint(response.result.value)
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray{
                    let startTime = events["event"]["start_time"].string! as String
                    let startTimeArray = startTime.componentsSeparatedByString("T")
                    let startDateData = startTimeArray[0].componentsSeparatedByString("-")
                    let startTimeData = startTimeArray[1].componentsSeparatedByString(":")
                    let endTime = events["event"]["end_time"].string! as String
                    let endTimeArray = endTime.componentsSeparatedByString("T")
                    let endTimeData = endTimeArray[1].componentsSeparatedByString(":")
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
                    
                    if Int(startDateData[0])! == year &&
                        Int(startDateData[1])! == month &&
                        Int(startDateData[2])! == day{
                            print("aaa")
                            if Int(startTimeData[0])! == hour-1 {
                                if Int(startTimeData[1])! >= 45{
                                    var i = 45
                                    while Int(endTimeData[0])! == hour-1 && Int(endTimeData[1])! == i{
                                        let eventsLabel = UILabel(frame: CGRectMake(frame.size.width/2,frame.size.height/120+frame.size.height/60*CGFloat(i-45),frame.size.width/10,frame.size.height/60))
                                        eventsLabel.backgroundColor = UIColor.greenColor()
                                        self.addSubview(eventsLabel)
                                        print("a\(Int(startTimeData[1]))")
                                        i++
                                    }
                                }
                            }
                            else if Int(startTimeData[0])! == hour{
                                
                                if Int(startTimeData[1]) < 45{
                                    var i = 0
                                    while Int(startTimeData[1]) == i{
                                        if Int(endTimeData[0])! == hour && Int(endTimeData[1])! == i {
                                            break
                                        }
                                        let eventsLabel = UILabel(frame: CGRectMake(frame.size.width/2,frame.size.height/60*CGFloat(i+15),frame.size.width/10,frame.size.height/60))
                                        eventsLabel.backgroundColor = UIColor.greenColor()
                                        self.addSubview(eventsLabel)
                                        i++
                                    }
                                }
                            }
                    }
                }
        }
    }
    
    func makeAlert(sender: UIButton){
        self.hourDelegate?.pushHour(checkDateStr)
    }
}
