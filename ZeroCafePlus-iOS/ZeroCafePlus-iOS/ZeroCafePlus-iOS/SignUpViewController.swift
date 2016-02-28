//
//  ViewController.swift
//  log in
//
//  Created by Ryunosuke Higuchi on 2016/02/14.
//  Copyright © 2016年 Ryunosuke Higuchi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    private var UserNameText: UITextField!
    private var PasswordText: UITextField!
    private var zerocafeIdText: UITextField!
    private var majorText: UITextField!
    private var descriptionText: UITextField!
    private var countProfile:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zerocafeIdText = UITextField(frame: CGRectMake(0,0,self.view.bounds.width/1.24,30))
        zerocafeIdText.text = ""
        zerocafeIdText.placeholder = "ゼロカフェID"
        zerocafeIdText.delegate = self
        zerocafeIdText.borderStyle = UITextBorderStyle.RoundedRect
        zerocafeIdText.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/6);
        self.view.addSubview(zerocafeIdText)
        
        UserNameText = UITextField(frame: CGRectMake(0,0,self.view.bounds.width/1.24,30))
        UserNameText.text = ""
        UserNameText.placeholder = "ユーザー名"
        UserNameText.delegate = self
        UserNameText.borderStyle = UITextBorderStyle.RoundedRect
        UserNameText.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/4);
        self.view.addSubview(UserNameText)
        
        PasswordText = UITextField(frame: CGRectMake(0,0,self.view.bounds.width/1.24,30))
        PasswordText.text = ""
        PasswordText.placeholder = "パスワード"
        PasswordText.secureTextEntry = true
        PasswordText.delegate = self
        PasswordText.borderStyle = UITextBorderStyle.RoundedRect
        PasswordText.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/3);
        self.view.addSubview(PasswordText)
        
        majorText = UITextField(frame: CGRectMake(0,0,self.view.bounds.width/1.24,30))
        majorText.text = ""
        majorText.placeholder = "学科"
        majorText.delegate = self
        majorText.borderStyle = UITextBorderStyle.RoundedRect
        majorText.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/2.4);
        self.view.addSubview(majorText)
        
        descriptionText = UITextField(frame: CGRectMake(0,0,self.view.bounds.width/1.24,30))
        descriptionText.text = ""
        descriptionText.placeholder = "自己紹介文(任意)"
        descriptionText.delegate = self
        descriptionText.borderStyle = UITextBorderStyle.RoundedRect
        //        descriptionText.dataDetectorTypes = UIDataDetectorTypes.All
        descriptionText.layer.position = CGPoint(x:self.view.bounds.width/2,y:self.view.bounds.height/2);
        self.view.addSubview(descriptionText)
        
        let nextButton: UIButton = UIButton(frame: CGRectMake(0,0,self.view.bounds.width/2,50))
        nextButton.backgroundColor = UIColor.orangeColor();
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("登録", forState: .Normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height/1.5)
        nextButton.addTarget(self, action: "onClickLoginButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(nextButton)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    func onClickLoginButton(sender: UIButton){
        if (zerocafeIdText.text == "") || (UserNameText.text == "") || (PasswordText.text == "") || (majorText.text == ""){
            
            let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
            alertLabel.text = "未入力の箇所があります"
            alertLabel.textColor = UIColor.redColor()
            alertLabel.textAlignment = NSTextAlignment.Center
            alertLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.bounds.height/1.3)
            self.view.addSubview(alertLabel)
            
        } else {
            let headers = [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
            let parameters: [String:AnyObject]
            
            if descriptionText.text != "" {
                parameters =  [
                    "user": [
                        "zerocafe_id": zerocafeIdText.text!,
                        "name": UserNameText.text!,
                        "password": PasswordText.text!,
                        "major": majorText.text!,
                        "description": descriptionText.text!
                        
                    ]
                ]
            } else {
                print("yes")
                parameters = [
                    "user": [
                        "zerocafe_id": zerocafeIdText.text!,
                        "name": UserNameText.text!,
                        "password": PasswordText.text!,
                        "major": majorText.text!,
                        "description": "ここに自己紹介文が表示されます"
                    ]
                ]
            }
            let PostUrl = "https://zerocafe.herokuapp.com/api/v1/users.json"
            Alamofire.request(.POST, PostUrl, parameters: parameters, encoding: .JSON, headers:headers)
                .responseString { response in
                    debugPrint(response.result.value)
                    //"いいよぉ！"が返ってくれば成功
            }
            let GetUrl = "https://zerocafe.herokuapp.com/api/v1/users"
            Alamofire.request(.GET, GetUrl)
                .responseJSON { response in
                    
                    let json = JSON(response.result.value!)
                    let userArray = json["users"].array! as Array
                    for users in userArray {
                        let zerocafeID = users["user"]["zerocafe_id"].string! as String
                        let password = users["user"]["password"].string! as String
                        if (zerocafeID == self.zerocafeIdText.text) && password == self.PasswordText.text {
                            let userID = users["user"]["id"].int! as Int
                            print(userID)
                            NSUserDefaults.standardUserDefaults().setInteger(userID, forKey: "UserIDKey")
                        }
                    }
            }
            
            let SignUp_ud = NSUserDefaults.standardUserDefaults()
            SignUp_ud.setBool(true, forKey: "ViewKey")
            
            let targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "CustomTabBar" )
            self.presentViewController( targetView as! UIViewController, animated: true, completion: nil)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //編集直後
    func textFieldDidBeginEditing(textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    //編集完了後（完了直前）
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        return true
    }
    // returnボタンを押した時の処理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("text field return")
        return true
    }
}



