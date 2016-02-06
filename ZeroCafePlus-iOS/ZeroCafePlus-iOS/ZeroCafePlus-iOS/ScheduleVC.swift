//
//  DayScheduleVC.swift
//  ExsampleCafeVer2
//
//  Created by Shohei_Hayashi on 2015/12/18.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit

protocol ScheduleDelegate{
    func closeScheduleWindow(btnTag:Int)
    func createMyTime(startTimeStr:String,endTimeStr:String)
}

class ScheduleVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIToolbarDelegate, SheduleAlertDelegate{
    
    var sheduleAlertView:SheduleAlertView!
    
    var titleLabel:UILabel!
    var myTextField:UITextField!
    var startTimeTextField:UITextField!
    var endTimeTextField:UITextField!
    var nextButton :UIButton!
    var closeButton :UIButton!
    
    var getDate :[String]!
    var getTitle:String!
    var getDetail:String!
    
    var pickHour:[String] = []
    var pickMinute:[String] = []
    
    var alertHour:String!
    var alertMinute:String!
    
    var scheduleDelegate:ScheduleDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 11...21{
            let iStr = String(format:"%2d",i)
            pickHour.append(iStr)
        }
        
        for i in 0...60{
            let iStr = String(format:"%02d",i)
            pickMinute.append(iStr)
        }
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0xFFFFFF)
        label.text = "イベントを企画する"
        self.navigationItem.titleView = label
        
        titleLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height/10))
        titleLabel.text = "\(getDate[0])/\(getDate[1])/\(getDate[2])"
        titleLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/5)
        
        
        sheduleAlertView = SheduleAlertView(frame: CGRectMake(self.view.frame.width/20,self.view.frame.height/4,self.view.frame.width/10*9, self.view.frame.height/5*3), year: Int(getDate[0])!, month: Int(getDate[1])!, day: Int(getDate[2])!)
        sheduleAlertView.sheduleAlertDelegate = self
        
        closeButton = UIButton(frame: CGRectMake(0, 0, 300, 50))
        closeButton.backgroundColor = UIColor.redColor()
        closeButton.tag = 1
        closeButton.setTitle("とじる", forState: UIControlState.Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        closeButton.addTarget(self, action: "closeAction:", forControlEvents: .TouchUpInside)
        closeButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.size.height/10*9)
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(sheduleAlertView)
        self.view.addSubview(closeButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //pickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0){
            return pickHour.count
        }else if (component == 1){
            return pickMinute.count
        }
        return 0
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0){
            return pickHour[row]
        }else if (component == 1){
            return pickMinute[row]
        }
        return ""
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var picHourStr = alertHour
        var picMinuteStr = alertMinute
        if (component == 0){
            picHourStr = pickHour[row] as String
            alertHour = pickHour[row] as String
        }else if (component == 1){
            picMinuteStr = pickMinute[row] as String
            alertMinute = pickMinute[row] as String
        }
        if pickerView.tag == 1{
            startTimeTextField.text = "\(picHourStr):\(picMinuteStr)"
        }
        if pickerView.tag == 2{
            endTimeTextField.text = "\(picHourStr):\(picMinuteStr)"
        }
    }
    
    func pushSheduleAlert(checkDateStr:String,myDateArray:[Int],alreadyStertTimeData:[String],alreadyEndTimeData:[String]){
        
        let checkData = checkDateStr.componentsSeparatedByString("/")
        alertHour = checkData[3]
        alertMinute = "00"
        
        let pickerView1 = UIPickerView()
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.tag = 1
        
        let pickerView2 = UIPickerView()
        pickerView2.delegate = self
        pickerView2.dataSource = self
        pickerView2.tag = 2
        
        let alertController = UIAlertController(title: "確認", message: "これでよろしいですか？", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.placeholder = "first textField"
            let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 60))
            label.text = "開始"
            text.leftView = label
            text.text = "\(checkData[3]):00"
            text.tag = 1
            self.startTimeTextField = text
            text.inputView = pickerView1
            text.leftViewMode = UITextFieldViewMode.Always
        })
        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.placeholder = "second textField"
            let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 60))
            label.text = "終了"
            text.leftView = label
            text.text = "\(Int(checkData[3])!+1):00"
            self.endTimeTextField = text
            text.inputView = pickerView2
            text.leftViewMode = UITextFieldViewMode.Always
            
        })
        
        let otherAction = UIAlertAction(title: "はい", style: .Default) {
            action in
            
            var timeBool = true
            
            if self.startTimeTextField.text != nil && self.endTimeTextField.text != nil{
                
                let startTimeData = self.startTimeTextField.text!.componentsSeparatedByString(":")
                let endTimeData = self.endTimeTextField.text!.componentsSeparatedByString(":")
                
                if Int(endTimeData[0]) <= Int(startTimeData[0]) || (Int(endTimeData[0]) == Int(startTimeData[0]) && Int(endTimeData[1]) <= Int(startTimeData[1])){
                    timeBool = false
                }
                
                for aStartTimeStr in alreadyStertTimeData.enumerate() {
                    
                    let aStartTimeData = aStartTimeStr.element.componentsSeparatedByString(":")
                    let aEndTimeData = alreadyEndTimeData[aStartTimeStr.index].componentsSeparatedByString(":")
                    
                    //timeCheck
                    //Hour Conflict
                    if (Int(aStartTimeData[0]) > Int(startTimeData[0]) && Int(aStartTimeData[0]) < Int(endTimeData[0])) ||
                        (Int(aEndTimeData[0]) > Int(startTimeData[0]) && Int(aEndTimeData[0]) <  Int(endTimeData[0]))
                    {
                        timeBool = false
                    }
                    
                    //Start Minuts Conflict
                    if Int(startTimeData[0]) == Int(aStartTimeData[0])
                    {
                        if Int(aStartTimeData[1]) >= Int(startTimeData[1]) &&
                            (Int(aEndTimeData[0]) < Int(endTimeData[0]) ||
                                (Int(aEndTimeData[0]) == Int(endTimeData[0]) && Int(aEndTimeData[1]) <= Int(endTimeData[1])))
                        {
                            timeBool = false
                        }
                    }
                    
                    //End Minuts Conflict
                    if Int(endTimeData[0]) == Int(aEndTimeData[0])
                    {
                        if Int(aEndTimeData[1]) <= Int(endTimeData[1]) &&
                            (Int(aStartTimeData[0]) > Int(startTimeData[0]) ||
                                (Int(aStartTimeData[0]) == Int(startTimeData[0]) && Int(aStartTimeData[1]) >= Int(startTimeData[1])))
                        {
                            timeBool = false
                        }
                    }
                    
                    //Start aEnd Minuts Conflict
                    if (Int(aEndTimeData[0]) == Int(startTimeData[0]) && Int(aEndTimeData[1]) > Int(startTimeData[1])) &&
                        (Int(aEndTimeData[0]) < Int(endTimeData[0]) ||
                            (Int(aEndTimeData[0]) == Int(endTimeData[0]) && Int(aEndTimeData[1]) <= Int(endTimeData[1])))
                    {
                        timeBool = false
                    }
                    
                    //aStart End Minuts Conflict
                    if (Int(aStartTimeData[0]) == Int(endTimeData[0]) && Int(aStartTimeData[1]) > Int(endTimeData[1])) &&
                        (Int(aEndTimeData[0]) > Int(endTimeData[0]) ||
                            (Int(aEndTimeData[0]) == Int(endTimeData[0]) && Int(aEndTimeData[1]) >= Int(endTimeData[1])))
                    {
                        timeBool = false
                    }
                    
                }
            }
            if timeBool{
                self.sheduleAlertView.createMyTimeSchedule(self.startTimeTextField.text!, endTime:self.endTimeTextField.text!)
                
                self.nextButton = UIButton(frame: CGRectMake(0, 0, 150, 50))
                self.nextButton.backgroundColor = UIColor.orangeColor()
                self.nextButton.tag = 2
                self.nextButton.setTitle("決定する", forState: UIControlState.Normal)
                self.nextButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                self.nextButton.addTarget(self, action: "closeAction:", forControlEvents: .TouchUpInside)
                self.nextButton.layer.position = CGPoint(x: self.view.frame.width/4*3, y:self.view.frame.size.height/10*9)
                self.view.addSubview(self.nextButton)
                
                self.closeButton.frame = CGRectMake(0, 0, 150, 50)
                self.closeButton.layer.position = CGPoint(x: self.view.frame.width/4, y:self.view.frame.size.height/10*9)
                self.view.addSubview(self.closeButton)
                
            }else{
                print("miss time")
            }
        }
        
        
        let cancelAction = UIAlertAction(title: "いいえ", style: .Cancel, handler:nil)
        
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func closeAction(sender: UIButton){
        if sender.tag == 2{
            self.scheduleDelegate.createMyTime(self.startTimeTextField.text!, endTimeStr: self.endTimeTextField.text!)
        }
        self.scheduleDelegate.closeScheduleWindow(sender.tag)
    }
    
    func changDateShedule(myDateStr:String){
        titleLabel.text = myDateStr
    }
    
    
}