//
//  SecondViewController.swift
//  zerocafeイベント詳細
//
//  Created by AndroidProject on 2015/12/17.
//  Copyright (c) 2015年 AndroidProject. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class EventsDecideViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    private var starButton: UIButton!
    private var starSelectedButton: UIButton!
    let judgeKey = NSUserDefaults.standardUserDefaults()

    private var TakeFriends:UILabel!
    private var event_detail_add_friend: UIImageView!
    private var addPicker: UIPickerView!
    private var toolBar: UIToolbar!
    private var addButton: UITextField!
    private let myValues: NSArray = ["0人","1人","2人","3人","4人","5人","6人","7人","8人","9人","10人","11人","12人","13人","14人","15人","16人","17人","18人","19人","20人", "21人", "22人"]
    private var event_detail_info: UIImageView!
    private var line: UILabel!
    private var sankaButton: UIButton!
    
    private var genreImg:UIImage!
    var window :UIWindow!
    
    var EventGenre: Int!
    var getID: Int!
    var friendsNumber: Int?
    var userID = NSUserDefaults.standardUserDefaults().integerForKey("UserIDKey")
    private var starImage1: UIImage!
    private var starImage2: UIImage!!

    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        starImage1 =  CommonFunction().resizingImage(imageName: "star.png", w: self.view.bounds.width/17.30, h: self.view.bounds.height/30.70)     //UIImage(named: "star.png")
        starImage2 = CommonFunction().resizingImage(imageName: "star_selected.png", w: self.view.bounds.width/17.30, h: self.view.bounds.height/30.70)

        
        self.title = ""
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        event_detail_add_friend = UIImageView(frame: CGRectMake(0,0,0,0))
        let detail_add_friend = UIImage(named: "event_detail_add_friend.png")
        event_detail_add_friend.image = detail_add_friend
        self.view.addSubview(event_detail_add_friend)
        event_detail_add_friend.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: event_detail_add_friend, attribute: .Top,    relatedBy: .Equal, toItem: self.view,   attribute: .Top, multiplier: 1, constant: self.view.bounds.height/4.91),
            NSLayoutConstraint(item: event_detail_add_friend, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width/10.49),
            NSLayoutConstraint(item: event_detail_add_friend, attribute: .Width, relatedBy: .Equal, toItem: nil,   attribute: .Width, multiplier: 1, constant: self.view.bounds.width/9.01),
            NSLayoutConstraint(item: event_detail_add_friend, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/29.13),
            ])
        
        
        TakeFriends = UILabel(frame: CGRectMake(0,0,0,0))
        TakeFriends.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        TakeFriends.text = "友達を連れて行く"
        TakeFriends.font = UIFont.systemFontOfSize(CGFloat(self.view.bounds.height/37.86))
        self.view.addSubview(TakeFriends)
        TakeFriends.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: TakeFriends, attribute: .Top,    relatedBy: .Equal, toItem: self.view,   attribute: .Top, multiplier: 1, constant: self.view.bounds.height/4.81),
            NSLayoutConstraint(item: TakeFriends, attribute: .Left,   relatedBy: .Equal, toItem: event_detail_add_friend, attribute: .Right,   multiplier: 1, constant: self.view.bounds.width/10.49),
            ])
        
        addPicker = UIPickerView()
        addPicker.delegate = self
        addPicker.dataSource = self
        addPicker.showsSelectionIndicator = true
        addPicker.selectRow(0, inComponent: 0, animated: false);
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.backgroundColor = UIColor.blackColor()
        toolBar.barStyle = UIBarStyle.Black
        toolBar.tintColor = UIColor.whiteColor()
        
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace,target: self,action: "")
        
        let toolBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "onClick:")
        toolBar.items = [spaceBarBtn,toolBarButton]
        
        addButton = UITextField(frame: CGRectMake(self.view.bounds.width/1.3, self.view.bounds.height/4.75, self.view.bounds.width/9.14, self.view.bounds.height/37.86))
        addButton.textColor = UIColor.blackColor()
        addButton.font = UIFont.systemFontOfSize(CGFloat(self.view.bounds.height/37.86))
        addButton.placeholder = myValues[0] as? String;
        addButton.inputView = addPicker
        addButton.inputAccessoryView = toolBar
        
        self.view.addSubview(addButton)
        self.view.addSubview(addButton)
        
        event_detail_info = UIImageView(frame: CGRectMake(0,self.view.bounds.height/3.82,self.view.bounds.width/1.27,self.view.bounds.height/12.08))
        let detail_info = UIImage(named: "event_detail_info.png")
        event_detail_info.image = detail_info
        event_detail_info.layer.position.x = CGFloat(self.view.bounds.width/2)
        self.view.addSubview(event_detail_info)
        
        
        
        line = UILabel(frame: CGRectMake(0,0,0,0))
        line.backgroundColor = UIColor.blackColor()
        self.view.addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: line, attribute: .Top,    relatedBy: .Equal, toItem: event_detail_info,   attribute: .Bottom, multiplier: 1, constant: self.view.bounds.height/18.93),
            NSLayoutConstraint(item: line, attribute: .Left,   relatedBy: .Equal, toItem: event_detail_add_friend, attribute: .Left,   multiplier: 1, constant: 0),
            NSLayoutConstraint(item: line, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width/1.24),
            NSLayoutConstraint(item: line, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height/1136)
            ])
        
        
        
        let sankaButtonImage: UIImage = UIImage(named: "event_detail_rounded.png")!
        sankaButton = UIButton()
        sankaButton.frame = CGRectMake(0,self.view.bounds.height/2.22,self.view.bounds.width/1.23,self.view.bounds.height/18.93)
        sankaButton.layer.position.x = CGFloat(self.view.bounds.width/2)
        sankaButton.setBackgroundImage(sankaButtonImage, forState: UIControlState.Normal)
        sankaButton.setTitle("参加を確定する", forState: UIControlState.Normal)
        sankaButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sankaButton.titleLabel?.font = UIFont.boldSystemFontOfSize(self.view.bounds.height/37.86)
        sankaButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(sankaButton)
        
        
        
        
    }
    
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myValues[row] as? String
    }
    
    
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addButton.text = myValues[row] as? String;
        print("row: \(row)")
        print("value: \(myValues[row])")
        friendsNumber = row
    }
    
    func onClick(sender: UIBarButtonItem) {
        addButton.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray {
                    let id = events["event"]["id"].int! as Int
                    if  id == self.getID{
                        self.EventGenre = events["event"]["genre"].int! as Int
                        
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

                        
                        if self.EventGenre == 0 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#D9E021", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "jobhunt.png", w: self.view.frame.size.width*(105/640), h: self.view.frame.size.height*(105/1136))
                            
                            
                        } else if self.EventGenre == 1 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#E8DCC8", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "study.png", w: self.view.frame.size.width*(105/640), h: self.view.frame.size.height*(105/1136))
                            
                        } else if self.EventGenre == 2 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#42C187", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "party.png", w: self.view.frame.size.width*(105/640), h: self.view.frame.size.height*(105/1136))
                            
                        } else if self.EventGenre == 3 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#FF7F00", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "circle.png", w: self.view.frame.size.width*(105/640), h: self.view.frame.size.height*(105/1136))
                            
                        } else if self.EventGenre == 4 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#00CAE5", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "tournament.png", w: self.view.frame.size.width*(105/640), h: self.view.frame.size.height*(105/1136))
                            
                        } else if self.EventGenre == 5 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#C64479", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "hobby.png", w: self.view.frame.size.width*(105/640), h: self.view.frame.size.height*(105/1136))
                            
                        } else if self.EventGenre == 6 {
                            self.navigationController?.navigationBar.barTintColor = UIColor.hexStr("#FFD93B", alpha: 1.0)
                            self.genreImg =  CommonFunction().resizingImage(imageName: "readbook.png", w: self.view.frame.size.width*(105/640), h: self.view.frame.size.height*(105/1136))
                            
                        }
                        
                        self.window = UIWindow()
                        self.window.frame = CGRectMake(0, 0, self.view.frame.size.width*(105/640), self.view.frame.size.height*(105/1136))
                        self.window.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.frame.height/11)
                        self.window.backgroundColor = UIColor.clearColor()
                        self.window.makeKeyWindow()
                        self.window.makeKeyAndVisible()
                        let imgView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width*(105/640), self.view.frame.size.height*(105/1136)))
                        imgView.image = self.genreImg
                        self.window.addSubview(imgView)
                        
                    
                    
                    }
                }
        
        }
    
    }

    
    
    override func viewDidDisappear(animated: Bool) {
        genreImg =  CommonFunction().resizingImage(imageName: "tournament.png", w: self.view.bounds.width/100000000, h: self.view.bounds.height/100000)
        window = UIWindow()
        window.frame = CGRectMake(0, 0, 0, 0)
        window.layer.position = CGPoint(x: 0, y:0)
        window.backgroundColor = UIColor.clearColor()
        window.makeKeyWindow()
        window.makeKeyAndVisible()
        
        
        let imgView = UIImageView(frame: CGRectMake(0, 0, 0, 0))
        imgView.image = genreImg
        //        imgView.center = CGPointMake(self.view.frame.size.width/2, ((self.navigationController?.navigationBar.frame.size.height)!*0.6))
        window.addSubview(imgView)
        
        
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

    
    func onClickMyButton(sender: UIButton){
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
                        if let varow: Int = self.friendsNumber {
                            self.friendsNumber = varow
                        } else {
                            self.friendsNumber = 0
                        }
                        
                        if self.friendsNumber!+1 <= reserved {
                            let headers = [
                                "Content-Type": "application/json",
                                "Accept": "application/json"
                            ]
                            
                            let parameters:[String:AnyObject] =
                            [
                                "ticket": [
                                    "user_id": self.userID,
                                    "event_id": self.getID,
                                    "other_participant": self.friendsNumber
                                    
                                    
                                ]
                            ]
                            let PostUrl = "https://zerocafe.herokuapp.com/api/v1/tickets.json"
                            
                            Alamofire.request(.POST, PostUrl, parameters: parameters, encoding: .JSON, headers:headers)
                                .responseString { response in
                                    debugPrint(response.result.value)
                                    //"いいよぉ！"が返って来れば成功
                                    
                            }
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "\(self.getID)w")
                            let myEventsAttendViewController = EventsAttendViewController()
                            myEventsAttendViewController.getID = self.getID
                            myEventsAttendViewController.friendsNumber = self.friendsNumber
                            self.navigationController?.pushViewController(myEventsAttendViewController, animated: true)
                            
                            
                        } else {
                            let myAlert: UIAlertController = UIAlertController(title: "定員を超えています。", message: "", preferredStyle: .Alert)
                            let myOkAction = UIAlertAction(title: "OK", style: .Default) { action in
                            }
                            myAlert.addAction(myOkAction)
                            self.presentViewController(myAlert, animated: true, completion: nil)
                            
                        }
                        
                    }
                }
                
        }
        
        
        
        
        
        
        
    }
    func returnTop(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    // Do any additional setup after loading the view.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
