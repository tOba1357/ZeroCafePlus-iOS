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
    
    private var planEV: String!
    private var eveID:Int!
    
    private var willJoinButton: UILabel!
    private var nonwillJoinButton: UILabel!
    private var planedButton:UILabel!
    private var nonplanedButton:UILabel!
    private var joinedButton:UILabel!
    private var nonjoinedButton:UILabel!
    
    private var kitVerticalSV: UIScrollView!
    private var kuVerticalSV: UIScrollView!
    private var favoriteVerticalSV: UIScrollView!
    private var kitView: UIView!
    private var kuView:UIView!
    private var favoriteView:UIView!
    private var selectedKitView:UIView!
    private var selectedKuView:UIView!
    private var selectedFavoriteView :UIView!
    private var horizontalSV: UIScrollView!
    
    var getID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        kitView = UIView()
        kuView = UIView()
        favoriteView = UIView()
        selectedKitView = UIView()
        selectedKuView = UIView()
        selectedFavoriteView = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        profileLabel = UILabel(frame: CGRectMake(0,0,screenWidth/1.2,screenHeight/4))
        profileLabel.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/2.7)
        profileLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        profileLabel.text = ""
        profileLabel.numberOfLines = 0
        profileLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        profileLabel.backgroundColor = UIColor.whiteColor()
        profileLabel.font = UIFont.systemFontOfSize(15)
        self.view.addSubview(profileLabel)
        
        nameLabel = UILabel(frame: CGRectMake(0,0,screenWidth/2.4,screenHeight/15))
        nameLabel.layer.position = CGPoint(x: screenWidth/1.94, y: screenHeight/6.5)
        nameLabel.text = ""
        nameLabel.font = UIFont.systemFontOfSize(23)
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
        
        editProfile = UIButton(frame: CGRectMake(0,0,screenWidth/5, screenHeight/23))
        editProfile.layer.position = CGPoint(x: screenWidth - screenWidth/7.6, y: screenHeight/15.35)
        editProfile.setImage(UIImage(named: "profile_edit.png"), forState: .Normal)
        editProfile.addTarget(self, action: "clickBarButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(editProfile)
        
        profileImage = UIImageView(image: UIImage(named: "twitter-icon.png"))
        profileImage.frame = CGRectMake(0, 0, screenWidth/5.6, screenWidth/5.6)
        profileImage.layer.position = CGPoint(x: screenWidth/5.981, y: screenHeight/5.947)
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 8.0
        self.view.addSubview(profileImage)
        
        kitVerticalSV = UIScrollView()
        kuVerticalSV = UIScrollView()
        favoriteVerticalSV = UIScrollView()
        
        kitVerticalSV.pagingEnabled = false
        kuVerticalSV.pagingEnabled = false
        favoriteVerticalSV.pagingEnabled = false
        
        
        willJoinButton = UILabel(frame: CGRectMake(kitView.layer.frame.width,0,screenWidth/3.7,screenHeight/19))
        willJoinButton.textAlignment = NSTextAlignment.Center
        willJoinButton.text = "参加予定"
        willJoinButton.layer.position.y = screenHeight/15
        willJoinButton.layer.position.x = 75
        willJoinButton.layer.cornerRadius = 18.0
        willJoinButton.layer.masksToBounds = true
        willJoinButton.backgroundColor = UIColor.hexStr("#ff8010", alpha: 1.0)
        willJoinButton.layer.borderColor = UIColor.hexStr("#ff8010", alpha: 1.0).CGColor
        willJoinButton.layer.borderWidth = 1.3
        willJoinButton.font = UIFont.systemFontOfSize(15)
        willJoinButton.textColor = UIColor.hexStr("#ffffff", alpha: 1.0)
        kitView.addSubview(willJoinButton)
        
        
        nonwillJoinButton = UILabel(frame: CGRectMake(0,0,screenWidth/3.8,screenHeight/19))
        nonwillJoinButton.text = "参加予定"
        nonwillJoinButton.textAlignment = NSTextAlignment.Center
        nonwillJoinButton.layer.position.x = 75
        nonwillJoinButton.layer.position.y = screenHeight/15
        nonwillJoinButton.layer.cornerRadius = 18.0
        nonwillJoinButton.layer.masksToBounds = true
        nonwillJoinButton.backgroundColor = UIColor.whiteColor()
        nonwillJoinButton.font = UIFont.systemFontOfSize(15)
        nonwillJoinButton.layer.borderColor = UIColor.hexStr("#ff8010", alpha: 1.0).CGColor
        nonwillJoinButton.layer.borderWidth = 1.3
        nonwillJoinButton.textColor = UIColor.hexStr("#ff8010", alpha: 1.0)
        selectedKitView.addSubview(nonwillJoinButton)
        
        planedButton = UILabel(frame: CGRectMake(0,0,screenWidth/3.8,screenHeight/19))
        planedButton.text = "企画"
        planedButton.textAlignment = NSTextAlignment.Center
        planedButton.layer.position.x = 60
        planedButton.layer.position.y = screenHeight/15
        planedButton.textColor = UIColor.hexStr("#ffffff", alpha: 1.0)
        planedButton.backgroundColor = UIColor.hexStr("#ff8010", alpha: 1.0)
        planedButton.layer.cornerRadius = 18.0
        planedButton.layer.borderColor = UIColor.hexStr("#ff8010", alpha: 1.0).CGColor
        planedButton.layer.borderWidth = 1.3
        planedButton.layer.masksToBounds = true
        planedButton.font = UIFont.systemFontOfSize(15)
        kuView.addSubview(planedButton)
        
        nonplanedButton = UILabel(frame: CGRectMake(0,0,screenWidth/3.8,screenHeight/19))
        nonplanedButton.text = "企画"
        nonplanedButton.layer.position.x = 60
        nonplanedButton.textAlignment = NSTextAlignment.Center
        nonplanedButton.layer.position.y = screenHeight/15
        nonplanedButton.textColor = UIColor.hexStr("#ff8010", alpha: 1.0)
        nonplanedButton.backgroundColor = UIColor.whiteColor()
        nonplanedButton.layer.cornerRadius = 18.0
        nonplanedButton.layer.borderColor = UIColor.hexStr("#ff8010", alpha: 1.0).CGColor
        nonplanedButton.layer.borderWidth = 1.3
        nonplanedButton.layer.masksToBounds = true
        nonplanedButton.font = UIFont.systemFontOfSize(15)
        selectedKuView.addSubview(nonplanedButton)
        
        joinedButton = UILabel(frame: CGRectMake(0,0,screenWidth/3.8,screenHeight/19))
        joinedButton.layer.position = CGPoint(x: screenWidth/1.25, y: screenHeight/2)
        joinedButton.text = "参加"
        joinedButton.textAlignment = NSTextAlignment.Center
        joinedButton.layer.position.x = 45
        joinedButton.layer.position.y = screenHeight/15
        joinedButton.layer.cornerRadius = 18.0
        joinedButton.layer.masksToBounds = true
        joinedButton.textColor = UIColor.hexStr("#ffffff", alpha: 1.0)
        joinedButton.layer.borderColor = UIColor.hexStr("#ff8010", alpha: 1.0).CGColor
        joinedButton.layer.borderWidth = 1.3
        joinedButton.font = UIFont.systemFontOfSize(15)
        joinedButton.backgroundColor = UIColor.hexStr("#ff8010", alpha: 1.0)
        favoriteView.addSubview(joinedButton)
        
        nonjoinedButton = UILabel(frame: CGRectMake(0,0,screenWidth/3.8,screenHeight/19))
        nonjoinedButton.text = "参加"
        nonjoinedButton.textAlignment = NSTextAlignment.Center
        nonjoinedButton.layer.position.x = 45
        nonjoinedButton.layer.position.y = screenHeight/15
        nonjoinedButton.layer.cornerRadius = 18.0
        nonjoinedButton.layer.borderColor = UIColor.hexStr("#ff8010", alpha: 1.0).CGColor
        nonjoinedButton.layer.borderWidth = 1.3
        nonjoinedButton.layer.masksToBounds = true
        nonjoinedButton.font = UIFont.systemFontOfSize(15)
        nonjoinedButton.textColor = UIColor.hexStr("#ff8010", alpha: 1.0)
        selectedFavoriteView.addSubview(nonjoinedButton)
        
        
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
                    var myX :CGFloat = 6
                    var myY :CGFloat = 6
                    var kuX :CGFloat = 6
                    var kuY :CGFloat = 6
                    
                    for user in users {
                        let user_id = user["user"]["id"].int!
                        if user_id == 1 {
                            self.user_name = user["user"]["name"].string!
                            self.statusLabel.text = user["user"]["major"].string!
                            self.statusLabel.sizeToFit()
                            self.profileLabel.frame = CGRectMake(0,0,screenWidth/1.2,screenHeight/4)
                            self.profileLabel.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/2.7)
                            self.profileLabel.text = user["user"]["description"].string!
                            let attributedText = NSMutableAttributedString(string: self.profileLabel.text!)
                            let paragraphStyle = NSMutableParagraphStyle()
                            paragraphStyle.lineSpacing = self.view.bounds.height/90
                            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
                            self.profileLabel.attributedText = attributedText
                            self.profileLabel.sizeToFit()
                            self.nameLabel.text = self.user_name
                            let plan_ev = user["attend_events"].array! as Array
                            for attendEvCount in plan_ev.enumerate() {
                                
                                let sideDecide = attendEvCount.index % 2
                                if sideDecide == 0 {
                                    let eve = attendEvCount.element as JSON
                                    let genreImage = eve["event"]["genre"].int
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
                                    let eventViewGenerate:EventView2 = EventView2(frame:CGRectMake(myX,myY, screenWidth/2.1192, 200),titleNameString: title,id:eventID!, dateNameString: dateName, tagNameString: tagName!,genreImageNum: genreImage!)
                                    eventViewGenerate.mydelegate = self
                                    eventViewGenerate.layer.cornerRadius = 10
                                    self.kitVerticalSV.addSubview(eventViewGenerate)
                                    
                                    myX = screenWidth/1.96319018
                                }else{
                                    
                                    let eve = attendEvCount.element as JSON
                                    let eventID = eve["event"]["id"].int
                                    let genreImage = eve["event"]["genre"].int
                                    let title = eve["event"]["title"].string! as String
                                    let dateName = eve["event"]["start_time"].string! as String
                                    let tagName : String? = { ()->(String) in
                                        if eve["event"]["category_tag"] == nil{
                                            return ""
                                        }else {
                                            return eve["event"]["category_tag"].string! as String
                                        }
                                    }()
                                    let eventViewGenerate:EventView2 = EventView2(frame:CGRectMake(myX,myY, screenWidth/2.1192, 200),titleNameString: title,id: eventID!, dateNameString: dateName, tagNameString: tagName!, genreImageNum: genreImage!)
                                    eventViewGenerate.mydelegate = self
                                    eventViewGenerate.layer.cornerRadius = 10
                                    self.kitVerticalSV.addSubview(eventViewGenerate)
                                    
                                    myX = 6
                                    myY += 206
                                }
                                
                                self.kitVerticalSV.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/1.6)
                                self.kitVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((plan_ev.count + 1) / 2) * 212 + 93))
                                self.kitVerticalSV.contentOffset = CGPointMake(0, -50)
                                self.kitVerticalSV.backgroundColor = UIColor.whiteColor()
                            }
                            
                            
                            let planning_ev = user["planning_events"].array! as Array
                            for (index,planEvCount) in planning_ev.enumerate() {
                                let eveCount = planEvCount.count
                                if  index % 2 == 0 {
                                    kuX = 6
                                    let eventID = planEvCount["event"]["id"].int
                                    let genreImage = planEvCount["event"]["genre"].int
                                    let title = planEvCount["event"]["title"].string! as String
                                    let dateName = planEvCount["event"]["start_time"].string! as String
                                    let tagName : String? = { ()->(String) in
                                        if planEvCount["event"]["category_tag"] == nil{
                                            return ""
                                        }else {
                                            return planEvCount["event"]["category_tag"].string! as String
                                        }
                                    }()
                                    print(tagName)
                                    let eventViewGenerate:EventView2 = EventView2(frame:CGRectMake(kuX,kuY, screenWidth/2.1192, 200),titleNameString: title,id:eventID!, dateNameString: dateName, tagNameString: tagName!, genreImageNum: genreImage!)
                                    eventViewGenerate.mydelegate = self
                                    eventViewGenerate.layer.cornerRadius = 10
                                    
                                    self.kuVerticalSV.addSubview(eventViewGenerate)
                                    
                                }else{
                                    kuX = screenWidth/1.96319018
                                    let eventID = planEvCount["event"]["id"].int
                                    let genreImage = planEvCount["event"]["genre"].int
                                    let title = planEvCount["event"]["title"].string! as String
                                    let dateName = planEvCount["event"]["start_time"].string! as String
                                    let tagName : String? = { ()->(String) in
                                        if planEvCount["event"]["category_tag"] == nil{
                                            return ""
                                        }else {
                                            return planEvCount["event"]["category_tag"].string! as String
                                        }
                                    }()
                                    let eventViewGenerate2:EventView2 = EventView2(frame:CGRectMake(kuX,kuY, screenWidth/2.1192, 200),titleNameString: title,id: eventID!, dateNameString: dateName, tagNameString: tagName!,genreImageNum: genreImage!)
                                    eventViewGenerate2.mydelegate = self
                                    eventViewGenerate2.layer.cornerRadius = 10
                                    self.kuVerticalSV.addSubview(eventViewGenerate2)
                                    
                                    kuY += 206
                                }
                                
                                self.kuVerticalSV.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/1.6)
                                self.kuVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((eveCount + 1) / 2) * 212 + 93))
                                self.kuVerticalSV.contentOffset = CGPointMake(0, -50)
                                self.kuVerticalSV.backgroundColor = UIColor.whiteColor()
                            }
                            
                            let end_ev = user["end_events"].array! as Array
                            for (index,endEvCount) in end_ev.enumerate() {
                                let eveCount = endEvCount.count
                                if index % 2 == 0{
                                    kuX = 6
                                    let eventID = endEvCount["event"]["id"].int
                                    let genreImage = endEvCount["event"]["genre"].int
                                    let title = endEvCount["event"]["title"].string! as String
                                    let dateName = endEvCount["event"]["start_time"].string! as String
                                    let tagName : String? = { ()->(String) in
                                        if endEvCount["event"]["category_tag"] == nil{
                                            return ""
                                        }else {
                                            return endEvCount["event"]["category_tag"].string! as String
                                        }
                                    }()
                                    let eventViewGenerate:EventView2 = EventView2(frame:CGRectMake(kuX,kuY, screenWidth/2.1192, 200),titleNameString: title,id:eventID!, dateNameString: dateName, tagNameString: tagName!,genreImageNum: genreImage!)
                                    eventViewGenerate.mydelegate = self
                                    eventViewGenerate.layer.cornerRadius = 10
                                    self.favoriteVerticalSV.addSubview(eventViewGenerate)
                                    
                                }else{
                                    kuX = screenWidth/1.96319018
                                    let eventID = endEvCount["event"]["id"].int
                                    let genreImage = endEvCount["event"]["genre"].int
                                    let title = endEvCount["event"]["title"].string! as String
                                    let dateName = endEvCount["event"]["start_time"].string! as String
                                    let tagName : String? = { ()->(String) in
                                        if endEvCount["event"]["category_tag"] == nil{
                                            return ""
                                        }else {
                                            return endEvCount["event"]["category_tag"].string! as String
                                        }
                                    }()
                                    let eventViewGenerate3:EventView2 = EventView2(frame:CGRectMake(kuX,kuY, screenWidth/2.1192, 200),titleNameString: title,id: eventID!, dateNameString: dateName, tagNameString: tagName!,genreImageNum: genreImage!)
                                    eventViewGenerate3.mydelegate = self
                                    eventViewGenerate3.tag = 3
                                    eventViewGenerate3.layer.cornerRadius = 10
                                    self.favoriteVerticalSV.addSubview(eventViewGenerate3)
                                    
                                    kuY += 206
                                }
                                self.favoriteVerticalSV.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/1.6)
                                self.favoriteVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((eveCount + 1) / 2) * 212 + 93))
                                self.favoriteVerticalSV.contentOffset = CGPointMake(0, -50)
                                self.favoriteVerticalSV.backgroundColor = UIColor.whiteColor()
                                
                            }
                        }
                        let views = [
                            ViewPagerElement2(selectedTitleView: self.kitView, noSelectedTitleView: self.selectedKitView, mainView: self.kitVerticalSV),
                            ViewPagerElement2(selectedTitleView: self.kuView, noSelectedTitleView: self.selectedKuView, mainView: self.kuVerticalSV),
                            ViewPagerElement2(selectedTitleView: self.favoriteView, noSelectedTitleView: self.selectedFavoriteView, mainView: self.favoriteVerticalSV)
                        ]
                        let frame = CGRect(x: 0, y: 10, width: self.view.frame.width, height: self.view.frame.height - 10)
                        let tabView = ViewPager2(frame: frame, tabHeigh: screenHeight/11, views: views)
                        self.view.addSubview(tabView)
                        tabView.translatesAutoresizingMaskIntoConstraints = false
                        self.view.addConstraints([
                            
                            NSLayoutConstraint(
                                item: tabView,
                                attribute: NSLayoutAttribute.Top,
                                relatedBy: NSLayoutRelation.Equal,
                                toItem: self.profileLabel,
                                attribute: NSLayoutAttribute.Bottom,
                                multiplier: 1.0,
                                constant: screenWidth/40.57
                            ),
                            // 横（固定）
                            NSLayoutConstraint(
                                item: tabView,
                                attribute: .Width,
                                relatedBy: .Equal,
                                toItem: nil,
                                attribute: .Width,
                                multiplier: 1.0,
                                constant: screenWidth
                            ),
                            
                            // 縦（固定）
                            NSLayoutConstraint(
                                item: tabView,
                                attribute: .Height,
                                relatedBy: .Equal,
                                toItem: nil,
                                attribute: .Height,
                                multiplier: 1.0,
                                constant: screenHeight/1.9
                                
                            )]
                        )
                        
                    }
                }
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func pushMyButton(myEventID:Int) {
        
        print("success")
        let eventAttendVC = EventsAttendViewController()
        eventAttendVC.getID = myEventID
        print("")
        eventAttendVC.modalTransitionStyle  = UIModalTransitionStyle.CoverVertical
        presentViewController(eventAttendVC, animated: true, completion: nil)
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

