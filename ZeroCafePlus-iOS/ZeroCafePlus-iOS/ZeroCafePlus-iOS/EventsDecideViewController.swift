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


class EventsDecideViewController: UIViewController {
    
    
    private var name:UILabel!
    private var friends: UILabel!
    private var add: UILabel!
    private var sanka: UIButton!
    
    var MygetID: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        
        name = UILabel(frame: CGRectMake(0,0,200,200))
        name.text = ""
        name.textAlignment = NSTextAlignment.Center
        name.font = UIFont.systemFontOfSize(CGFloat(25))
        self.view.backgroundColor = UIColor.whiteColor()
        name.layer.position = CGPoint(x: self.view.bounds.width/2, y: view.bounds.height/5)
        name.numberOfLines = 0;
        name.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.view.addSubview(name)
        
        
        friends = UILabel(frame: CGRectMake(0,0,250,50))
        friends.text = "友達を連れて行く"
        friends.font = UIFont.systemFontOfSize(CGFloat(15))
        friends.textAlignment = NSTextAlignment.Center
        friends.layer.position = CGPoint(x: self.view.bounds.width/2,y: view.bounds.height/2)
        self.view.addSubview(friends)
        
        
        
        add = UILabel(frame: CGRectMake(0,0,250,50))
        add.text = "カレンダーに追加する"
        add.font = UIFont.systemFontOfSize(CGFloat(15))
        add.textAlignment = NSTextAlignment.Center
        add.layer.position = CGPoint(x: self.view.bounds.width/2,y: view.bounds.height/1.7)
        self.view.addSubview(add)
        
        
        sanka = UIButton()
        sanka.frame = CGRectMake(0,0,200,40)
        sanka.backgroundColor = UIColor.orangeColor()
        sanka.layer.masksToBounds = true
        sanka.setTitle("参加する", forState: UIControlState.Normal)
        sanka.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sanka.layer.cornerRadius = 20.0
        sanka.layer.position = CGPoint(x: self.view.frame.width/2, y:view.bounds.height/1.25)
        sanka.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(sanka)
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
                        if  id == self.MygetID{
                        self.name.text = events["event"]["title"].string! as String
                        }
                    }
                }
        
        
        
    }
    
    func onClickMyButton(sender: UIButton){
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let parameters:[String:AnyObject] =
        [
            "ticket": [
                "user_id": 2,
                "event_id": 1
                
                
            ]
        ]
        let PostUrl = "https://zerocafe.herokuapp.com/api/v1/tickets.json"
        
        Alamofire.request(.POST, PostUrl, parameters: parameters, encoding: .JSON, headers:headers)
            .responseString { response in
                debugPrint(response.result.value)
                //"いいよぉ！"が返って来れば成功
        }
        

        let kakutei: UIAlertController = UIAlertController(title: "確定しました。", message: "", preferredStyle: .Alert)
        let OkAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            self.returnTop()
        })
        kakutei.addAction(OkAction)
        presentViewController(kakutei, animated: true, completion: nil)
        
    }
    func returnTop(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    // Do any additional setup after loading the view.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
