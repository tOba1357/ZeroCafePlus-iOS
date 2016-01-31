//
//  ThirdViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by Kento Takemoto on 2015/12/11.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit
import Alamofire

class ThirdViewController: UIViewController, UIScrollViewDelegate,CreateEventDelegate, CheckCalenderDelegate,ScheduleDelegate{
    
    let scrollView = UIScrollView()
    var createEvetView :CreateEventView!
    var checkCalenderView :CheckCalenderView!
    private var scheduleWindow: UIWindow!
    
    let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
    var displayWidth: CGFloat!
    var displayHeight: CGFloat!
    
    var eventName :String!
    var eventExposition :String!
    var eventDate :[String]!
    var evrntStartTime :String!
    var evrntEndTime :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = CGRectMake(34.5, barHeight, self.view.frame.width-69, self.view.frame.height-barHeight)
        scrollView.delegate = self
        scrollView.contentSize   = CGSizeMake(0, 0)
        scrollView.contentOffset = CGPointMake(0.0 , 0.0)
        scrollView.pagingEnabled = false
        self.view.addSubview(scrollView)
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColorFromRGB(0xFFFFFF)
        label.text = "イベントを企画する"
        
        displayWidth = scrollView.frame.size.width
        displayHeight = scrollView.frame.size.height
        
        createEvetView = CreateEventView(frame: CGRectMake(0, 0, scrollView.frame.size.width,displayHeight))
        createEvetView.createEventdelegate = self
        scrollView.addSubview(createEvetView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createEventNameExposition(eventName:String,exposition:String) {
        scrollView.contentSize   = CGSizeMake(0, self.view.frame.height)
        checkCalenderView = CheckCalenderView(frame: CGRectMake(0, displayHeight, scrollView.frame.size.width, displayHeight))
        checkCalenderView.checkCalenderDelegate = self
        scrollView.addSubview(checkCalenderView)
        nextScroll(self.view.frame.size.height)
    }
    
    func checkedCalender(checkDate:[String]){
        eventDate = checkDate
        createSheduleWindow()
    }
    
    func createSheduleWindow(){
        self.view.backgroundColor = UIColor.grayColor()
        self.view.userInteractionEnabled = false

        let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size

        scheduleWindow = UIWindow()
        scheduleWindow.frame = CGRectMake(10, 10, myBoundSize.width-20, myBoundSize.height-20)
        scheduleWindow.backgroundColor = UIColor.grayColor()
        scheduleWindow.layer.masksToBounds = true
        scheduleWindow.layer.cornerRadius = 15
        scheduleWindow.hidden = false
        
        if let scheduleVC = self.storyboard?.instantiateViewControllerWithIdentifier("ScheduleVC") as? ScheduleVC {
            scheduleVC.getDate = eventDate
            scheduleVC.scheduleDelegate = self
            scheduleWindow.rootViewController = scheduleVC
        }
        
        makeKeyAndVisible(scheduleWindow)
        self.scheduleWindow.makeKeyAndVisible()
    }
    
    func closeScheduleWindow(btnTag:Int){
        self.view.userInteractionEnabled = true
        self.view.backgroundColor = UIColor.whiteColor()

        switch btnTag{
        case 1:
            resignKeyWindow(scheduleWindow)
        case 2:
            resignKeyWindow(scheduleWindow)
            nextScroll(self.view.frame.size.height*3)
        default:
            break
        }
    }
    
    func pushEventJson(){
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let parameters:[String : NSDictionary] =
        [
            "event" : [
                "title" : self.eventName,
                "description" : self.eventExposition,
                "belonging" : "スマート大学",
                "entry_fee" : 999,
                "owner_id" : 1,
                "dive_join" : 111,
//                "start_time" : "\(self.getDateArray[0])-\(self.getDateArray[1])-\(self.getDateArray[2])T\(self.getStartTime)",
//                "end_time" : "\(self.getDateArray[0])-\(self.getDateArray[1])-\(self.getDateArray[2])T\(self.getEndTime)",
//                "confirm" : true,
//                "place" : 1,
//                "capacity" : Int(self.numText.text!)!,
//                "category_tag" : self.tagText.text!,
                "genre" : 1,
                "color" : "redBlue"
            ]
        ]
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers:headers)
            .responseString { response in
                debugPrint(response.result.value)
                //"いいよぉ！"が返って来れば成功
        }

    }
    
    func nilAlertAction(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "はい", style: .Default, handler: nil)
        alertController.addAction(otherAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func nextScroll(nextPosY:CGFloat){
        scrollView.contentSize = CGSizeMake(0, nextPosY)
        scrollView.setContentOffset(CGPointMake(0, nextPosY), animated: true)
    }

    func makeKeyAndVisible(myWindow:UIWindow) {
        myWindow.backgroundColor = UIColor.clearColor()
        myWindow.alpha = 0
        UIView.beginAnimations("fade-in", context: nil)
        myWindow.makeKeyAndVisible()
        myWindow.alpha = 1
        UIView.commitAnimations()
    }
    
    func resignKeyWindow(myWindow:UIWindow) {
        myWindow.alpha = 1
        UIView.beginAnimations("fade-out", context: nil)
        myWindow.resignKeyWindow()
        myWindow.alpha = 0
        UIView.commitAnimations()
    }

    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
