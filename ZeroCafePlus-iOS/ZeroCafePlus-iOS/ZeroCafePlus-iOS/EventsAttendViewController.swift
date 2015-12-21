//
//  ViewController.swift
//  zerocafeイベント詳細
//
//  Created by AndroidProject on 2015/12/17.
//  Copyright (c) 2015年 AndroidProject. All rights reserved.
//


/*
タイトル　<- title
時間 <- starttime & endtime
詳細 <- description
tag



*/
import UIKit
import Alamofire
import SwiftyJSON

class EventsAttendViewController: UIViewController {
    
    var backButton: UIBarButtonItem!
    var sanka: UIButton!
    private var myScrollView: UIScrollView!
    
    let eventId = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        
        
        myScrollView = UIScrollView()
        myScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(myScrollView)
        
        
        
        let name: UILabel = UILabel(frame: CGRectMake(0,0,250,200))
        name.text = ""
        name.textAlignment = NSTextAlignment.Center
        name.font = UIFont.systemFontOfSize(CGFloat(30))
        name.layer.position = CGPoint(x: self.view.bounds.width/2, y: 150)
        name.numberOfLines = 0;
        name.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.view.addSubview(name)
        
        
        let date: UILabel = UILabel(frame: CGRectMake(0,0,250,50))
        date.text = ""
        date.font = UIFont.systemFontOfSize(CGFloat(20))
        date.textAlignment = NSTextAlignment.Center
        date.layer.position = CGPoint(x: self.view.bounds.width/2,y: 250)
        self.view.addSubview(date)
        
        
        let time: UILabel = UILabel(frame: CGRectMake(0,0,250,50))
        time.text = ""
        time.font = UIFont.systemFontOfSize(CGFloat(20))
        time.textAlignment = NSTextAlignment.Center
        time.layer.position = CGPoint(x: self.view.bounds.width/2,y: 300)
        self.view.addSubview(time)
        
        
        let tag: UILabel = UILabel(frame: CGRectMake(0,0,250,50))
        tag.text = ""
        tag.textColor = UIColor.grayColor()
        tag.font = UIFont.systemFontOfSize(CGFloat(18))
        tag.textAlignment = NSTextAlignment.Center
        tag.numberOfLines = 0;
        
        tag.lineBreakMode = NSLineBreakMode.ByCharWrapping
        tag.layer.position = CGPoint(x: self.view.bounds.width/2,y: 350)
        self.view.addSubview(tag)
        
        
        let content: UILabel = UILabel(frame: CGRectMake(0,0,300,200))
        content.text = ""
        content.font = UIFont.systemFontOfSize(CGFloat(15))
        content.textAlignment = NSTextAlignment.Center
        content.layer.position = CGPoint(x: self.view.bounds.width/2,y: 410)
        content.numberOfLines = 0;
        content.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.view.addSubview(content)
        
        
        sanka = UIButton()
        sanka.frame = CGRectMake(0,0,300,40)
        sanka.backgroundColor = UIColor.orangeColor()
        sanka.layer.masksToBounds = true
        sanka.setTitle("参加する", forState: UIControlState.Normal)
        sanka.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sanka.layer.cornerRadius = 10.0
        sanka.layer.position = CGPoint(x: self.view.frame.width/2, y:620)
        sanka.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(sanka)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        Alamofire.request(.GET, url)
            .responseJSON { response in
                debugPrint(response.result.value)
                let json = JSON(response.result.value!)
                let eventAraay = json["events"].array! as Array
                for events in eventAraay {
                    let id = events["event"]["id"].int! as Int
                    if self.eventId == id {
                        name.text = events["event"]["title"].string! as String
                        let startTime = events["event"]["start_time"].string! as String
                        let startArray = startTime.componentsSeparatedByString("T")
                        date.text = startArray[0].stringByReplacingOccurrencesOfString("-", withString: "/")
                        let startMinute = startArray[1].substringToIndex(startArray[1].startIndex.advancedBy(5))
                        let endTime = events["event"]["end_time"].string! as String
                        let endArray = endTime.componentsSeparatedByString("T")
                        let endMinute = endArray[1].substringToIndex(endArray[1].startIndex.advancedBy(5))
                        time.text = "\(startMinute)~\(endMinute)"
                        tag.text = events["event"]["tags"].string! as String
                        content.text = events["event"]["description"].string! as String
                    }
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onClickMyButton(sender: UIButton){
        let mySecondViewController = SecondViewController()
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
        
        // Dispose of any resources that can be recreated.
    }
    
    
}

 