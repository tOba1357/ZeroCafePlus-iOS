//
//  ViewController.swift
//  ZeroCafePlus
//
//  Created by 紺谷和正 on 2015/12/07.
//  Copyright © 2015年 紺谷和正. All rights reserved.
//

import UIKit
import Alamofire
import SwityJSON

class ForthViewController: UIViewController {
    
    private var willJoinButton: UIButton!
    private var planedButton: UIButton!
    private var joinedButton: UIButton!
    private var profileLabel: UILabel!
    private var nameLabel: UILabel!
    private var profileImage: UIImageView!
    private var statusLabel: UILabel!
    private var user_name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        view.backgroundColor = UIColor.whiteColor()
        //ジェスチャー
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: "leftSwipe:")
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.Left
        leftSwipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: "rightSwipe:")
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.Right
        rightSwipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(rightSwipeGesture)
        
        //イベント管理
        willJoinButton = UIButton(frame: CGRectMake(0,300,125,50))
        willJoinButton.setTitle("参加予定", forState: .Normal)
        willJoinButton.setTitleColor(UIColor.hexStr("#1A1A1A", alpha: 1.0), forState: .Normal)
        willJoinButton.backgroundColor = UIColor.grayColor()
        willJoinButton.layer.cornerRadius = 15.0
        willJoinButton.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(willJoinButton)
        
        planedButton = UIButton(frame: CGRectMake(125,300,125,50))
        planedButton.setTitle("企画", forState: .Normal)
        planedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
        planedButton.backgroundColor = UIColor.whiteColor()
        planedButton.layer.cornerRadius = 15.0
        planedButton.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(planedButton)
        
        joinedButton = UIButton(frame: CGRectMake(250,300,125,50))
        joinedButton.setTitle("参加", forState: .Normal)
        joinedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
        joinedButton.backgroundColor = UIColor.whiteColor()
        joinedButton.layer.cornerRadius = 15.0
        joinedButton.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(joinedButton)
        
        //プロフィール
        profileLabel = UILabel(frame: CGRectMake(45,200,300,100))
        profileLabel.text = "自己紹介の一例自己紹介の一例僕は竹本だよ〜趣味はなんとかかんとか自己紹介の一例自己紹介の一例"
        profileLabel.numberOfLines = 0
        profileLabel.sizeToFit()
        self.view.addSubview(profileLabel)
        
        nameLabel = UILabel(frame: CGRectMake(190,130,100,100))
        nameLabel.text = "tkmt"
        nameLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        self.view.addSubview(nameLabel)
        
        statusLabel = UILabel(frame: CGRectMake(160,160,100,50))
        statusLabel.text = "金沢工業大学 3年"
        statusLabel.font = UIFont.systemFontOfSize(12)
        statusLabel.numberOfLines = 0
        statusLabel.sizeToFit()
        self.view.addSubview(statusLabel)
        
        profileImage = UIImageView(image: UIImage(named: "twitter-icon.png"))
        profileImage.frame = CGRectMake(90, 120, 60, 60)
        profileImage.layer.cornerRadius = 10.0
        self.view.addSubview(profileImage)
        
        
        let myBarButton_1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: "clickBarButton:")
        let myBarButton_2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "clickBarButton:")
        let myRightButtons  = [myBarButton_1, myBarButton_2]
        self.navigationController?.navigationBar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setRightBarButtonItems(myRightButtons, animated:true )
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        let url = "https://zerocafe.herokuapp.com/api/v1/users"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                let json = JSON(response.result.value!)
                
                let users = json["users"].array! as Array
                print(users)
                for user in users {
                    
                    
                    let user_id = user["id"].int!
                    print(user_id)
                    
                    if user_id == 1 {
                        self.user_name = user["name"].string!
                        //                        self.nameLabel.text = self.user_name
                        print(self.user_name)
                    }
                    
                }
                
        }
        
    }
    
    func clickProjectButton(sender: UIButton){
        sender.setTitleColor(UIColor.hexStr("#1A1A1A", alpha: 1.0), forState: .Normal)
        sender.backgroundColor = UIColor.grayColor()
        if sender.currentTitle == "参加予定" {
            planedButton.backgroundColor = UIColor.whiteColor()
            planedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            joinedButton.backgroundColor = UIColor.whiteColor()
            joinedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
        }
        else if sender.currentTitle == "企画"{
            willJoinButton.backgroundColor = UIColor.whiteColor()
            willJoinButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            joinedButton.backgroundColor = UIColor.whiteColor()
            joinedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            
            
        }
        else if sender.currentTitle == "参加" {
            willJoinButton.backgroundColor = UIColor.whiteColor()
            willJoinButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            planedButton.backgroundColor = UIColor.whiteColor()
            planedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            
        }
        
    }
    
    
    func leftSwipe(sender: UISwipeGestureRecognizer){
        if willJoinButton.backgroundColor == UIColor.grayColor(){
            planedButton.backgroundColor = UIColor.grayColor()
            planedButton.setTitleColor(UIColor.hexStr("#1A1A1A", alpha: 1.0), forState: .Normal)
            willJoinButton.backgroundColor = UIColor.whiteColor()
            willJoinButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            joinedButton.backgroundColor = UIColor.whiteColor()
            joinedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
        }else {
            willJoinButton.backgroundColor = UIColor.whiteColor()
            willJoinButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            planedButton.backgroundColor = UIColor.whiteColor()
            planedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            joinedButton.backgroundColor = UIColor.grayColor()
            joinedButton.setTitleColor(UIColor.hexStr("#1A1A1A", alpha: 1.0), forState: .Normal)
        }
    }
    
    func rightSwipe(sender: UISwipeGestureRecognizer){
        if joinedButton.backgroundColor == UIColor.grayColor() {
            planedButton.setTitleColor(UIColor.hexStr("#1A1A1A", alpha: 1.0), forState: .Normal)
            planedButton.backgroundColor = UIColor.grayColor()
            willJoinButton.backgroundColor = UIColor.whiteColor()
            willJoinButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            joinedButton.backgroundColor = UIColor.whiteColor()
            joinedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
        }else {
            willJoinButton.setTitleColor(UIColor.hexStr("#1A1A1A", alpha: 1.0), forState: .Normal)
            willJoinButton.backgroundColor = UIColor.grayColor()
            planedButton.backgroundColor = UIColor.whiteColor()
            planedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
            joinedButton.backgroundColor = UIColor.whiteColor()
            joinedButton.setTitleColor(UIColor.hexStr("#B3B3B3", alpha: 1.0), forState: .Normal)
        }
    }
    
    
    func clickBarButton(sender: UIButton){
        let secondViewController = EditProfileViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
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

