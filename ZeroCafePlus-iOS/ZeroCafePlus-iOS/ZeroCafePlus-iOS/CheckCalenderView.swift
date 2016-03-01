//
//  CalenderVC.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2015/12/22.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit

protocol CheckCalenderDelegate{
    func checkedCalender(checkDate:[String])
    func presentWaitAlertAction()
    func dismissWaitAlertAction()
}

class CheckCalenderView: UIView , CalenderViewDelegate{
    
    var yearMonthLabel:UILabel!
    let cirShapeLayer = CAShapeLayer()
    var selfVC:UIViewController!
    
    var checkCalenderDelegate:CheckCalenderDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        var dates:[String] = dateData()
        
        let label = UILabel(frame: CGRectMake(0,self.frame.height*(110/1136),self.frame.width,self.frame.height*(28/1136)))
        label.text = "開催日時を選択"
        label.textAlignment = NSTextAlignment.Left
        label.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        label.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        
        
        yearMonthLabel = UILabel(frame: CGRectMake(0, self.frame.height*(170/1136), self.frame.width, self.frame.height*(32/1136)))
        yearMonthLabel.text = "\(dates[0])年 \(dates[1])月"
        yearMonthLabel.font = UIFont.systemFontOfSize(self.frame.height*(32/1136))
        yearMonthLabel.textAlignment = NSTextAlignment.Center
        yearMonthLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        
        let sunLabel = UILabel(frame: CGRectMake(0, self.frame.height*(226/1136), self.frame.width/7, self.frame.height*(20/1136)))
        sunLabel.text = "Sun"
        sunLabel.textAlignment = NSTextAlignment.Center
        sunLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        sunLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        let monLabel = UILabel(frame: CGRectMake(self.frame.width/7, self.frame.height*(226/1136), self.frame.width/7, self.frame.height*(20/1136)))
        monLabel.text = "Mon"
        monLabel.textAlignment = NSTextAlignment.Center
        monLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        monLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        let tueLabel = UILabel(frame: CGRectMake(self.frame.width/7*2, self.frame.height*(226/1136), self.frame.width/7, self.frame.height*(20/1136)))
        tueLabel.text = "Tue"
        tueLabel.textAlignment = NSTextAlignment.Center
        tueLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        tueLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        let wedLabel = UILabel(frame: CGRectMake(self.frame.width/7*3, self.frame.height*(226/1136), self.frame.width/7, self.frame.height*(20/1136)))
        wedLabel.text = "Wed"
        wedLabel.textAlignment = NSTextAlignment.Center
        wedLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        wedLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        let thuLabel = UILabel(frame: CGRectMake(self.frame.width/7*4, self.frame.height*(226/1136), self.frame.width/7, self.frame.height*(20/1136)))
        thuLabel.text = "Thu"
        thuLabel.textAlignment = NSTextAlignment.Center
        thuLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        thuLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        let friLabel = UILabel(frame: CGRectMake(self.frame.width/7*5, self.frame.height*(226/1136), self.frame.width/7, self.frame.height*(20/1136)))
        friLabel.text = "Fri"
        friLabel.textAlignment = NSTextAlignment.Center
        friLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        friLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))

        let satLabel = UILabel(frame: CGRectMake(self.frame.width/7*6, self.frame.height*(226/1136), self.frame.width/7, self.frame.height*(20/1136)))
        satLabel.text = "Sat"
        satLabel.textAlignment = NSTextAlignment.Center
        satLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        satLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))

        let calenderView:CalenderView = CalenderView(frame: CGRectMake(0, self.frame.height*(262/1136),
            self.frame.size.width, self.frame.size.width))
        calenderView.calenderdelegate = self
        
        let cirShapeLayer = CAShapeLayer()
        cirShapeLayer.fillColor = UIColor.hexStr("#33CCFF", alpha: 1.0).CGColor
        cirShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: self.frame.height*(290/1136)+calenderView.frame.size.height, width: self.frame.height*(16/1136), height: self.frame.height*(16/1136))).CGPath
        
        let cafeBoolLabel = UILabel(frame: CGRectMake(self.frame.height*(16/1136)*2, self.frame.height*(286/1136)+calenderView.frame.size.height, self.frame.width/2, self.frame.height*(28/1136)))
        cafeBoolLabel.text = "予約ゼロ"
        cafeBoolLabel.textAlignment = NSTextAlignment.Left
        cafeBoolLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        cafeBoolLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        
        self.addSubview(label)
        self.addSubview(yearMonthLabel)
        self.addSubview(sunLabel)
        self.addSubview(monLabel)
        self.addSubview(tueLabel)
        self.addSubview(wedLabel)
        self.addSubview(thuLabel)
        self.addSubview(friLabel)
        self.addSubview(satLabel)
        self.addSubview(calenderView)
        self.layer.addSublayer(cirShapeLayer)
        self.addSubview(cafeBoolLabel)
    }
    
    func dateData() -> [String]{
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let dateString:String = dateFormatter.stringFromDate(NSDate());
        let dates:[String] = dateString.componentsSeparatedByString("/")
        
        return dates
    }
    
    func pushCalender(checkNowStr:String){
        
        let checkYearStr = checkNowStr.substringToIndex(checkNowStr.startIndex.advancedBy(4))
        var checkMonthStr = checkNowStr.substringFromIndex(checkNowStr.startIndex.advancedBy(4))
        let checkDateStr = checkMonthStr.substringFromIndex(checkMonthStr.startIndex.advancedBy(2))
        checkMonthStr = checkMonthStr.substringToIndex(checkMonthStr.startIndex.advancedBy(2))
        
        let checkDate :[String] = [checkYearStr,checkMonthStr,checkDateStr]
        
        self.checkCalenderDelegate.checkedCalender(checkDate)        
    }
    
    func presentWaitAlert(){
        self.checkCalenderDelegate.presentWaitAlertAction()
    }
    
    func dismisWaitAlert(){
        self.checkCalenderDelegate.dismissWaitAlertAction()
    }
    
    func changDateCalender(checkYearInt:Int,checkMonthInt:Int){
        yearMonthLabel.text = "\(checkYearInt)/\(checkMonthInt)月"
    }
}

