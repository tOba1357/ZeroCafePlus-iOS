//
//  ViewController.swift
//  zerocafeイベント詳細
//
//  Created by AndroidProject on 2015/12/17.
//  Copyright (c) 2015年 AndroidProject. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Accounts




class EventsAttendViewController: UIViewController {
    
    private var myScrollView:UIScrollView!
    private var name:UILabel!
    private var date: UILabel!
    private var time: UILabel!
    private var tag: UILabel!
    private var content: UILabel!
    private var sankaButton: UIButton!
    private var FriendTellButton: UIButton!
    private var kikaku: UILabel!
    private var sanka: UILabel!
    private var line: UILabel!
    private var event_detail_calendar: UIImageView!
    private var event_detail_clock: UIImageView!
    private var event_detail_tag: UIImageView!
    
    var getID: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        myScrollView = UIScrollView()
        myScrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        myScrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.bounds.height*1.3)
        myScrollView.contentOffset = CGPointMake(0, 0)
        myScrollView.pagingEnabled = false
        self.view.addSubview(myScrollView)
//        myScrollView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addConstraints([
//            NSLayoutConstraint(item: myScrollView, attribute: .Width,    relatedBy: .Equal, toItem: nil,   attribute: .Width, multiplier: 1, constant: self.view.bounds.width),
//            NSLayoutConstraint(item: myScrollView, attribute: .Top,   relatedBy: .Equal, toItem: self.view, attribute: .Top,   multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: myScrollView, attribute: .Bottom,   relatedBy: .Equal, toItem: sanka, attribute: .Bottom,   multiplier: 1, constant: self.view.bounds.height/21.04),
//            
//            ])
//        
        
        
        name = UILabel(frame: CGRectMake(0,self.view.bounds.height/11.36,self.view.bounds.width/1.24,self.view.bounds.height/35.5))
        name.text = ""
        name.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        name.textAlignment = NSTextAlignment.Center
        name.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/35.5)
        name.layer.position.x = CGFloat(self.view.bounds.width/2)
        name.lineBreakMode = NSLineBreakMode.ByCharWrapping
        myScrollView.addSubview(name)
        
        
        line = UILabel(frame: CGRectMake(0,0,0,0))
        line.backgroundColor = UIColor.blackColor()
        myScrollView.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: line, attribute: .Top,    relatedBy: .Equal, toItem: name,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/71),
            NSLayoutConstraint(item: line, attribute: .Left,   relatedBy: .Equal, toItem: name, attribute: .Left,   multiplier: 1, constant: 0),
            NSLayoutConstraint(item: line, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width/1.24),
            NSLayoutConstraint(item: line, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/1136)
            ])
        
        
        
        event_detail_calendar = UIImageView(frame: CGRectMake(0,0,0,0))
        let detail_calendar = UIImage(named: "event_detail_calendar.png")
        event_detail_calendar.frame = CGRectMake(0, 0, 0, 0)
        event_detail_calendar.image = detail_calendar
        myScrollView.addSubview(event_detail_calendar)
        event_detail_calendar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: event_detail_calendar, attribute: .Top,    relatedBy: .Equal, toItem: line,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/22.72),
            NSLayoutConstraint(item: event_detail_calendar, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/9.14),
            NSLayoutConstraint(item: event_detail_calendar, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width/18.18),
            NSLayoutConstraint(item: event_detail_calendar, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/32.45)
            ])
        
        
        date = UILabel(frame: CGRectMake(self.view.bounds.width/4.18,self.view.bounds.height/6.01,self.view.bounds.width,self.view.bounds.height/37.86))
        date.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        date.text = ""
        date.font = UIFont.systemFontOfSize(CGFloat(self.view.bounds.height/37.86))
        date.lineBreakMode = NSLineBreakMode.ByCharWrapping
        myScrollView.addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: date, attribute: .Top,    relatedBy: .Equal, toItem: line,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/22.72),
            NSLayoutConstraint(item: date, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/4.57),
            
            ])
        
        
        
        event_detail_clock = UIImageView(frame: CGRectMake(0,0,100,120))
        let detail_clock = UIImage(named: "event_detail_clock.png")
        event_detail_clock.frame = CGRectMake(0, self.view.bounds.height/4.34, self.view.bounds.width/17.78, self.view.bounds.height/31.56)
        event_detail_clock.image = detail_clock
        event_detail_clock.layer.position.x = CGFloat(self.view.bounds.width/7)
        myScrollView.addSubview(event_detail_clock)
        event_detail_clock.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: event_detail_clock, attribute: .Top,    relatedBy: .Equal, toItem: date,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/26.42),
            NSLayoutConstraint(item: event_detail_clock, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/9.14),
            NSLayoutConstraint(item: event_detail_clock, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width/17.78),
            NSLayoutConstraint(item: event_detail_clock, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/31.55)
            ])
        
        
        
        time = UILabel(frame: CGRectMake(self.view.bounds.width/4.2,self.view.bounds.height/4.34,self.view.bounds.width,self.view.bounds.height/37.86))
        time.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        time.text = ""
        time.font = UIFont.systemFontOfSize(CGFloat(self.view.bounds.height/37.86))
        time.lineBreakMode = NSLineBreakMode.ByCharWrapping
        myScrollView.addSubview(time)
        time.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: time, attribute: .Top,    relatedBy: .Equal, toItem: date,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/26.42),
            NSLayoutConstraint(item: time, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/4.57),
            
            ])
        
        
        
        content = UILabel(frame: CGRectMake(0,0,0,0))
        content.text = ""
        content.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        content.font = UIFont.systemFontOfSize(CGFloat(self.view.bounds.height/40.57))
        let attributedText = NSMutableAttributedString(string: self.content.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = self.view.bounds.height/25.24
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        self.content.attributedText = attributedText
        content.lineBreakMode = NSLineBreakMode.ByCharWrapping
        content.numberOfLines = 0
        content.sizeToFit()
        myScrollView.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: content, attribute: .Top,    relatedBy: .Equal, toItem: time,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/22.72),
            NSLayoutConstraint(item: content, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
            NSLayoutConstraint(item: content, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width/1.23),
            ])
        
        
        
        event_detail_tag = UIImageView(frame: CGRectMake(0,0,100,120))
        let detail_tag = UIImage(named: "event_detail_tag.png")
        event_detail_tag.frame = CGRectMake(0, self.view.bounds.height/1.13 - self.view.bounds.height/9.47, self.view.bounds.width/14.22, self.view.bounds.height/39.17)
        event_detail_tag.image = detail_tag
        event_detail_tag.layer.position.x = CGFloat(self.view.bounds.width/6.6)
        myScrollView.addSubview(event_detail_tag)
        event_detail_tag.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: event_detail_tag, attribute: .Top,    relatedBy: .Equal, toItem: content,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/20.65),
            NSLayoutConstraint(item: event_detail_tag, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/9.14),
            NSLayoutConstraint(item: event_detail_tag, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width/14.22),
            NSLayoutConstraint(item: event_detail_tag, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/39.17)
            ])
        
        
        
        tag = UILabel(frame: CGRectMake(self.view.bounds.width/4,self.view.bounds.height/1.13 - self.view.bounds.height/9.47,self.view.bounds.width/1.6,0))
        tag.text = ""
        tag.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        tag.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/42.07)
        tag.numberOfLines = 0
        tag.sizeToFit()
        tag.lineBreakMode = NSLineBreakMode.ByCharWrapping
        myScrollView.addSubview(tag)
        tag.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: tag, attribute: .Top,    relatedBy: .Equal, toItem: content,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/20.65),
            NSLayoutConstraint(item: tag, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/4),
            NSLayoutConstraint(item: tag, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width/1.6),
            
            
            ])
        
        
        
        let sankaButtonImage: UIImage = UIImage(named: "event_detail_rounded.png")!
        sankaButton = UIButton()
        sankaButton.frame = CGRectMake(0,0,0,0)
        sankaButton.setBackgroundImage(sankaButtonImage, forState: UIControlState.Normal);
        sankaButton.setTitle("", forState: UIControlState.Normal)
        sankaButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sankaButton.titleLabel?.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/37.86)
        sankaButton.addTarget(self, action: "onClickSankaButton:", forControlEvents: .TouchUpInside)
        myScrollView.addSubview(sankaButton)
        sankaButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: sankaButton, attribute: .Top,    relatedBy: .Equal, toItem: tag,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/20.65),
            NSLayoutConstraint(item: sankaButton, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
            NSLayoutConstraint(item: sankaButton, attribute: .Right,   relatedBy: .Equal, toItem: self.view, attribute: .Right,   multiplier: 1, constant: -self.view.bounds.width/10.49),
            NSLayoutConstraint(item: sankaButton, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/18.93)
            ])
        
        
        let FriendTellButtonImage: UIImage = UIImage(named: "event_detail_rounded_gray.png")!
        FriendTellButton = UIButton()
        FriendTellButton.frame = CGRectMake(0,0,0,0)
        FriendTellButton.setBackgroundImage(FriendTellButtonImage, forState: UIControlState.Normal)
        FriendTellButton.setTitle("友達に教える", forState: UIControlState.Normal)
        FriendTellButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        FriendTellButton.titleLabel?.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/37.86)
        FriendTellButton.addTarget(self, action: "onClickTellButton:", forControlEvents: .TouchUpInside)
        myScrollView.addSubview(FriendTellButton)
        FriendTellButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: FriendTellButton, attribute: .Top,    relatedBy: .Equal, toItem: sankaButton,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/63.11),
            NSLayoutConstraint(item: FriendTellButton, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
            NSLayoutConstraint(item: FriendTellButton, attribute: .Right,   relatedBy: .Equal, toItem: self.view, attribute: .Right,   multiplier: 1, constant: -self.view.bounds.width/10.49),
            NSLayoutConstraint(item: FriendTellButton, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/18.93)
            ])
        
        
        line = UILabel(frame: CGRectMake(0,0,0,0))
        line.backgroundColor = UIColor.blackColor()
        self.view.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: line, attribute: .Top,    relatedBy: .Equal, toItem: FriendTellButton,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/32.46),
            NSLayoutConstraint(item: line, attribute: .Left,   relatedBy: .Equal, toItem: name, attribute: .Left,   multiplier: 1, constant: 0),
            NSLayoutConstraint(item: line, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width/1.24),
            NSLayoutConstraint(item: line, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/1136)
            ])
        
        
        
        
        kikaku = UILabel(frame: CGRectMake(0,0,0,0))
        kikaku.text = "企画"
        kikaku.textColor = UIColor.hexStr("1A1A1A", alpha: 1.0)
        kikaku.font = UIFont.systemFontOfSize(CGFloat(self.view.bounds.height/45.44))
        myScrollView.addSubview(kikaku)
        kikaku.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: kikaku, attribute: .Top,    relatedBy: .Equal, toItem: FriendTellButton,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/12.62),
            NSLayoutConstraint(item: kikaku, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
            NSLayoutConstraint(item: kikaku, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/45.44)
            ])
        
        
        sanka = UILabel(frame: CGRectMake(0,0,0,0))
        sanka.text = "参加"
        sanka.textColor = UIColor.hexStr("1A1A1A", alpha: 1.0)
        sanka.font = UIFont.systemFontOfSize(CGFloat(self.view.bounds.height/45.44))
        myScrollView.addSubview(sanka)
        sanka.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: sanka, attribute: .Top,    relatedBy: .Equal, toItem: FriendTellButton,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/6.38),
            NSLayoutConstraint(item: sanka, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
            NSLayoutConstraint(item: sanka, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/45.44)
            ])
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        print(self.view.bounds.height)
        print(self.view.frame.height)
        print("\(self.view.frame.size.height*(91/1136))asdf")
        print("\(myScrollView.frame.size.height)asdf")
        print("\(line.layer.position.y)asdf")



        
    }
    override func viewWillAppear(animated: Bool) {
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                
                
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray {
                    let id = events["event"]["id"].int! as Int
                    if  id == self.getID {
                        print("成功")
                        print(events["event"])
                        print(self.getID)
                        
                        // タイトル
                        self.name.text = events["event"]["title"].string! as String
                        
                        //日付・時間 配列取得
                        let startTime = events["event"]["start_time"].string! as String
                        let startArray = startTime.componentsSeparatedByString("T")
                        
                        // 日付
                        let date_formatter: NSDateFormatter = NSDateFormatter()
                        date_formatter.locale     = NSLocale(localeIdentifier: "ja")
                        date_formatter.dateFormat = "yyyy/MM/dd"
                        let change_date:NSDate = date_formatter.dateFromString(startArray[0])!
                        let weekdays: Array  = ["天", "日", "月", "火", "水", "木", "金", "土"]
                        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
                        let comps = calendar.components([.Year, .Month, .Day, .Weekday] , fromDate:  change_date)
                        date_formatter.dateFormat = "yyyy / MM / dd (\(weekdays[comps.weekday]))"
                        print(date_formatter.stringFromDate(change_date))
                        self.date.text = date_formatter.stringFromDate(change_date)
                        
                        // 時間
                        let startMinute = startArray[1].substringToIndex(startArray[1].startIndex.advancedBy(5))
                        let endTime = events["event"]["end_time"].string! as String
                        let endArray = endTime.componentsSeparatedByString("T")
                        let endMinute = endArray[1].substringToIndex(endArray[1].startIndex.advancedBy(5))
                        self.time.text = "\(startMinute) ~ \(endMinute)"
                        self.time.sizeToFit()
                        
                        // イベント説明
                        self.content.text = events["event"]["description"].string! as String
                        self.content.numberOfLines = 0
                        self.content.sizeToFit()
                        
                     //   self.myScrollView.contentSize.height = self.line.layer.position.y + self.view.frame.size.height*(91/1136)
                        
                        print(self.view.bounds.height)
                        print(self.view.frame.height)
                        print("\(self.line.layer.position.y)asdf")
                        print(self.view.frame.size.height)
                        print(self.view.frame.size.height*(91/1136))

                        
                        // タグ
                        let JugementTag: String? = events["event"]["category_tag"].string
                        if var TagText = JugementTag {
                            TagText = TagText.stringByReplacingOccurrencesOfString("#", withString: " #")
                            self.tag.text = TagText
                            self.tag.sizeToFit()
                        }
                        // 人数
                        let capacity = events["event"]["capacity"].int! as Int
                        //                        let participant: Int? = events["event"]["participant"].int
                        //                        if let ptcpnt = participant {
                        //                            let reserved = capacity - ptcpnt
                        //                                                        if reserved <= 0 {
                        //                                                            self.sankaButton.setTitle("参加する   満席", forState: UIControlState.Normal)
                        //                                                        } else {
                        //                            self.sankaButton.setTitle("参加する  残り\(reserved)席", forState: UIControlState.Normal)
                        //                                                       }
                        //                        } else {
                        self.sankaButton.setTitle("参加する  残り\(capacity)席", forState: UIControlState.Normal)
                        
                        
                    }
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onClickSankaButton(sender: UIButton){
        let EventDecideViewController = EventsDecideViewController()
        EventDecideViewController.MygetID = getID
        self.navigationController?.pushViewController(EventDecideViewController, animated: true)
        
        
    }
    
    func onClickTellButton(sender: UIButton){
        
        
    }
    
    
}
