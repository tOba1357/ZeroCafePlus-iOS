//
//  ParticipantsImageViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by Ryunosuke Higuchi on 2016/02/27.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Accounts
import Foundation
import Social

class ParticipantsImageViewController: UIViewController {
    
    private var starButton: UIButton!
    private var starSelectedButton: UIButton!
    private var genreImg:UIImage!
    private var participantsImage: UIImageView!
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
        
        starImage1 =  CommonFunction().resizingImage(imageName: "star.png", w: self.view.bounds.width/17.30, h: self.view.bounds.height/30.70)     //UIImage(named: "star.png")
        starImage2 = CommonFunction().resizingImage(imageName: "star_selected.png", w: self.view.bounds.width/17.30, h: self.view.bounds.height/30.70)

        
        

        self.view.backgroundColor = UIColor.whiteColor()
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
        let EventsUrl = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, EventsUrl)
            .responseJSON { response in
                
                let json = JSON(response.result.value!)
                let eventArray = json["events"].array! as Array
                for events in eventArray {
                    let id = events["event"]["id"].int! as Int
                    if  id == self.getID {
                        print(self.userID)
                        let participants: Int? = events["event"]["participant"].int
                        if participants != nil {
                            let participantsArray = events["participants"].array! as Array
                            var count: Int = 1
                            var RightSift: CGFloat = 0
                            var verticalSift: CGFloat = 0
                            for ptcpnts in participantsArray {
            
                                    self.participantsImage = UIImageView(image: UIImage(named: "twitter-icon.png"))
                                    self.participantsImage.frame = CGRectMake(0, 0, self.view.bounds.width/5.6, self.view.bounds.height/5.6)
                                    self.participantsImage.layer.position = CGPoint(x: self.view.bounds.width/5.981, y: self.view.bounds.height/5.947)
                                    self.participantsImage.layer.masksToBounds = true
                                    self.participantsImage.layer.cornerRadius = 8.0
                                    self.view.addSubview(self.participantsImage)
                                    self.participantsImage.translatesAutoresizingMaskIntoConstraints = false
                                    self.view.addConstraints([
                                        NSLayoutConstraint(item: self.participantsImage, attribute: .Top,    relatedBy: .Equal, toItem: self.view,   attribute: .Top, multiplier: 1, constant: self.view.bounds.height*(230/1136) + verticalSift),
                                        NSLayoutConstraint(item: self.participantsImage, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant: self.view.bounds.width*(61/640) + RightSift),
                                        NSLayoutConstraint(item: self.participantsImage, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .Width,   multiplier: 1, constant: self.view.bounds.width*(107/640)),
                                        NSLayoutConstraint(item: self.participantsImage, attribute: .Height, relatedBy: .Equal, toItem: nil,   attribute: .Height, multiplier: 1, constant: self.view.bounds.height*(107/1136))
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
                                    
                                    RightSift += self.view.bounds.width*(139/640)
                                    count += 1

                                if count == 5 {
                                    verticalSift += self.view.bounds.height*(140/1136)
                                    RightSift = 0
                                    count = 1
                                }
                                
                                
                            }
                        }

                        
                        
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
    
    func onClickMyButton(sender: UIButton){
        let myEventsAttendViewController = EventsAttendViewController()
        myEventsAttendViewController.getID = getID
        self.navigationController?.pushViewController(myEventsAttendViewController, animated: true)
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
