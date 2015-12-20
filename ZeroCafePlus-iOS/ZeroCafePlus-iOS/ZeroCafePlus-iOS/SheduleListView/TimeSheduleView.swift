//
//  TimeSheduleView.swift
//  ExsampleCafe
//
//  Created by Shohei_Hayashi on 2015/12/16.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit

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
        
        checkDateStr = String(format:"%04d/%02d/%02d",year,month,day)
        
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

    }
    
    func makeAlert(sender: UIButton){
        self.hourDelegate?.pushHour(checkDateStr)
    }
}
