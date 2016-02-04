//
//  ViewController.swift
//  ZeroCafePlus
//
//  Created by 紺谷和正 on 2015/12/07.
//  Copyright © 2015年 紺谷和正. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForthViewController: UIViewController, EventViewDelegate {
    
    private var checkEventsButton: UIButton!
    private var profileLabel: UILabel!
    private var nameLabel: UILabel!
    private var profileImage: UIImageView!
    private var statusLabel: UILabel!
    private var user_name: String!
    private var planningView: UIView!
    private var attendView: UIView!
    private var endView: UIView!
    private var user_events: UIView!
    private var events_title: UILabel!
    private var events_date: UILabel!
    private var events_tags: UILabel!
    private var count:Int = 0
    private var scrollViewHeader: UIScrollView!
    private var scrollViewMain: UIScrollView!
    private var pageControl: UIPageControl!
    private var editProfile: UIButton!
    
    private var horizontalSV:UIScrollView!
    
    private var willJoinButton: UIButton!
    private var planedButton:UIButton!
    private var joinedButton:UIButton!
    
    private var willJoin2Button:UIButton!
    private var planed2Button:UIButton!
    private var joined2Button:UIButton!
    
    private var willJoin3Button: UIButton!
    private var planed3Button:UIButton!
    private var joined3Button:UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        view.backgroundColor = UIColor.whiteColor()
        
        profileLabel = UILabel(frame: CGRectMake(0,0,screenWidth/1.2,screenHeight/4))
        profileLabel.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/2.7)
        profileLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        profileLabel.text = ""
        profileLabel.numberOfLines = 0
        profileLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        profileLabel.backgroundColor = UIColor.redColor()
        profileLabel.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(profileLabel)
        
        nameLabel = UILabel(frame: CGRectMake(0,0,screenWidth/2.4,screenHeight/15))
        nameLabel.layer.position = CGPoint(x: screenWidth/1.94, y: screenHeight/6.5)
        nameLabel.text = ""
        nameLabel.font = UIFont.systemFontOfSize(25)
        nameLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        nameLabel.textAlignment = NSTextAlignment.Left
        self.view.addSubview(nameLabel)
        
        statusLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/19))
        statusLabel.layer.position = CGPoint(x: screenWidth/2.1, y: screenHeight/4.8)
        statusLabel.text = ""
        statusLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        statusLabel.font = UIFont.systemFontOfSize(14)
        statusLabel.textAlignment = NSTextAlignment.Center
        statusLabel.numberOfLines = 0
        self.view.addSubview(statusLabel)
        
        editProfile = UIButton(frame: CGRectMake(0,0,screenWidth/5.2, screenHeight/23.6))
        editProfile.layer.position = CGPoint(x: screenWidth - screenWidth/7.95, y: screenHeight/15.35)
        editProfile.setImage(UIImage(named: "profile_edit.png"), forState: .Normal)
        editProfile.addTarget(self, action: "clickBarButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(editProfile)
        
        profileImage = UIImageView(image: UIImage(named: "twitter-icon.png"))
        profileImage.frame = CGRectMake(0, 0, screenWidth/5.6, screenWidth/5.6)
        profileImage.layer.position = CGPoint(x: screenWidth/5.981, y: screenHeight/5.947)
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 8.0
        self.view.addSubview(profileImage)
        
        //        let kitView = UIView()
        //        let kuView = UIView()
        //        let favoriteView = UIView()
        //        let views = [kitView,kuView, favoriteView]
        
        //1page
        
        willJoinButton = UIButton()
        willJoinButton.layer.position = CGPoint(x: screenWidth/5, y: screenHeight/2)
        willJoinButton.setTitle("参加予定", forState: .Normal)
        willJoinButton.layer.cornerRadius = 18.0
        willJoinButton.layer.masksToBounds = true
        willJoinButton.backgroundColor = UIColor.hexStr("#ff8010", alpha: 1.0)
        willJoinButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        willJoinButton.setTitleColor(UIColor.hexStr("#ffffff", alpha: 1.0), forState: .Normal)
        willJoinButton.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(willJoinButton)
        willJoinButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            
            // self.veiwの上から0pxの位置に配置
            NSLayoutConstraint(
                item: willJoinButton,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: profileLabel,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: screenWidth/20
            ),
            NSLayoutConstraint(
                item: willJoinButton,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Left,
                multiplier: 1.0,
                constant:screenWidth/13.913
            ),
            // 横（固定）
            NSLayoutConstraint(
                item: willJoinButton,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1.0,
                constant: screenWidth/3.55
            ),
            
            // 縦（固定）
            NSLayoutConstraint(
                item: self.willJoinButton,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Height,
                multiplier: 1.0,
                constant: screenHeight/19
                
            )]
        )
        
        planedButton = UIButton()
        planedButton.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        planedButton.setTitle("企画", forState: .Normal)
        planedButton.layer.cornerRadius = 18.0
        planedButton.layer.borderColor = UIColor.hexStr("#ff8010", alpha: 1.0).CGColor
        planedButton.layer.borderWidth = 1.3
        planedButton.layer.masksToBounds = true
        planedButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        planedButton.setTitleColor(UIColor.hexStr("#ff8010", alpha: 1.0), forState: .Normal)
        planedButton.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(planedButton)
        planedButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            
            // self.veiwの上から0pxの位置に配置
            NSLayoutConstraint(
                item: planedButton,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: profileLabel,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: screenWidth/20
            ),
            NSLayoutConstraint(
                item: planedButton,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Left,
                multiplier: 1.0,
                constant:screenWidth/2.7
            ),
            // 横（固定）
            NSLayoutConstraint(
                item: planedButton,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1.0,
                constant: screenWidth/3.55
            ),
            
            // 縦（固定）
            NSLayoutConstraint(
                item: self.planedButton,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Height,
                multiplier: 1.0,
                constant: screenHeight/19
                
            )]
        )
        
        joinedButton = UIButton()
        joinedButton.layer.position = CGPoint(x: screenWidth/1.25, y: screenHeight/2)
        joinedButton.setTitle("参加", forState: .Normal)
        joinedButton.layer.cornerRadius = 18.0
        joinedButton.layer.borderColor = UIColor.hexStr("#ff8010", alpha: 1.0).CGColor
        joinedButton.layer.borderWidth = 1.3
        joinedButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        joinedButton.setTitleColor(UIColor.hexStr("#ff8010", alpha: 1.0), forState: .Normal)
        joinedButton.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(joinedButton)
        joinedButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            
            // self.veiwの上から0pxの位置に配置
            NSLayoutConstraint(
                item: joinedButton,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: profileLabel,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: screenWidth/20
            ),
            NSLayoutConstraint(
                item: joinedButton,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Left,
                multiplier: 1.0,
                constant:screenWidth/1.502
            ),
            // 横（固定）
            NSLayoutConstraint(
                item: joinedButton,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1.0,
                constant: screenWidth/3.55
            ),
            
            // 縦（固定）
            NSLayoutConstraint(
                item: joinedButton,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Height,
                multiplier: 1.0,
                constant: screenHeight/19
                
            )]
        )
        
        
        //2page
        
        willJoin2Button = UIButton(frame: CGRectMake(0,0,screenWidth/3.55,screenHeight/18))
        willJoin2Button.layer.position = CGPoint(x: screenWidth+screenWidth/6, y: screenHeight/2)
        willJoin2Button.setTitle("参加予定", forState: .Normal)
        willJoin2Button.layer.cornerRadius = 18.0
        willJoin2Button.titleLabel?.font = UIFont.systemFontOfSize(16)
        willJoin2Button.setTitleColor(UIColor.hexStr("#ff8010", alpha: 1.0), forState: .Normal)
        willJoin2Button.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(willJoin2Button)
        
        planed2Button = UIButton(frame: CGRectMake(0,0,screenWidth/3.55,screenHeight/18))
        planed2Button.layer.position = CGPoint(x: screenWidth+screenWidth/2, y: screenHeight/2)
        planed2Button.setTitle("企画", forState: .Normal)
        planed2Button.layer.cornerRadius = 18.0
        planed2Button.backgroundColor = UIColor.hexStr("#ff8010", alpha: 1.0)
        planed2Button.titleLabel?.font = UIFont.systemFontOfSize(16)
        planed2Button.setTitleColor(UIColor.hexStr("#ffffff", alpha: 1.0), forState: .Normal)
        planed2Button.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(planed2Button)
        
        joined2Button = UIButton(frame: CGRectMake(0,0,screenWidth/3.55,screenHeight/18))
        joined2Button.layer.position = CGPoint(x: screenWidth+screenWidth/1.3, y: screenHeight/2)
        joined2Button.setTitle("参加", forState: .Normal)
        joined2Button.layer.cornerRadius = 18.0
        joined2Button.titleLabel?.font = UIFont.systemFontOfSize(16)
        joined2Button.setTitleColor(UIColor.hexStr("#ff8010", alpha: 1.0), forState: .Normal)
        joined2Button.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(joined2Button)
        
        //3page
        
        willJoin3Button = UIButton(frame: CGRectMake(0,0,screenWidth/3.55,screenHeight/18))
        willJoin3Button.layer.position = CGPoint(x: screenWidth*2+screenWidth/6, y: screenHeight/2)
        willJoin3Button.setTitle("参加予定", forState: .Normal)
        willJoin3Button.layer.cornerRadius = 18.0
        willJoin3Button.titleLabel?.font = UIFont.systemFontOfSize(16)
        willJoin3Button.setTitleColor(UIColor.hexStr("#ff8010", alpha: 1.0), forState: .Normal)
        willJoin3Button.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(willJoin3Button)
        
        planed3Button = UIButton(frame: CGRectMake(0,0,screenWidth/3,screenHeight/18))
        planed3Button.layer.position = CGPoint(x: screenWidth*2+screenWidth/2, y: screenHeight/2)
        planed3Button.setTitle("企画", forState: .Normal)
        planed3Button.layer.cornerRadius = 18.0
        planed3Button.titleLabel?.font = UIFont.systemFontOfSize(16)
        planed3Button.setTitleColor(UIColor.hexStr("#ff8010", alpha: 1.0), forState: .Normal)
        planed3Button.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(planed3Button)
        
        joined3Button = UIButton(frame: CGRectMake(0,0,screenWidth/3,screenHeight/18))
        joined3Button.layer.position = CGPoint(x: screenWidth*2+screenWidth/1.3, y: screenHeight/2)
        joined3Button.setTitle("参加", forState: .Normal)
        joined3Button.layer.cornerRadius = 18.0
        joined3Button.backgroundColor = UIColor.hexStr("#ff8010", alpha: 1.0)
        joined3Button.titleLabel?.font = UIFont.systemFontOfSize(16)
        joined3Button.setTitleColor(UIColor.hexStr("#ffffff", alpha: 1.0), forState: .Normal)
        joined3Button.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(joined3Button)
        horizontalSV = UIScrollView()
        horizontalSV.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/1.2)
        self.view.addSubview(horizontalSV)
        horizontalSV.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            
            // self.veiwの上から0pxの位置に配置
            NSLayoutConstraint(
                item: horizontalSV,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: willJoinButton,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: screenWidth/40.57
            ),
            // 横（固定）
            NSLayoutConstraint(
                item: horizontalSV,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1.0,
                constant: screenWidth*1.1
            ),
            NSLayoutConstraint(
                item: horizontalSV,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Left,
                multiplier: 1.0,
                constant: -10
            ),
            
            // 縦（固定）
            NSLayoutConstraint(
                item: horizontalSV,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Height,
                multiplier: 1.0,
                constant: screenHeight/1.6
                
            )]
        )
        horizontalSV.pagingEnabled = true
        horizontalSV.directionalLockEnabled = true
        horizontalSV.contentSize.width = view.frame.size.width * 3.0
        horizontalSV.backgroundColor = UIColor.whiteColor()
        horizontalSV.layer.borderColor = UIColor.hexStr("#1A1A1A", alpha: 1.0).CGColor
        horizontalSV.layer.borderWidth = 1.5
        for i in 0...2 {
            let viewHeight = CGFloat(128)
            
            let x = view.frame.width * CGFloat(i)
            let scrollview = UIScrollView(frame: CGRectMake(x, 0, view.frame.size.width, view.frame.size.height))
            
            horizontalSV.addSubview(scrollview)
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let url = "https://zerocafe.herokuapp.com/api/v1/users"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    let users = json["users"].array! as Array
                    
                    for user in users {
                        
                        let user_id = user["user"]["id"].int!
                        if user_id == 1 {
                            self.user_name = user["user"]["name"].string!
                            self.statusLabel.text = user["user"]["major"].string!
                            self.statusLabel.sizeToFit()
                            self.profileLabel.frame = CGRectMake(0,0,screenWidth/1.2,screenHeight/4)
                            self.profileLabel.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/2.7)
                            self.profileLabel.text = user["user"]["description"].string!
                            self.profileLabel.sizeToFit()
                            self.nameLabel.text = self.user_name
                        }
                        
                    }
                    
                    
                } else {
                }
                
        }
        
        let url2 = "https://zerocafe.herokuapp.com/api/v1/events"
        Alamofire.request(.GET, url2)
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    let eventArray = json["events"].array! as Array
                    let eventLastId = eventArray.count
                    print("持ってきたもの:",eventArray)
                    
                    var myX :CGFloat = 6
                    var myY :CGFloat = 60
                    
                    for events in eventArray.enumerate(){
                        
                        let sideDecide = events.index % 2
                        if sideDecide == 0 {
                            let eve = events.element as JSON
                            let eventID = eve["event"]["id"].int
                            let title = eve["event"]["title"].string! as String
                            let dateName = eve["event"]["start_time"].string! as String
                            let tagName : String? = { ()->(String) in
                                if eve["event"]["category_tag"] == nil{
                                    return ""
                                }else {
                                    return eve["event"]["category_tag"].string! as String
                                }
                            }()
                            print(tagName)
                            let eventViewGenerate:EventView = EventView(frame:CGRectMake(myX,myY, 150, 200),titleNameString: title,id:eventID!, dateNameString: dateName, tagNameString: tagName!)
                            eventViewGenerate.mydelegate = self
                            eventViewGenerate.layer.cornerRadius = 10
                            eventViewGenerate.layer.borderColor = UIColor.hexStr("#1A1A1A", alpha: 1.0).CGColor
                            eventViewGenerate.layer.borderWidth = 1.5
                            self.horizontalSV.addSubview(eventViewGenerate)
                            myX = 162
                        }else{
                            
                            let eve = events.element as JSON
                            let eventID = eve["event"]["id"].int
                            let title = eve["event"]["title"].string! as String
                            let dateName = eve["event"]["start_time"].string! as String
                            let tagName : String? = { ()->(String) in
                                if eve["event"]["category_tag"] == nil{
                                    return ""
                                }else {
                                    return eve["event"]["category_tag"].string! as String
                                }
                            }()
                            let eventViewGenerate:EventView = EventView(frame:CGRectMake(myX,myY, 150, 200),titleNameString: title,id: eventID!, dateNameString: dateName, tagNameString: tagName!)
                            eventViewGenerate.mydelegate = self
                            eventViewGenerate.layer.cornerRadius = 10
                            eventViewGenerate.layer.borderColor = UIColor.hexStr("#1A1A1A", alpha: 1.0).CGColor
                            eventViewGenerate.layer.borderWidth = 1.5
                            self.horizontalSV.addSubview(eventViewGenerate)
                            
                            myX = 6
                            myY += 212
                        }
                        
                        self.horizontalSV.contentSize.height = CGFloat((eventArray.count / 2) * 212 + 150)
                        
                    }
                    
                }else {
                    print("通信失敗")
                }
        }
    }
    
    func pushMyButton(myEventID:Int) {
        let eventsdetails = EventsDetailViewController()
        eventsdetails.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        presentViewController(self, animated: true, completion: nil)
    }
    
    func clickBarButton(sender: UIButton){
        let epv = EditProfileViewController()
        epv.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        presentViewController(epv, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension UIColor {
    class func hexStr (var hexStr : NSString, alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}

