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
    
    private var myScrollView:UIScrollView!
    private var name:UILabel!
    private var date: UILabel!
    private var time: UILabel!
    private var tag: UILabel!
    private var content: UILabel!
    private var sanka: UIButton!
    
    var getID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getID)


        
        
        myScrollView = UIScrollView()
        myScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(myScrollView)
        
        name = UILabel(frame: CGRectMake(0,0,250,200))
        name.text = ""
        name.textAlignment = NSTextAlignment.Center
        name.font = UIFont.systemFontOfSize(CGFloat(30))
        name.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/5)
        name.numberOfLines = 0;
        name.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.view.addSubview(name)
        
        
        date = UILabel(frame: CGRectMake(0,0,250,50))
        date.text = ""
        date.font = UIFont.systemFontOfSize(CGFloat(20))
        date.textAlignment = NSTextAlignment.Center
        date.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/3)
        self.view.addSubview(date)
        
        
        time = UILabel(frame: CGRectMake(0,0,250,50))
        time.text = ""
        time.font = UIFont.systemFontOfSize(CGFloat(20))
        time.textAlignment = NSTextAlignment.Center
        time.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/2.5)
        self.view.addSubview(time)
        
        
        tag = UILabel(frame: CGRectMake(0,0,250,50))
        tag.text? = ""
        tag.textColor = UIColor.grayColor()
        tag.font = UIFont.systemFontOfSize(CGFloat(18))
        tag.textAlignment = NSTextAlignment.Center
        tag.numberOfLines = 0;
        tag.lineBreakMode = NSLineBreakMode.ByCharWrapping
        tag.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/2.2)
        self.view.addSubview(tag)
        
        
        content = UILabel(frame: CGRectMake(0,0,300,200))
        content.text = ""
        content.font = UIFont.systemFontOfSize(CGFloat(15))
        content.textAlignment = NSTextAlignment.Center
        content.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/1.8)
        content.numberOfLines = 0;
        content.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.view.addSubview(content)
        
        self.view.backgroundColor = UIColor.whiteColor()

        
        
        sanka = UIButton()
        sanka.frame = CGRectMake(0,0,300,40)
        sanka.backgroundColor = UIColor.orangeColor()
        sanka.layer.masksToBounds = true
        sanka.setTitle("参加する", forState: UIControlState.Normal)
        sanka.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sanka.layer.cornerRadius = 10.0
        sanka.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.bounds.height/1.15)
        sanka.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(sanka)
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    override func viewWillAppear(animated: Bool) {
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                debugPrint(response.result.value)
                
                
                
                
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray {
                    let id = events["event"]["id"].int! as Int
                    if  id == self.getID {
                        print("成功")
                        self.name.text = events["event"]["title"].string! as String
                        let startTime = events["event"]["start_time"].string! as String
                        let startArray = startTime.componentsSeparatedByString("T")
                        self.date.text = startArray[0].stringByReplacingOccurrencesOfString("-", withString: "/")
                        let startMinute = startArray[1].substringToIndex(startArray[1].startIndex.advancedBy(5))
                        let endTime = events["event"]["end_time"].string! as String
                        let endArray = endTime.componentsSeparatedByString("T")
                        let endMinute = endArray[1].substringToIndex(endArray[1].startIndex.advancedBy(5))
                        self.time.text = "\(startMinute)~\(endMinute)"
                        self.tag.text? = events["event"]["category_tag"].string! as String
                        self.content.text = events["event"]["description"].string! as String
                    }
                }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onClickMyButton(sender: UIButton){
        let mySecondViewController = EventsDecideViewController()
        mySecondViewController.MygetID = getID
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
        
        // Dispose of any resources that can be recreated.
    }
    
    
}

 