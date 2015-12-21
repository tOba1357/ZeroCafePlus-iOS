//
//  DayScheduleVC.swift
//  ExsampleCafeVer2
//
//  Created by Shohei_Hayashi on 2015/12/18.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIToolbarDelegate, SheduleAlertDelegate{
    
    var sheduleAlertView:SheduleAlertView!
    
    var titleLabel:UILabel!
    var getDate :[String]!
    var myTextField:UITextField!
    var hourTextField:UITextField!
    var minuteTextField:UITextField!
    
    var pickHour:[String] = []
    var pickMinute:[String] = []
    
    var alertHour:String!
    var alertMinute:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertMinute = "00"
        
        for i in 8...21{
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
        }else if (component == 1){
            picMinuteStr = pickMinute[row]
        }
        if pickerView.tag == 1{
            hourTextField.text = "\(picHourStr):\(picMinuteStr)"
        }
        if pickerView.tag == 2{
            minuteTextField.text = "\(picHourStr):\(picMinuteStr)"
        }
        alertHour = picHourStr
        alertMinute = picMinuteStr
    }
    func onClick(sender: UIBarButtonItem) {
        myTextField.resignFirstResponder()
    }
    
    func pushSheduleAlert(checkDateStr:String){
        
        let checkData = checkDateStr.componentsSeparatedByString("/")
        alertHour = checkData[3]
        
        let myToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        myToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        myToolBar.backgroundColor = UIColor.blackColor()
        myToolBar.barStyle = UIBarStyle.Black
        myToolBar.tintColor = UIColor.whiteColor()
        
        let myToolBarButton = UIBarButtonItem(title: "Close", style: .Bordered, target: self, action: "onClick:")
        myToolBarButton.tag = 1
        myToolBar.items = [myToolBarButton]
        
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
            text.tag = 1
            self.hourTextField = text
            text.inputView = pickerView1
            text.inputAccessoryView = myToolBar
            text.leftViewMode = UITextFieldViewMode.Always
        })
        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.placeholder = "second textField"
            let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 60))
            label.text = "終了"
            text.leftView = label
            self.minuteTextField = text
            text.inputView = pickerView2
            text.inputAccessoryView = myToolBar
            text.leftViewMode = UITextFieldViewMode.Always
            
        })
        
        let otherAction = UIAlertAction(title: "はい", style: .Default) {
            action in
            NSLog("はいボタンが押されました")
            if let createEventVC = self.storyboard?.instantiateViewControllerWithIdentifier("CreateEventVC") as? CreateEventVC {
                self.navigationController?.pushViewController(createEventVC, animated: true)
            }
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
