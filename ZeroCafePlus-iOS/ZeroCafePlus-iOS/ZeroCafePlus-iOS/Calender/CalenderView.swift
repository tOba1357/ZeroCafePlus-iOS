//
//  CalenderView.swift
//  SwiftCalenderDemo
//
//  Created by kitano on 2014/12/05.
//  Copyright (c) 2014年 OneWorld Inc. All rights reserved.
//

import UIKit

protocol CalenderViewDelegate {
    func pushCalender(checkNowStr:String)
    func changDateCalender(checkYearInt:Int,checkMonthInt:Int)
}

class CalenderView: UIView, UIScrollViewDelegate, MonthViewDelegate{
    
    var currentYear:Int = 0
    var currentMonth:Int = 0
    var currentDay:Int = 0
    var scrollView:UIScrollView!
    var prevMonthView:MonthView!
    var currentMonthView:MonthView!
    var nextMonthView:MonthView!
    var avLoadingView:UIAlertView!
    
    var calenderdelegate: CalenderViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
    
        avLoadingView = UIAlertView(title: nil, message: "Wait..", delegate: self, cancelButtonTitle: nil)
        
        var nowDate:[String] = CommonFunction().nowDateData()
        
        currentYear  = Int(nowDate[0])!
        currentMonth = Int(nowDate[1])!
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.contentSize   = CGSizeMake(frame.size.width *  3.0,0);
        scrollView.contentOffset = CGPointMake(frame.size.width , 0.0);
        scrollView.delegate = self;
        scrollView.bounces = true
        scrollView.pagingEnabled = true;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.scrollsToTop = false;
        
        self.addSubview(scrollView)
        
        currentMonthView = MonthView(frame: CGRectMake(frame.size.width, 0, frame.size.width,frame.size.height),
            year:currentYear,month:currentMonth)
        currentMonthView.monthDelegate = self
        
        //翌月
        var ret = self.getNextYearAndMonth()
        nextMonthView =  MonthView(frame: CGRectMake(frame.size.width*2, 0, frame.size.width,frame.size.height),
            year:ret.year,month:ret.month)
        nextMonthView.monthDelegate = self
        
        ret = self.getPrevYearAndMonth()
        prevMonthView    = MonthView(frame: CGRectMake(0, 0,frame.size.width, frame.size.height),
            year:ret.year,month:ret.month)
        prevMonthView.monthDelegate = self
        
        scrollView.addSubview(currentMonthView)
        scrollView.addSubview(nextMonthView)
        scrollView.addSubview(prevMonthView)
        
    }
    
    func scrollViewDidScroll(scrollView:UIScrollView)
    {
        let pos:CGFloat  = scrollView.contentOffset.x / scrollView.bounds.size.width
        let deff:CGFloat = pos - 1.0
        if fabs(deff) >= 1.0 {
            avLoadingView.show()
            if (deff > 0) {
                self.showNextView()
                avLoadingView.dismissWithClickedButtonIndex(0, animated: true)
            } else {
                self.showPrevView()
                avLoadingView.dismissWithClickedButtonIndex(0, animated: true)
            }
            changeMonth()
        }
    }
    
    func showNextView (){
        currentMonth++;
        if( currentMonth > 12 ){
            currentMonth = 1;
            currentYear++;
        }
        let tmpView:MonthView = currentMonthView
        let ret = self.getNextYearAndMonth()
        currentMonthView = nextMonthView
        
        nextMonthView  =  MonthView(frame: CGRectMake(frame.size.width * 3.0, 0, frame.size.width,frame.size.height),
            year:ret.year,month:ret.month)
        nextMonthView.monthDelegate = self
        scrollView.addSubview(nextMonthView)
        
        prevMonthView    = tmpView
        
        self.resetContentOffSet()
        
    }
    
    func showPrevView () {
        currentMonth--
        if( currentMonth == 0 ){
            currentMonth = 12
            currentYear--
        }
        let ret = self.getPrevYearAndMonth()
        let tmpView:MonthView = currentMonthView
        currentMonthView = prevMonthView
        
        prevMonthView = MonthView(frame: CGRectMake(0, 0, frame.size.width,frame.size.height),
            year:ret.year,month:ret.month)
        prevMonthView.monthDelegate = self
        scrollView.addSubview(prevMonthView)
        
        nextMonthView    = tmpView
        
        //position調整
        self.resetContentOffSet()
    }
        
    
    func resetContentOffSet () {
        
        //position調整
        prevMonthView.frame = CGRectMake(0, 0, frame.size.width,frame.size.height)
        currentMonthView.frame = CGRectMake(frame.size.width, 0, frame.size.width,frame.size.height)
        nextMonthView.frame = CGRectMake(frame.size.width * 2.0, 0, frame.size.width,frame.size.height)
        
        let scrollViewDelegate:UIScrollViewDelegate = scrollView.delegate!
        scrollView.delegate = nil
        //delegateを呼びたくないので
        scrollView.contentOffset = CGPointMake(frame.size.width, 0.0);
        scrollView.delegate = scrollViewDelegate
    }
    
    func getNextYearAndMonth () -> (year:Int,month:Int){
        var next_year:Int = currentYear
        var next_month:Int = currentMonth + 1
        if next_month > 12 {
            next_month = 1
            next_year++
        }
        return (next_year,next_month)
    }
    
    func getPrevYearAndMonth () -> (year:Int,month:Int){
        var prev_year:Int = currentYear
        var prev_month:Int = currentMonth - 1
        if prev_month == 0 {
            prev_month = 12
            prev_year--
        }
        return (prev_year,prev_month)
    }
    
    func getPrevYearAndMonth2 () -> (year:Int,month:Int){
        var prev_year:Int = currentYear
        var prev_month:Int = currentMonth - 2
        if prev_month < 1 {
            if prev_month == 0 {
                prev_month = 12
            }else if prev_month == -1 {
                prev_month = 11
            }
            prev_year--
        }
        return (prev_year,prev_month)
    }
    
    func pushMonth(checkDateStr:String){
        self.calenderdelegate?.pushCalender(checkDateStr)
    }
    func changeMonth(){
        self.calenderdelegate?.changDateCalender(currentYear,checkMonthInt: currentMonth)
    }
}
