//
//  EventsDetailViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by 紺谷和正 on 2015/12/20.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EventsDetailViewController: UIViewController {
    
    private var myScrollView:UIScrollView!
    private var cancelButton: UIButton!
    private var name:UILabel!
    private var date: UILabel!
    private var time: UILabel!
    private var tag: UILabel!
    private var content: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        myScrollView = UIScrollView()
        myScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(myScrollView)
        
        
        
        name = UILabel(frame: CGRectMake(0,0,250,200))
        name.text = ""
        name.textAlignment = NSTextAlignment.Center
        name.font = UIFont.systemFontOfSize(CGFloat(30))
        name.layer.position = CGPoint(x: self.view.bounds.width/2, y: 150)
        name.numberOfLines = 0;
        name.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.view.addSubview(name)
        
        
        date = UILabel(frame: CGRectMake(0,0,250,50))
        date.text = ""
        date.font = UIFont.systemFontOfSize(CGFloat(20))
        date.textAlignment = NSTextAlignment.Center
        date.layer.position = CGPoint(x: self.view.bounds.width/2,y: 250)
        self.view.addSubview(date)
        
        
        time = UILabel(frame: CGRectMake(0,0,250,50))
        time.text = ""
        time.font = UIFont.systemFontOfSize(CGFloat(20))
        time.textAlignment = NSTextAlignment.Center
        time.layer.position = CGPoint(x: self.view.bounds.width/2,y: 300)
        self.view.addSubview(time)
        
        
        tag = UILabel(frame: CGRectMake(0,0,250,50))
        tag.text = ""
        tag.textColor = UIColor.grayColor()
        tag.font = UIFont.systemFontOfSize(CGFloat(18))
        tag.textAlignment = NSTextAlignment.Center
        tag.numberOfLines = 0;
        
        tag.lineBreakMode = NSLineBreakMode.ByCharWrapping
        tag.layer.position = CGPoint(x: self.view.bounds.width/2,y: 350)
        self.view.addSubview(tag)
        
        
        content = UILabel(frame: CGRectMake(0,0,300,200))
        content.text = ""
        content.font = UIFont.systemFontOfSize(CGFloat(15))
        content.textAlignment = NSTextAlignment.Center
        content.layer.position = CGPoint(x: self.view.bounds.width/2,y: 410)
        content.numberOfLines = 0;
        content.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.view.addSubview(content)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        cancelButton = UIButton(frame: CGRectMake(0,0,screenWidth/1.1,screenHeight/12))
        cancelButton.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/1.11)
        cancelButton.layer.cornerRadius = 15.0
        cancelButton.backgroundColor = UIColor.grayColor()
        cancelButton.addTarget(self, action: "willCancel:", forControlEvents: .TouchUpInside)
        cancelButton.setTitle("キャンセル連絡をする", forState: .Normal)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(cancelButton)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                debugPrint(response.result.value)
                let json = JSON(response.result.value!)
                let eventAraay = json["events"].array! as Array
                for events in eventAraay {
                    let id = events["event"]["id"].int! as Int
                    if  id == 1 {
                        self.name.text = events["event"]["title"].string! as String
                        let startTime = events["event"]["start_time"].string! as String
                        let startArray = startTime.componentsSeparatedByString("T")
                        self.date.text = startArray[0].stringByReplacingOccurrencesOfString("-", withString: "/")
                        let startMinute = startArray[1].substringToIndex(startArray[1].startIndex.advancedBy(5))
                        let endTime = events["event"]["end_time"].string! as String
                        let endArray = endTime.componentsSeparatedByString("T")
                        let endMinute = endArray[1].substringToIndex(endArray[1].startIndex.advancedBy(5))
                        self.time.text = "\(startMinute)~\(endMinute)"
                        self.tag.text = events["event"]["category_tag"].string! as String
                        self.content.text = events["event"]["description"].string! as String
                    }
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func willCancel(sender: UIButton){
        let cancelAlert: UIAlertController = UIAlertController(title: "キャンセル連絡をする", message: "ゼロカフェ", preferredStyle: .Alert)
        
        let noAction = UIAlertAction(title: "キャンセル", style: .Default, handler: { action in
            print("cancel")
        })
        let okAction = UIAlertAction(title: "かける", style: .Default) { action in
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://0000000000")!)        }
        
        cancelAlert.addAction(noAction)
        cancelAlert.addAction(okAction)
        
        presentViewController(cancelAlert, animated: true, completion: nil)
        
    }
}
