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
import Foundation
import Social


class EventsAttendViewController: UIViewController,UINavigationControllerDelegate  {
    
    private var myScrollView:UIScrollView!
    private var name:UILabel!
    private var date: UILabel!
    private var time: UILabel!
    private var tag: UILabel!
    private var content: UILabel!
    private var sankaButton: UIButton!
    private var FriendTellButton: UIButton!
    private var reservedButton: UIButton!
    private var cancelButton: UIButton!
    private var kikaku: UILabel!
    private var ownerImage: UIImageView!
    private var participantsImage: UIImageView!
    private var participantsButton: UIButton!
    private var sanka: UILabel!
    private var overLine: UILabel!
    private var line: UILabel!
    private var event_detail_calendar: UIImageView!
    private var event_detail_clock: UIImageView!
    private var event_detail_tag: UIImageView!
    private var starButton: UIButton!
    private var starSelectedButton: UIButton!
    private var genreImg:UIImage!
    var window :UIWindow!
    var EventGenre: Int!
    var getID: Int!
    var friendsNumber: Int!
    let judgeKey = NSUserDefaults.standardUserDefaults()
    var userID = NSUserDefaults.standardUserDefaults().integerForKey("UserIDKey")
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    private var starImage1: UIImage!
    private var starImage2: UIImage!!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        
        
        let backButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        
        starImage1 =  CommonFunction().resizingImage(imageName: "star.png", w: self.view.bounds.width/17.30, h: self.view.bounds.height/30.70)     //UIImage(named: "star.png")
        starImage2 = CommonFunction().resizingImage(imageName: "star_selected.png", w: self.view.bounds.width/17.30, h: self.view.bounds.height/30.70)
        
        
        myScrollView = UIScrollView()
        myScrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        myScrollView.contentSize = CGSizeMake(self.view.frame.width, 0)
        myScrollView.contentOffset = CGPointMake(0, 0)
        myScrollView.pagingEnabled = false
        self.view.addSubview(myScrollView)
        
        
        
