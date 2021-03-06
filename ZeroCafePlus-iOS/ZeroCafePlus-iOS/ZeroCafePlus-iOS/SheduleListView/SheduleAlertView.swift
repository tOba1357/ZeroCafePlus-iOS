//
//  CustomSheduleView.swift
//  ExsampleCafe
//
//  Created by Shohei_Hayashi on 2015/12/14.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit

protocol SheduleAlertDelegate{
    func pushSheduleAlert(checkDateStr:String,myDateArray:[Int],alreadyStertTimeData:[String],alreadyEndTimeData:[String])
    func changDateShedule(myDateStr:String)
    func presentWaitAlertAction()
    func dismissWaitAlertAction()
    
}

class SheduleAlertView: UIView, UIScrollViewDelegate,DateSheduleDlegae{
    
    var currentYear:Int = 0
    var currentMonth:Int = 0
    var currentDay:Int = 0
    
    var scrollView:UIScrollView!
    
    var prevDayView:DateSheduleView!
    var currentDayView:DateSheduleView!
    var nextDayView:DateSheduleView!
    
    var sheduleAlertDelegate :SheduleAlertDelegate?
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(frame:CGRect,year:Int,month:Int,day:Int){
        super.init(frame: frame)
        currentYear = year
        currentMonth = month
        currentDay = day
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.contentSize   = CGSizeMake(frame.size.width *  4.0, frame.size.height);
        scrollView.contentOffset = CGPointMake(frame.size.width , 0.0);
        scrollView.delegate = self;
        scrollView.bounces = true
        scrollView.pagingEnabled = true;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.scrollsToTop = false;
        
        self.addSubview(scrollView)
        
        currentDayView=DateSheduleView(frame: CGRectMake(frame.size.width, 0, frame.size.width,frame.size.height),
            year:year,month:month,day:day)
        currentDayView.dateSheeduleDelegate = self
        
        var ret = getPrevyMd()
        prevDayView = DateSheduleView(frame: CGRectMake(0, 0, frame.size.width,frame.size.height),
            year:ret.year,month:ret.month,day:ret.date)
        prevDayView.dateSheeduleDelegate = self
        
        ret = getNextyMd()
        nextDayView = DateSheduleView(frame: CGRectMake(frame.size.width * 2, 0, frame.size.width,frame.size.height),
            year:ret.year,month:ret.month,day:ret.date)
        nextDayView.dateSheeduleDelegate = self
        
        scrollView.addSubview(prevDayView)
        scrollView.addSubview(currentDayView)
        scrollView.addSubview(nextDayView)
        
    }
    
    func scrollViewDidScroll(scrollView:UIScrollView)
    {
        let pos:CGFloat  = scrollView.contentOffset.x / scrollView.bounds.size.width
        let deff:CGFloat = pos - 1.0
        if fabs(deff) >= 1.0 {
            presentWaitAlert()
            if (deff > 0) {
                self.showNextView()
                dismissWaitAlert()
            } else {
                self.showPrevView()
                dismissWaitAlert()            }
            changeDate()
        }
    }
    
    func showNextView(){
        currentDay++
        if currentDay > CommonFunction().getLastDay(currentYear,month: currentMonth){
            currentDay = 1
            currentMonth++
            if( currentMonth > 12 ){
                currentMonth = 1;
                currentYear++;
            }
        }
        let tmpView:DateSheduleView = currentDayView
        currentDayView = nextDayView
        let ret = getNextyMd()
        nextDayView = DateSheduleView(frame: CGRectMake(frame.size.width * 2, 0, frame.size.width,frame.size.height),
            year:ret.year,month:ret.month,day:ret.date)
        nextDayView.dateSheeduleDelegate = self
        scrollView.addSubview(nextDayView)
        prevDayView = tmpView
        
        self.resetContentOffSet()
    }
    
    func showPrevView(){
        currentDay--
        if currentDay < 1 {
            currentMonth--
            currentDay = CommonFunction().getLastDay(currentYear,month: currentMonth)!
            if currentMonth < 1{
                currentYear--
                currentMonth = 12
            }
        }
        let tmpView:DateSheduleView = currentDayView
        currentDayView = prevDayView
        let ret = getPrevyMd()
        prevDayView = DateSheduleView(frame: CGRectMake(0, 0, frame.size.width,frame.size.height),
            year:ret.year,month:ret.month,day:ret.date)
        prevDayView.dateSheeduleDelegate = self
        scrollView.addSubview(prevDayView)
        nextDayView = tmpView
        
        self.resetContentOffSet()
    }
    
    func resetContentOffSet () {
        prevDayView.frame = CGRectMake(0, 0, frame.size.width,frame.size.height)
        currentDayView.frame = CGRectMake(frame.size.width, 0, frame.size.width,frame.size.height)
        nextDayView.frame = CGRectMake(frame.size.width * 2.0, 0, frame.size.width,frame.size.height)
        
        let scrollViewDelegate:UIScrollViewDelegate = scrollView.delegate!
        scrollView.delegate = nil
        scrollView.contentOffset = CGPointMake(frame.size.width, 0.0);
        scrollView.delegate = scrollViewDelegate
    }
    
    func getNextyMd () -> (year:Int,month:Int,date:Int){
        var next_year:Int = currentYear
        var next_month:Int = currentMonth
        var next_date:Int = currentDay + 1
        if next_date > CommonFunction().getLastDay(next_year,month: next_month){
            next_date = 1
            next_month++
            if next_month > 12{
                next_year++
                next_month = 1
            }
        }
        return (next_year,next_month,next_date)
    }
    
    func getPrevyMd () -> (year:Int,month:Int,date:Int){
        var prev_year:Int = currentYear
        var prev_month:Int = currentMonth
        var prev_date:Int = currentDay - 1
        if prev_date < 1{
            prev_month--
            prev_date = CommonFunction().getLastDay(prev_year,month: prev_month)!
            if prev_month < 1{
                prev_year--
                prev_month = 12
            }
        }
        return (prev_year,prev_month,prev_date)
    }
    
    func createMyTimeSchedule(startTime:String,endTime:String){
        currentDayView.createMyTime(startTime, endStr: endTime)
        
    }
    
    func changeDate(){
        let myDateStr = String(format:"%04d/%02d/%02d",currentYear,currentMonth,currentDay)
        self.sheduleAlertDelegate?.changDateShedule(myDateStr)
    }
    
    func pushDateShedule(checkDateStr:String,alreadyStertTimeData:[String],alreadyEndTimeData:[String]){
        let myDateArray:[Int] = [currentYear,currentMonth,currentDay]
        self.sheduleAlertDelegate?.pushSheduleAlert(checkDateStr,myDateArray: myDateArray,alreadyStertTimeData: alreadyStertTimeData,alreadyEndTimeData: alreadyEndTimeData)
    }
    
    func presentWaitAlert(){
        self.sheduleAlertDelegate?.presentWaitAlertAction()
    }
    
    func dismissWaitAlert(){
        self.sheduleAlertDelegate?.dismissWaitAlertAction()
    }
    
}
