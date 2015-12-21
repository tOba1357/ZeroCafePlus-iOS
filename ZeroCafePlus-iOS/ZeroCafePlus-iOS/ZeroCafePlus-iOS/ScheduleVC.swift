//
//  DayScheduleVC.swift
//  ExsampleCafeVer2
//
//  Created by Shohei_Hayashi on 2015/12/18.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController , SheduleAlertDelegate{
    
    var sheduleAlertView:SheduleAlertView!
    
    var titleLabel:UILabel!
    var getDate :[String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func pushSheduleAlert(checkDateStr:String){
        
        print("aaa")
        let alertController = UIAlertController(title: "確認", message: "これでよろしいですか？", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.placeholder = "first textField"
            let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 60))
            label.text = "開始"
            text.leftView = label
            text.leftViewMode = UITextFieldViewMode.Always
        })
        alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.placeholder = "second textField"
            let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 60))
            label.text = "終了"
            text.leftView = label
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
