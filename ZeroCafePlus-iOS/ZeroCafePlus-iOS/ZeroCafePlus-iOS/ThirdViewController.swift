//
//  ThirdViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by Kento Takemoto on 2015/12/11.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit
import Alamofire

class ThirdViewController: UIViewController, UIScrollViewDelegate,CreateEventDelegate, CheckCalenderDelegate,ScheduleDelegate,CreateEventDetailDelegate,FinalDecisionEventAlertDelegate{
    
    let scrollView = UIScrollView()
    var createEvetView :CreateEventView!
    var checkCalenderView :CheckCalenderView!
    var createEventDetailView :CreateEventDetailView!
    private var alertWindow : UIWindow!
    
    let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
    var displayWidth: CGFloat!
    var displayHeight: CGFloat!
    
    var eventName :String!
    var eventExposition :String!
    var eventGenre:Int!
    var eventDate :[String]!
    var eventStartTime :String!
    var eventEndTime :String!
    var eventBelonging:String!
    var eventDiveJoin:Bool!
    var eventMenberNum:Int!
    var eventTag:String!
    
    var waitAC:UIAlertController!
    
    let myBoundSize: CGSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeView(){
        scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        scrollView.delegate = self
        
        scrollView.contentSize   = CGSizeMake(0, 0)
        scrollView.contentOffset = CGPointMake(0.0 , 0.0)
        self.view.addSubview(scrollView)
        
        let thirdTitle:UILabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        thirdTitle.textAlignment = NSTextAlignment.Center
        thirdTitle.font = UIFont.boldSystemFontOfSize(21)
        thirdTitle.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        thirdTitle.text = "イベントを企画する"
        thirdTitle.layer.position = CGPointMake(self.view.frame.size.width/2, barHeight+thirdTitle.frame.size.height/2)
        
        displayWidth = scrollView.frame.size.width
        displayHeight = scrollView.frame.size.height
        
        createEvetView = CreateEventView(frame: CGRectMake(self.view.frame.size.width*(46/640), 0, self.view.frame.width-self.view.frame.size.width*(92/640),displayHeight))
        createEvetView.createEventdelegate = self
        
        scrollView.addSubview(thirdTitle)
        scrollView.addSubview(createEvetView)

    }
    
    func createEventNameExposition() {
        checkCalenderView = CheckCalenderView(frame: CGRectMake(self.view.frame.size.width*(46/640), displayHeight, scrollView.frame.size.width-self.view.frame.size.width*(92/640), displayHeight))
        checkCalenderView.checkCalenderDelegate = self
        nextScroll(self.view.frame.size.height,count: 2)
        scrollView.addSubview(checkCalenderView)
    }
    
    func checkedCalender(checkDate:[String]){
        eventDate = checkDate
        createSheduleWindow()
    }
    
    func createSheduleWindow(){
        self.view.backgroundColor = UIColor.grayColor()
        self.view.userInteractionEnabled = false

        alertWindow = UIWindow()
        alertWindow.frame = CGRectMake(10, 10, myBoundSize.width-20, myBoundSize.height-20)
        alertWindow.backgroundColor = UIColor.grayColor()
        alertWindow.layer.masksToBounds = true
        alertWindow.layer.cornerRadius = 15
        alertWindow.hidden = false
        UIView.animateWithDuration(0.2, animations: {
            self.tabBarController?.tabBar.hidden = true
        })
        
        if let scheduleVC = self.storyboard?.instantiateViewControllerWithIdentifier("ScheduleVC") as? ScheduleVC {
            scheduleVC.getDate = eventDate
            scheduleVC.scheduleDelegate = self
            alertWindow.rootViewController = scheduleVC
        }
        
        makeKeyAndVisible(alertWindow)
        self.alertWindow.makeKeyAndVisible()
    }
    
    func createMyTime(startTimeStr:String,endTimeStr:String){
        eventStartTime = startTimeStr
        eventEndTime = endTimeStr
    }
    
    func closeScheduleWindow(btnTag:Int){
        UIView.animateWithDuration(0.2, animations: {
            self.tabBarController?.tabBar.hidden = false
        })

        self.view.userInteractionEnabled = true
        self.view.backgroundColor = UIColor.whiteColor()

        switch btnTag{
        case 1:
            resignKeyWindow(alertWindow)
        case 2:
            resignKeyWindow(alertWindow)
            nextScroll(self.view.frame.size.height,count: 3)
            createEventDetailView = CreateEventDetailView(frame: CGRectMake(self.view.frame.size.width*(46/640), displayHeight*2, scrollView.frame.size.width-self.view.frame.size.width*(92/640),displayHeight))
            createEventDetailView.createEventDetailDelegate = self
            scrollView.addSubview(createEventDetailView)
        default:
            break
        }
    }
    
