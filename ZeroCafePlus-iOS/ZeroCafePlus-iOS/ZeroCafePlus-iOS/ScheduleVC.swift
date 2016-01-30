//
//  DayScheduleVC.swift
//  ExsampleCafeVer2
//
//  Created by Shohei_Hayashi on 2015/12/18.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit

//protocol ScheduleDelegate{
//    func timePickerAlert(checkDateStr:String)
//    func decideStartEndTime(statTime:String,endTime:String)
//}

class ScheduleVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIToolbarDelegate, SheduleAlertDelegate{
    
    var sheduleAlertView:SheduleAlertView!
    
    var titleLabel:UILabel!
    var myTextField:UITextField!
    var hourTextField:UITextField!
    var minuteTextField:UITextField!
    
    var getDate :[String]!
    var getTitle:String!
    var getDetail:String!
    
    var pickHour:[String] = []
    var pickMinute:[String] = []
    
    var alertHour:String!
    var alertMinute:String!
    
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
        label.textColor = UIColorFromRGB(0xFFFFFF)
        label.text = "イベントを企画する"
        self.navigationItem.titleView = label
        
        titleLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width/2, self.view.frame.size.height/10))
        titleLabel.text = "\(getDate[0])/\(getDate[1])/\(getDate[2])"
        titleLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/5)
        
        
        sheduleAlertView = SheduleAlertView(frame: CGRectMake(0,0,self.view.frame.width/10*9, self.view.frame.height/5*3), year: Int(getDate[0])!, month: Int(getDate[1])!, day: Int(getDate[2])!)
        sheduleAlertView.sheduleAlertDelegate = self
        sheduleAlertView.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/7*4)
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(sheduleAlertView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
            hourTextField.text = "\(picHourStr):\(picMinuteStr)"
        }
        if pickerView.tag == 2{
            minuteTextField.text = "\(picHourStr):\(picMinuteStr)"
        }
    }

    func pushSheduleAlert(checkDateStr:String,myDateArray:[Int]){
        
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
            self.hourTextField = text
            text.inputView = pickerView1
            text.leftViewMode = UITextFieldViewMode.Always
        })
        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.placeholder = "second textField"
            let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 60))
            label.text = "終了"
            text.leftView = label
            text.text = "\(Int(checkData[3])!+1):00"
            self.minuteTextField = text
            text.inputView = pickerView2
            text.leftViewMode = UITextFieldViewMode.Always
            
        })
        
        let otherAction = UIAlertAction(title: "はい", style: .Default) {
            action in
            NSLog("はいボタンが押されました")
//            if let createEventVC = self.storyboard?.instantiateViewControllerWithIdentifier("CreateEventVC") as? CreateEventVC {
//                createEventVC.getTitle = self.getTitle
//                createEventVC.getDetail = self.getDetail
//                createEventVC.getDateArray = myDateArray
//                createEventVC.getStartTime = self.hourTextField.text
//                createEventVC.getEndTime = self.minuteTextField.text
//                self.navigationController?.pushViewController(createEventVC, animated: true)
//            }
            
        }
        let cancelAction = UIAlertAction(title: "いいえ", style: .Cancel) {
            action in
            NSLog("いいえボタンが押されました")
        }
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    func changDateShedule(myDateStr:String){
        titleLabel.text = myDateStr
    }
}