        name = UILabel(frame: CGRectMake(0,self.view.bounds.height/11.36,self.view.bounds.width/1.24,self.view.bounds.height/35.5))
        name.text = ""
        name.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        name.textAlignment = NSTextAlignment.Center
        name.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/35.5)
        name.layer.position.x = CGFloat(self.view.bounds.width/2)
        name.lineBreakMode = NSLineBreakMode.ByCharWrapping
        myScrollView.addSubview(name)
        
        
        overLine = UILabel(frame: CGRectMake(0,0,0,0))
        overLine.backgroundColor = UIColor.blackColor()
        myScrollView.addSubview(overLine)
        overLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: overLine, attribute: .Top,    relatedBy: .Equal, toItem: name,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/71),
            NSLayoutConstraint(item: overLine, attribute: .Left,   relatedBy: .Equal, toItem: name, attribute: .Left,   multiplier: 1, constant: 0),
            NSLayoutConstraint(item: overLine, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width/1.24),
            NSLayoutConstraint(item: overLine, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/1136)
            ])
        
        
        
        event_detail_calendar = UIImageView(frame: CGRectMake(0,0,0,0))
        let detail_calendar = UIImage(named: "event_detail_calendar.png")
        event_detail_calendar.frame = CGRectMake(0, 0, 0, 0)
        event_detail_calendar.image = detail_calendar
        myScrollView.addSubview(event_detail_calendar)
        event_detail_calendar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: event_detail_calendar, attribute: .Top,    relatedBy: .Equal, toItem: overLine,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/22.72),
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
            NSLayoutConstraint(item: date, attribute: .Top,    relatedBy: .Equal, toItem: overLine,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/22.72),
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
        content.lineBreakMode = NSLineBreakMode.ByCharWrapping
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
        
        let reservedButtonImage: UIImage = UIImage(named: "event_detail_rounded_blue.png")!
        self.reservedButton = UIButton()
        self.reservedButton.frame = CGRectMake(0,0,0,0)
        self.reservedButton.setBackgroundImage(reservedButtonImage, forState: UIControlState.Normal);
        self.reservedButton.setTitle("予約済み 友だち +1", forState: UIControlState.Normal)
        self.reservedButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.reservedButton.titleLabel?.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/37.86)
        self.reservedButton.addTarget(self, action: "onClickrezervedButton:", forControlEvents: .TouchUpInside)
        self.myScrollView.addSubview(self.reservedButton)
        
        
        let sankaButtonImage: UIImage = UIImage(named: "event_detail_rounded.png")!
        self.sankaButton = UIButton()
        self.sankaButton.frame = CGRectMake(0,0,0,0)
        self.sankaButton.setBackgroundImage(sankaButtonImage, forState: UIControlState.Normal);
        self.sankaButton.setTitle("", forState: UIControlState.Normal)
        self.sankaButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.sankaButton.titleLabel?.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/37.86)
        self.sankaButton.addTarget(self, action: "onClickSankaButton:", forControlEvents: .TouchUpInside)
        self.myScrollView.addSubview(self.sankaButton)
        
        
        cancelButton = UIButton(frame: CGRectMake(0,0,0,0))
        cancelButton.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/1.11)
        cancelButton.layer.cornerRadius = 7.0
        cancelButton.backgroundColor = UIColor.grayColor()
        cancelButton.addTarget(self, action: "willCancel:", forControlEvents: .TouchUpInside)
        cancelButton.setTitle("キャンセル連絡をする", forState: .Normal)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(cancelButton)
        
        
        
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
            NSLayoutConstraint(item: FriendTellButton, attribute: .Top,    relatedBy: .Equal, toItem: tag,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/8.541),
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
        
        
        participantsButton = UIButton()
        participantsButton.frame = CGRectMake(0,0,0,0)
        participantsButton.titleLabel!.font = UIFont.boldSystemFontOfSize(self.view.bounds.height*(23/1136))
        participantsButton.setTitle("", forState: UIControlState.Normal)
        participantsButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        participantsButton.addTarget(self, action: "onClickParticipantsButton:", forControlEvents: .TouchUpInside)
        myScrollView.addSubview(participantsButton)
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        var viewControllers = self.navigationController?.viewControllers
        if let viewcntrs = viewControllers {
            viewControllers = viewcntrs
            if indexOfArray((viewControllers)!, searchObject: self) == nil {
                self.navigationController?.popToRootViewControllerAnimated(true)

                genreImg =  CommonFunction().resizingImage(imageName: "tournament.png", w: 100, h: 99)
                window = UIWindow()
                window.frame = CGRectMake(0, 0, 0, 0)
                window.layer.position = CGPoint(x: 0, y: 0)
                window.backgroundColor = UIColor.redColor()
                window.makeKeyWindow()
                window.makeKeyAndVisible()
                
                
                let imgView = UIImageView(frame: CGRectMake(0, 0, 0, 0))
                imgView.image = genreImg
                window.addSubview(imgView)
            }
            super.viewWillDisappear(animated)
        }
    }
    override func viewDidDisappear(animated: Bool) {
        
        genreImg =  CommonFunction().resizingImage(imageName: "tournament.png", w: 100, h: 99)
        window = UIWindow()
        window.frame = CGRectMake(0, 0, 0, 0)
        window.layer.position = CGPoint(x: 0, y: 0)
        window.backgroundColor = UIColor.redColor()
        window.makeKeyWindow()
        window.makeKeyAndVisible()
        
        
        let imgView = UIImageView(frame: CGRectMake(0, 0, 0, 0))
        imgView.image = genreImg
        window.addSubview(imgView)
        super.viewDidDisappear(animated)
    }
    
    func indexOfArray(array:[AnyObject], searchObject: AnyObject)-> Int? {
        for (index, value) in array.enumerate() {
            if value as! UIViewController == searchObject as! UIViewController {
                return index
            }
        }
        return nil
    }
    
    override func viewWillAppear(animated: Bool) {
        var judgeID: Int = 0
        let EventsUrl = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, EventsUrl)
            .responseJSON { response in
                
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray {
                    let id = events["event"]["id"].int! as Int
                    if  id == self.getID {
                        print(self.userID)
                        var ownerID: Int!
                        ownerID = events["event"]["owner_id"].int! as Int
                        NSUserDefaults.standardUserDefaults().setInteger(ownerID, forKey: "ownerID")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        //お気に入りボタン
                        let keyInt: Int = events["event"]["id"].int as Int!
                        let key: String = String(keyInt)
                        
                        if self.judgeKey.boolForKey(key) {
                            self.starSelectedButton = UIButton()
                            self.starSelectedButton.frame = CGRectMake(0,0,self.view.bounds.width/17.30,self.view.bounds.height/30.70)
                            self.starSelectedButton.setBackgroundImage(self.starImage2, forState: UIControlState.Normal);
                            self.starSelectedButton.setTitle("", forState: UIControlState.Normal)
                            self.starSelectedButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                            self.starSelectedButton.titleLabel?.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/37.86)
                            self.starSelectedButton.addTarget(self, action: "onClickStarSelectedButton:", forControlEvents: .TouchUpInside)
                            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.starSelectedButton)
                        } else {
                            self.starButton = UIButton()
                            self.starButton.frame = CGRectMake(0,0,self.view.bounds.width/17.30,self.view.bounds.height/30.70)
                            self.starButton.setBackgroundImage(self.starImage1, forState: UIControlState.Normal);
                            self.starButton.setTitle("", forState: UIControlState.Normal)
                            self.starButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                            self.starButton.titleLabel?.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/37.86)
                            self.starButton.addTarget(self, action: "onClickStarButton:", forControlEvents: .TouchUpInside)
                            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.starButton)
                            
                        }
                        
                        
                        //genreicon
                        self.EventGenre = events["event"]["genre"].int! as Int
                        if self.EventGenre == 0 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#D9E021", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "jobhunt.png", w: self.view.frame.size.width*(75/640), h: self.view.frame.size.height*(75/1136))
                            
                            
                        } else if self.EventGenre == 1 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#AF2E84", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "study.png", w: self.view.frame.size.width*(75/640), h: self.view.frame.size.height*(75/1136))
                            
                        } else if self.EventGenre == 2 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#22B573", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "party.png", w: self.view.frame.size.width*(75/640), h: self.view.frame.size.height*(75/1136))
                            
                        } else if self.EventGenre == 3 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#FF7F00", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "circle.png", w: self.view.frame.size.width*(75/640), h: self.view.frame.size.height*(75/1136))
                            
                        } else if self.EventGenre == 4 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#00C2CC", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "tournament.png", w: self.view.frame.size.width*(75/640), h: self.view.frame.size.height*(75/1136))
                            
                        } else if self.EventGenre == 5 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("##EFEDE8", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "hobby.png", w: self.view.frame.size.width*(75/640), h: self.view.frame.size.height*(75/1136))
                            
                        } else if self.EventGenre == 6 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#FFDA3E", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "readbook.png", w: self.view.frame.size.width*(75/640), h: self.view.frame.size.height*(75/1136))
                            
                        }
                        
                        self.window = UIWindow()
                        self.window.frame = CGRectMake(0, 0, self.view.frame.size.width*(105/640), self.view.frame.size.height*(105/1136))
                        self.window.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.frame.height/12.5)
                        self.window.backgroundColor = UIColor.clearColor()
                        self.window.makeKeyWindow()
                        self.window.makeKeyAndVisible()
                        let imgView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width*(105/640), self.view.frame.size.height*(105/1136)))
                        imgView.image = self.genreImg
                        self.window.addSubview(imgView)
                        
                        
                        
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
                        let weekdays: Array  = ["", "日", "月", "火", "水", "木", "金", "土"]
                        let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                        let comps = calendar.components([.Year, .Month, .Day, .Weekday] , fromDate:  change_date)
                        date_formatter.dateFormat = "yyyy / MM / dd (\(weekdays[comps.weekday]))"
                        print(date_formatter.stringFromDate(change_date))
                        self.date.text = date_formatter.stringFromDate(change_date)
                        self.date.sizeToFit()
                        
                        // 時間
                        let startMinute = startArray[1].substringToIndex(startArray[1].startIndex.advancedBy(5))
                        let endTime = events["event"]["end_time"].string! as String
                        let endArray = endTime.componentsSeparatedByString("T")
                        let endMinute = endArray[1].substringToIndex(endArray[1].startIndex.advancedBy(5))
                        self.time.text = "\(startMinute) ~ \(endMinute)"
                        self.time.sizeToFit()
                        //eventと現在時刻を比較
                        let dateFormat: NSDateFormatter = NSDateFormatter()
                        dateFormat.locale = NSLocale(localeIdentifier: "ja")
                        dateFormat.dateFormat = "yyyy/MM/dd HH:mm"
                        let time: String = "\(startArray[0]) \(endMinute)"
                        let eventTime: NSDate = dateFormat.dateFromString(time)!
                        print(dateFormat.stringFromDate(eventTime))
                        print(eventTime)
                        let now: NSDate = NSDate()
                        let NowDateFormat = NSDateFormatter()
                        NowDateFormat.locale = NSLocale(localeIdentifier: "ja")
                        NowDateFormat.timeStyle = .ShortStyle
                        NowDateFormat.dateStyle = .ShortStyle
                        let nowstr: String = NowDateFormat.stringFromDate(now) // -> 2014/06/24 11:14
                        print(nowstr)
                        let NowTime: NSDate = dateFormat.dateFromString(nowstr)!
                        print(NowTime)
                        
                        var judgeTime: Int
                        
                        if (eventTime.compare(NowTime) == NSComparisonResult.OrderedDescending){
                            print("- イベントをやる前")
                            judgeTime = 0
                        }else if (eventTime.compare(NowTime) == NSComparisonResult.OrderedAscending){
                            print("- イベントをやった後")
                            judgeTime = 1
                        }else{
                            print("- 同じ")
                            judgeTime = 0
                        }
                        
                        let participantsArray =  events["participants"].array! as Array
                        
                        if judgeTime == 0 {
                            //主催者かどうか判別
                            if ownerID == self.userID {
                                self.cancelButton.translatesAutoresizingMaskIntoConstraints = false
                                self.view.addConstraints([
                                    NSLayoutConstraint(item: self.cancelButton, attribute: .Top,    relatedBy: .Equal, toItem: self.tag,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/20.65),
                                    NSLayoutConstraint(item: self.cancelButton, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
                                    NSLayoutConstraint(item: self.cancelButton, attribute: .Right,   relatedBy: .Equal, toItem: self.view, attribute: .Right,   multiplier: 1, constant: -self.view.bounds.width/10.49),
                                    NSLayoutConstraint(item: self.cancelButton, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/18.93)
                                    ])
                                
                                
                            } else {
                                // 参加済みかどうか判別
                                for participants in participantsArray{
                                    let participantsID = participants["id"].int! as Int
                                    if participantsID == self.userID {
                                        judgeID = 1
                                    }
                                }
                                    if NSUserDefaults.standardUserDefaults().boolForKey("\(self.getID)w") {
                                       if let FriendsNumber = self.friendsNumber {
                                            
                                            NSUserDefaults.standardUserDefaults().setInteger(FriendsNumber, forKey: "\(self.getID)")
                                            NSUserDefaults.standardUserDefaults().synchronize()
                                        }
                                        let Number = NSUserDefaults.standardUserDefaults().integerForKey("\(self.getID)")
                                        self.reservedButton.setTitle("予約済み 友だち +\(Number)", forState: UIControlState.Normal)
                                        
                                        self.reservedButton.translatesAutoresizingMaskIntoConstraints = false
                                        self.view.addConstraints([
                                            NSLayoutConstraint(item: self.reservedButton, attribute: .Top,    relatedBy: .Equal, toItem: self.tag,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/20.65),
                                            NSLayoutConstraint(item: self.reservedButton, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
                                            NSLayoutConstraint(item: self.reservedButton, attribute: .Right,   relatedBy: .Equal, toItem: self.view, attribute: .Right,   multiplier: 1, constant: -self.view.bounds.width/10.49),
                                            NSLayoutConstraint(item: self.reservedButton, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/18.93)
                                            ])
                                    } else {
                                self.sankaButton.translatesAutoresizingMaskIntoConstraints = false
                                    self.view.addConstraints([
                                        NSLayoutConstraint(item: self.sankaButton, attribute: .Top,    relatedBy: .Equal, toItem: self.tag,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/20.65),
                                        NSLayoutConstraint(item: self.sankaButton, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
                                        NSLayoutConstraint(item: self.sankaButton, attribute: .Right,   relatedBy: .Equal, toItem: self.view, attribute: .Right,   multiplier: 1, constant: -self.view.bounds.width/10.49),
                                        NSLayoutConstraint(item: self.sankaButton, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/18.93)
                                        ])
                                    
                                }
                            }
                            
                            
                        } else {
                            self.reservedButton.setTitle("参加済み", forState: UIControlState.Normal)
                            
                            self.reservedButton.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addConstraints([
                                NSLayoutConstraint(item: self.reservedButton, attribute: .Top,    relatedBy: .Equal, toItem: self.tag,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/20.65),
                                NSLayoutConstraint(item: self.reservedButton, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
                                NSLayoutConstraint(item: self.reservedButton, attribute: .Right,   relatedBy: .Equal, toItem: self.view, attribute: .Right,   multiplier: 1, constant: -self.view.bounds.width/10.49),
                                NSLayoutConstraint(item: self.reservedButton, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/18.93)
                                ])
                            
                        }
                        
                        // イベント説明
                        self.content.text = "\(events["event"]["description"].string! as String)"
                        let attributedText = NSMutableAttributedString(string: self.content.text!)
                        let paragraphStyle = NSMutableParagraphStyle()
                        paragraphStyle.lineSpacing = self.view.bounds.height/25.24
                        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
                        self.content.attributedText = attributedText
                        
                        self.content.numberOfLines = 0
                        self.content.sizeToFit()
                        
                        
                        // タグ
                        let JugementTag: String? = events["event"]["category_tag"].string
                        if var TagText = JugementTag {
                            TagText = TagText.stringByReplacingOccurrencesOfString("#", withString: " #")
                            self.tag.text = TagText
                            self.tag.sizeToFit()
                        }
                        // 人数
                        let capacity = events["event"]["capacity"].int! as Int
                        let participant: Int! = events["event"]["participant"].int
                        if participant >= 5 {
                            self.participantsButton.translatesAutoresizingMaskIntoConstraints = false
                            self.view.addConstraints([
                                NSLayoutConstraint(item: self.participantsButton, attribute: .Top,    relatedBy: .Equal, toItem: self.sanka,   attribute: .Bottom, multiplier: 1, constant: 0),
                                NSLayoutConstraint(item: self.participantsButton, attribute: .Right,   relatedBy: .Equal, toItem: self.view, attribute: .Right,   multiplier: 1, constant: -self.view.bounds.width*(61/640)),
                                NSLayoutConstraint(item: self.participantsButton, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/45.44)
                                ])
                            self.participantsButton.setTitle("\(participant) ∨", forState: UIControlState.Normal)
                            
                            
                        }
                        NSUserDefaults.standardUserDefaults().setInteger(participant, forKey: "participant")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        if judgeID == 0 {
                            let reserved = capacity - participant
                            if reserved <= 0 {
                                self.sankaButton.setTitle("参加する   満席", forState: UIControlState.Normal)
                                
                            } else {
                                self.sankaButton.setTitle("参加する  残り\(reserved)席", forState: UIControlState.Normal)
                            }
                            
                        }
                        //スクロールサイズ
                        if ownerID == self.userID {
                            self.myScrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.bounds.height/2.09 + self.name.bounds.height + self.date.bounds.height + self.time.bounds.height + self.content.bounds.height + self.tag.bounds.height + self.view.bounds.height/18.93 + self.FriendTellButton.bounds.height + self.view.bounds.height/11)
                            
                        }
                        if  judgeID == 0 {
                            self.myScrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.bounds.height/2.09 + self.name.bounds.height + self.date.bounds.height + self.time.bounds.height + self.content.bounds.height + self.tag.bounds.height + self.view.bounds.height/18.93 + self.FriendTellButton.bounds.height + self.view.bounds.height/11)
                            
                        } else {
                            self.myScrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.bounds.height/2.09 + self.name.bounds.height + self.date.bounds.height + self.time.bounds.height + self.content.bounds.height + self.tag.bounds.height + self.view.bounds.height/18.93 + self.FriendTellButton.bounds.height + self.view.bounds.height/11)
                            
                        }
                        
                        
                    }
                    
                }
                
        }
        let UsersUrl = "https://zerocafe.herokuapp.com/api/v1/users.json"
        Alamofire.request(.GET, UsersUrl)
            .responseJSON { response in
                
                let ownerID = NSUserDefaults.standardUserDefaults().integerForKey("ownerID")
                let json = JSON(response.result.value!)
                print(ownerID)
                let userArray = json["users"].array! as Array
                for users in userArray {
                    let id = users["user"]["id"].int! as Int
                    if  id == ownerID {
                        print(users["user"])
                        self.ownerImage = UIImageView(image: UIImage(named: "twitter-icon.png"))
                        self.ownerImage.frame = CGRectMake(0, 0, self.view.bounds.width/5.6, self.view.bounds.height/5.6)
                        self.ownerImage.layer.position = CGPoint(x: self.view.bounds.width/5.981, y: self.view.bounds.height/5.947)
                        self.ownerImage.layer.masksToBounds = true
                        self.ownerImage.layer.cornerRadius = 8.0
                        self.myScrollView.addSubview(self.ownerImage)
                        self.ownerImage.translatesAutoresizingMaskIntoConstraints = false
                        self.view.addConstraints([
                            NSLayoutConstraint(item: self.ownerImage, attribute: .Top,    relatedBy: .Equal, toItem: self.line,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height*(35/1136)),
                            NSLayoutConstraint(item: self.ownerImage, attribute: .Left,   relatedBy: .Equal, toItem: self.kikaku, attribute: .Right,   multiplier: 1, constant: self.view.bounds.width*(25/640)),
                            NSLayoutConstraint(item: self.ownerImage, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width*(65/640)),
                            NSLayoutConstraint(item: self.ownerImage, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height*(65/1136))
                            ])
                        
                        let ownerImageurl: String? = users["user"]["image"]["thumb"]["url"].string
                        if ownerImageurl != nil {
                            print(ownerImageurl!)
                            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
                            let session = NSURLSession(configuration: sessionConfig)
                            let url = NSURL(string:ownerImageurl!)
                            let task = session.dataTaskWithURL(url!) {
                                (data: NSData?, response: NSURLResponse?, error: NSError?) in
                                guard let getData = data else {
                                    session.invalidateAndCancel()
                                    return
                                }
                                let globalQueu =
                                dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                                dispatch_async(globalQueu) {
                                    let img = UIImage(data: getData)
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.ownerImage.image = img
                                    }
                                }
                            }
                            task.resume()

                            self.ownerImage.af_setImageWithURL(NSURL(string: ownerImageurl!)!)
                        } else {
                            print("no image")
                        }
                    }
                    
                }
                
        }
        
        Alamofire.request(.GET, EventsUrl)
            .responseJSON { response in
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray {
                    let id = events["event"]["id"].int! as Int
                    if  id == self.getID {
                        let participants: Int? = events["event"]["participant"].int
                        if participants != nil {
                            let participantsArray = events["participants"].array! as Array
                            var count: Int = 1
                            var pointSift: CGFloat = 0
                            for ptcpnts in participantsArray {
                                if count <= 5 {
                                    self.participantsImage = UIImageView(image: UIImage(named: "twitter-icon.png"))
                                    self.participantsImage.frame = CGRectMake(0, 0, self.view.bounds.width/5.6, self.view.bounds.height/5.6)
                                    self.participantsImage.layer.position = CGPoint(x: self.view.bounds.width/5.981, y: self.view.bounds.height/5.947)
                                    self.participantsImage.layer.masksToBounds = true
                                    self.participantsImage.layer.cornerRadius = 8.0
                                    self.myScrollView.addSubview(self.participantsImage)
                                    self.participantsImage.translatesAutoresizingMaskIntoConstraints = false
                                    self.view.addConstraints([
                                        NSLayoutConstraint(item: self.participantsImage, attribute: .Top,    relatedBy: .Equal, toItem: self.line,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height*(123/1136)),
                                        NSLayoutConstraint(item: self.participantsImage, attribute: .Left,   relatedBy: .Equal, toItem: self.sanka, attribute: .Right,   multiplier: 1, constant: self.view.bounds.width*(25/640) + pointSift),
                                        NSLayoutConstraint(item: self.participantsImage, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width*(65/640)),
                                        NSLayoutConstraint(item: self.participantsImage, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height*(65/1136))
                                        ])
                                    let participantImageUrl: String? = ptcpnts["image"]["image"]["thumb"]["url"].string
                                    if participantImageUrl != nil {
                                        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
                                        let session = NSURLSession(configuration: sessionConfig)
                                        let url = NSURL(string:participantImageUrl!)
                                        let task = session.dataTaskWithURL(url!) {
                                            (data: NSData?, response: NSURLResponse?, error: NSError?) in
                                            guard let getData = data else {
                                                session.invalidateAndCancel()
                                                return
                                            }
                                            let globalQueu =
                                            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                                            dispatch_async(globalQueu) {
                                                let img = UIImage(data: getData)
                                                dispatch_async(dispatch_get_main_queue()) {
                                                    self.participantsImage.image = img
                                                }
                                            }
                                        }
                                        task.resume()
                                        self.participantsImage.af_setImageWithURL(NSURL(string: participantImageUrl!)!)
                                    } else {
                                        print("no image")
                                    }
                                    
                                    pointSift += self.view.bounds.width*(78/640)
                                    count += 1
                                    
                                }
                            }
                        }
                        
                    }
                }
        }
        
    }
    
    func onClickParticipantsButton(sender: UIButton){
        
        let ParticipantsView = ParticipantsImageViewController()
        ParticipantsView.getID = getID
        self.navigationController?.pushViewController(ParticipantsView, animated: true)
        
    }
    
    func onClickStarSelectedButton(sender: UIButton){
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray {
                    let id = events["event"]["id"].int! as Int
                    if  id == self.getID {
                        let keyInt: Int = events["event"]["id"].int as Int!
                        let key: String = String(keyInt)
                        self.judgeKey.setBool(false, forKey: key)
                        self.judgeKey.synchronize()
                        
                    }
                }
        }
        starButton = UIButton()
        starButton.frame = CGRectMake(0,0,self.view.bounds.width/17.30,self.view.bounds.height/30.70)
        starButton.setBackgroundImage(starImage1, forState: UIControlState.Normal);
        starButton.setTitle("", forState: UIControlState.Normal)
        starButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        starButton.titleLabel?.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/37.86)
        starButton.addTarget(self, action: "onClickStarButton:", forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: starButton)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var defaultsEventId = defaults.objectForKey("EVENT_ID") as! [Int]
        var removeCount = 0
        for (index,defaultID) in defaultsEventId.enumerate(){
            if defaultID == getID{
                defaultsEventId.removeAtIndex(index-removeCount)
                removeCount++
            }
            
        }
        defaults.setObject(defaultsEventId, forKey:"EVENT_ID")
        defaults.synchronize()
        
    }
    
    
    func onClickStarButton(sender: UIButton){
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray {
                    let id = events["event"]["id"].int! as Int
                    if  id == self.getID {
                        let keyInt: Int = events["event"]["id"].int as Int!
                        let key: String = String(keyInt)
                        self.judgeKey.setBool(true, forKey: key)
                        self.judgeKey.synchronize()
                        
                    }
                }
        }
        
        
        starSelectedButton = UIButton()
        starSelectedButton.frame = CGRectMake(0,0,self.view.bounds.width/17.30,self.view.bounds.height/30.70)
        starSelectedButton.setBackgroundImage(starImage2, forState: UIControlState.Normal);
        starSelectedButton.setTitle("", forState: UIControlState.Normal)
        starSelectedButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        starSelectedButton.titleLabel?.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/37.86)
        starSelectedButton.addTarget(self, action: "onClickStarSelectedButton:", forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: starSelectedButton)
        
        //        お気に入りのボタンの処理
        var eventIds: [Int] = []
        
        if let defaultsEventId = defaults.objectForKey("EVENT_ID"){
            let orderedSet = NSOrderedSet(array: defaultsEventId as! [AnyObject])
            let uniqueValues = orderedSet.array
            eventIds = uniqueValues as! [Int]
        }
        //配列に追加していく
        eventIds.append(getID)
        
        defaults.setObject(eventIds, forKey:"EVENT_ID")
        defaults.synchronize()
        
    }
    
    
    
    func onClickrezervedButton(sender: UIButton){}
    
    
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
    
    
    func onClickSankaButton(sender: UIButton){
        let EventsUrl = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, EventsUrl)
            .responseJSON { response in
                
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray {
                    let id = events["event"]["id"].int! as Int
                    if  id == self.getID {
                        let capacity = events["event"]["capacity"].int! as Int
                        let participant: Int! = events["event"]["participant"].int
                        let reserved = capacity - participant
                        
                        
                        if reserved > 0 {
                            let EventDecideViewController = EventsDecideViewController()
                            EventDecideViewController.getID = self.getID
                            self.navigationController?.pushViewController(EventDecideViewController, animated: true)
                        }
                    }
                }
        }
        
    }
    
    
    
    
    func onClickTellButton(sender: UIButton){
        
        genreImg =  CommonFunction().resizingImage(imageName: "tournament.png", w: 100, h: 99)
        window = UIWindow()
        window.frame = CGRectMake(0, 0, 0, 0)
        window.layer.position = CGPoint(x: 0, y: 0)
        window.backgroundColor = UIColor.redColor()
        window.makeKeyWindow()
        window.makeKeyAndVisible()
        let imgView = UIImageView(frame: CGRectMake(0, 0, 0, 0))
        imgView.image = genreImg
        window.addSubview(imgView)
        
        
        // 共有する項目
        let shareText = ""
        let activityItems = [shareText]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


//let animator = Animator()

//func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//    // PushかPopかをアニメータークラスにセット
//    animator.operation = operation
//
//    return animator
//
//}
//
//class Animator: NSObject, UIViewControllerAnimatedTransitioning {
//    let animationDuration = 1.0  // 画面遷移にかける時間
//    var operation: UINavigationControllerOperation = .Push  // 画面遷移がPushかPopかを保持するプロパティ
//
//    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
//        return animationDuration
//    }
//
//    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
//
//        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
//        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
//        let containerView = transitionContext.containerView()
//
//        // Pushの場合、上から下に遷移。Popの場合、下から上に遷移
//        if operation == .Push{
//            let initialFrame = CGRectOffset(toView.bounds, 0.0, -toView.bounds.size.height)
//            let finalFrame = toView.bounds
//
//            // 画面遷移スタート時点
//            toView.frame = initialFrame
//            containerView!.addSubview(toView)
//
//            // 画面遷移
//            UIView.animateWithDuration(animationDuration, animations: {
//
//                toView.frame = finalFrame
//
//                }, completion: {
//                    _ in
//                    transitionContext.completeTransition(true)  // 画面遷移終了の通知
//            })
//
//        }else{
//            let initialFrame = CGRectOffset(fromView.bounds, 0.0, 0.0)
//            let finalFrame = CGRectOffset(fromView.bounds, 0.0, -fromView.bounds.size.height)
//
//            // 画面遷移スタート時点
//            fromView.frame = initialFrame
//            containerView!.addSubview(toView)
//            containerView!.insertSubview(fromView, aboveSubview: toView)
//
//            // 画面遷移
//            UIView.animateWithDuration(animationDuration, animations: {
//
//                fromView.frame = finalFrame
//
//                }, completion: {
//                    _ in
//                    transitionContext.completeTransition(true)  // 画面遷移終了の通知
//            })
//            
//        }
//    }
//}
