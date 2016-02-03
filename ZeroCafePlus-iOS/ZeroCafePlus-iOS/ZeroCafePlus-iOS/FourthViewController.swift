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

class ForthViewController: UIViewController {
    
    private var checkEventsButton: UIButton!
    private var planedButton: UIButton!
    private var joinedButton: UIButton!
    private var profileLabel: UILabel!
    private var nameLabel: UILabel!
    private var profileImage: UIImageView!
    private var statusLabel: UILabel!
    private var user_name: String!
    private var planningView: UIView!
    private var attendView: UIView!
    private var endView: UIView!
    let new_name = NSUserDefaults.standardUserDefaults()
    private var user_events: UIView!
    private var events_title: UILabel!
    private var events_date: UILabel!
    private var events_tags: UILabel!
    private var count:Int = 0
    private var scrollViewHeader: UIScrollView!
    private var scrollViewMain: UIScrollView!
    private var pageControl: UIPageControl!
    private var editProfile: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.title = ""
        view.backgroundColor = UIColor.whiteColor()
        new_name.removeObjectForKey("NewName");
        new_name.synchronize()
        
        profileLabel = UILabel(frame: CGRectMake(0,0,screenWidth/1.2,screenHeight/2.3))
        profileLabel.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/2.1)
        profileLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        profileLabel.text = "金沢大学のtkmtです。プロフィール文言プロフィール文言プロフィール文言プロフィール文言プロフィール文言プロフィール文言プロフィール文言プロフィール文言プロフィール文言プロフィール文言"
        profileLabel.numberOfLines = 4
        profileLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        profileLabel.backgroundColor = UIColor.clearColor()
        profileLabel.sizeToFit()
        profileLabel.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(profileLabel)
        
        nameLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/15))
        nameLabel.layer.position = CGPoint(x: screenWidth/2.1, y: screenHeight/6.5)
        nameLabel.text = ""
        nameLabel.font = UIFont.systemFontOfSize(27)
        nameLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        nameLabel.textAlignment = NSTextAlignment.Left
        self.view.addSubview(nameLabel)
        
        statusLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/19))
        statusLabel.layer.position = CGPoint(x: screenWidth/2.1, y: screenHeight/4.8)
        statusLabel.text = "金沢工業大学3年"
        statusLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        statusLabel.font = UIFont.systemFontOfSize(14)
        statusLabel.textAlignment = NSTextAlignment.Center
        statusLabel.numberOfLines = 0
        statusLabel.sizeToFit()
        self.view.addSubview(statusLabel)
        
        editProfile = UIButton(frame: CGRectMake(0,0,screenWidth/5.2, screenHeight/23.6))
        editProfile.layer.position = CGPoint(x: screenWidth - screenWidth/7.95, y: screenHeight/15.35)
        editProfile.setImage(UIImage(named: "profile_edit .png"), forState: .Normal)
        editProfile.addTarget(self, action: "clickBarButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(editProfile)
        
        profileImage = UIImageView(image: UIImage(named: "twitter-icon.png"))
        profileImage.frame = CGRectMake(0, 0, screenWidth/5.6, screenWidth/5.6)
        profileImage.layer.position = CGPoint(x: screenWidth/5.981, y: screenHeight/5.947)
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 8.0
        self.view.addSubview(profileImage)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
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
                            self.profileLabel.text = user["user"]["description"].string!
                            self.profileLabel.sizeToFit()
                            self.nameLabel.text = self.user_name
                            print(self.user_name)
                        }
                        
                    }
                    
                    
                } else {
                    print("通信失敗")
                }
                
        }
        nameLabel.text = new_name.objectForKey("NewName") as? String
        
    }
    
    func pushMyButton(myEventID:String) {
        let eventsdetails = EventsDetailViewController()
        eventsdetails.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        dismissViewControllerAnimated(true, completion: nil)    }
    
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

