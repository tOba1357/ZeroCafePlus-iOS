//
//  DayView.swift
//  SwiftCalenderDemo
//
//  Created by kitano on 2014/12/05.
//  Copyright (c) 2014年 OneWorld Inc. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol DayViewDelegate {
    func pushDay(checkDateStr:String)
}

class DayView: UIView {
    
    let checkDateStr:String!
    
    var dayDelegate :DayViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame:CGRect,year:Int,month:Int,day:Int,weekday:Int,var eventBool:Bool,listeventsData:[String]){
        
        checkDateStr = String(format:"%04d%02d%02d",year,month,day)
        super.init(frame: frame)
        
        let nowDate = CommonFunction().nowDateData()
        
        let cirView = UIView(
            frame: CGRectMake(
                0,
                0,
                self.frame.width,
                self.frame.height)
        )
        
        let url = "https://zerocafe.herokuapp.com/api/v1/holidays/\(year)/\(month).json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if (response.result.isSuccess){
                    var holidayBool = false
                    let json = JSON((response.result.value)!)
                    let holidayArray = json["holidays"].array! as Array
                    for (key,value) in holidayArray.enumerate(){
                        if key == holidayArray.endIndex-1{
                            print(value)
                            if value[String(format:"%04d-%02d-%02d",year,month,day)] != nil{
                                holidayBool = true
                            }
                        }else{
                            if day == self.holidaysDay(holidaysStr: "\(value)"){
                                holidayBool = true
                            }
                        }
                    }
                    
                    let dayWidth:CGFloat = frame.size.width
                    let dayHeight:CGFloat = frame.size.height
                    let dayButton:UIButton = UIButton()
                    dayButton.frame = CGRectMake(0, 0, dayWidth,dayHeight)
                    dayButton.setTitle("\(day)", forState: .Normal)
                    dayButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
                    dayButton.titleLabel?.font = UIFont.systemFontOfSize(10)
                    dayButton.setTitleColor(UIColor.hexStr("#D3D3D3", alpha: 1.0), forState: .Normal)
                    
                    if holidayBool
                    {
                        //日曜日 or 祝日
                        dayButton.backgroundColor = UIColor.hexStr("#F5F5F5", alpha: 1.0)
                        dayButton.setTitleColor(UIColor.hexStr("#808080", alpha: 1.0), forState: .Normal)
                        eventBool = false
                    }
                    else if year > Int(nowDate[0]) ||
                        (year == Int(nowDate[0]) && month > Int(nowDate[1])) ||
                        (year == Int(nowDate[0]) && month == Int(nowDate[1]) && day > Int(nowDate[2]))
                    {
                        //今日以降
                        dayButton.setTitleColor(UIColor.hexStr("#1A1A1A", alpha: 1.0), forState: .Normal)
                        dayButton.addTarget(self, action: "makeAlert:", forControlEvents:.TouchUpInside)
                    }else if
                        year == Int(nowDate[0]) && month == Int(nowDate[1]) && day == Int(nowDate[2])
                    {
                        //今日
                        dayButton.setTitleColor(UIColor.hexStr("#1A1A1A", alpha: 1.0), forState: .Normal)
                        dayButton.backgroundColor = UIColor.hexStr("#FFF8DC", alpha: 1.0)
                        dayButton.addTarget(self, action: "makeAlert:", forControlEvents:.TouchUpInside)
                    }
                    self.addSubview(cirView)
                    self.addSubview(dayButton)
                    
                    for listevent in listeventsData{
                        if Int(listevent) == day{
                            eventBool = false
                        }
                    }
                    
                    if (Int(nowDate[0]) == year && Int(nowDate[1]) == month && Int(nowDate[2]) >= day){
                        eventBool = false
                    }
                    
                    if eventBool{
                        let cirShapeLayer = CAShapeLayer()
                        cirShapeLayer.fillColor = UIColor.hexStr("#33CCFF", alpha: 1.0).CGColor
                        cirShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: self.frame.width/12, y: self.frame.width/12, width: self.frame.width/9, height: self.frame.height/9)).CGPath
                        cirView.layer.addSublayer(cirShapeLayer)
                    }
                }
        }
        
    }
    
    func holidaysDay(holidaysStr holidaysStr:String)->Int{
        let holiday = holidaysStr.componentsSeparatedByString("-")
        return Int(holiday[2])!
    }
    
    func makeAlert(sender: UIButton){
        
        self.dayDelegate?.pushDay(checkDateStr)
    }
}