    func decideEventDetail(assetStr:String,menberNumStr:String,diveJoinBool:Bool,tagStr:String){
        eventBelonging = assetStr
        eventMenberNum = Int(menberNumStr)
        eventDiveJoin = diveJoinBool
        eventTag = tagStr
        createEvetView.postEventDate()
    }
    
    func getEventNameExposition(name:String,exposition:String,genreNum:Int){
        eventName = name
        eventExposition = exposition
        eventGenre = genreNum
        
        self.view.backgroundColor = UIColor.grayColor()
        self.view.userInteractionEnabled = false

        alertWindow = UIWindow()
        alertWindow.frame = CGRectMake(10, 10, myBoundSize.width-20, myBoundSize.height-20)
        alertWindow.backgroundColor = UIColor.grayColor()
        alertWindow.layer.masksToBounds = true
        alertWindow.layer.cornerRadius = 15
        alertWindow.hidden = false
        
        UIView.animateWithDuration(0.2, animations: {
            self.tabBarController?.tabBar.hidden = true
        })
        
        if let finalDecisionEventAlertVC = self.storyboard?.instantiateViewControllerWithIdentifier("FinalDecisionEventAlertVC") as? FinalDecisionEventAlertVC {
            
            finalDecisionEventAlertVC.lastCheckEventDelegate = self
            finalDecisionEventAlertVC.eventName = eventName
            finalDecisionEventAlertVC.eventExposition = eventExposition
            finalDecisionEventAlertVC.eventGenre = eventGenre
            finalDecisionEventAlertVC.eventDate = eventDate
            finalDecisionEventAlertVC.eventStartTime = eventStartTime
            finalDecisionEventAlertVC.eventEndTime = eventEndTime
            finalDecisionEventAlertVC.eventBelonging = eventBelonging
            finalDecisionEventAlertVC.eventDiveJoin = eventDiveJoin
            finalDecisionEventAlertVC.eventMenberNum = eventMenberNum
            finalDecisionEventAlertVC.eventTag = eventTag

            alertWindow.rootViewController = finalDecisionEventAlertVC
        }
        
        makeKeyAndVisible(alertWindow)
        self.alertWindow.makeKeyAndVisible()
    }
    
    func closeDecisionEventWindow(btnTag:Int){
        UIView.animateWithDuration(0.2, animations: {
            self.tabBarController?.tabBar.hidden = false
        })
        
        self.view.userInteractionEnabled = true
        self.view.backgroundColor = UIColor.whiteColor()
        
        switch btnTag{
        case 1:
            resignKeyWindow(alertWindow)
        case 2:
            resignKeyWindow(alertWindow)
            pushCreateEventJson()
        default:
            break
        }
    }

    
    func pushCreateEventJson(){
    
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let parameters:[String : NSDictionary] =
        [
            "event" : [
                "title" : self.eventName,
                "description" : self.eventExposition,
                "belonging" : "\(eventBelonging)",
                "entry_fee" : 999,
                "owner_id" : 1,
                "dive_join" : eventDiveJoin,
                "start_time" : "\(self.eventDate[0])-\(self.eventDate[1])-\(self.eventDate[2])T\(self.eventStartTime)",
                "end_time" : "\(self.eventDate[0])-\(self.eventDate[1])-\(self.eventDate[2])T\(self.eventEndTime)",
                "confirm" : false,
                "place" : 0,
                "capacity" : eventMenberNum,
                "category_tag" : "\(eventTag)",
                "genre" : self.eventGenre,
                "color" : "redBlue"
            ]
        ]
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON, headers:headers)
            .responseString { response in
                debugPrint(response.result.value)
        }
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        makeView()
    }
    
    func presentWaitAlertAction(){
        waitAC = AlertFunction().displayPendingAlert()
        self.presentViewController(waitAC, animated: true, completion: nil)
    }

    func dismissWaitAlertAction(){
        AlertFunction().hidePendingAlert(waitAC)
    }
    
    func nilAlertAction(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let otherAction = UIAlertAction(title: "はい", style: .Default, handler: nil)
        alertController.addAction(otherAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func nextScroll(nextPosY:CGFloat,count:CGFloat){
        scrollView.contentSize = CGSizeMake(0, nextPosY*count)
        scrollView.setContentOffset(CGPointMake(0, nextPosY*(count-1)), animated: true)
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
}
