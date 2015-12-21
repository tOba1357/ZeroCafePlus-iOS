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
    
    private var sanka: UIButton!
    let eventId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        
        
        self.title = ""
        
        
        let name: UILabel = UILabel(frame: CGRectMake(0,0,200,200))
        name.text = ""
        name.textAlignment = NSTextAlignment.Center
        name.font = UIFont.systemFontOfSize(CGFloat(25))
        self.view.backgroundColor = UIColor.whiteColor()
        name.layer.position = CGPoint(x: self.view.bounds.width/2, y: 150)
        name.numberOfLines = 0;
        name.lineBreakMode = NSLineBreakMode.ByCharWrapping
        self.view.addSubview(name)
        
        
        let friends: UILabel = UILabel(frame: CGRectMake(0,0,250,50))
        friends.text = "友達を連れて行く"
        friends.font = UIFont.systemFontOfSize(CGFloat(15))
        friends.textAlignment = NSTextAlignment.Center
        friends.layer.position = CGPoint(x: self.view.bounds.width/2,y: 300)
        self.view.addSubview(friends)
        
        
        
        let add: UILabel = UILabel(frame: CGRectMake(0,0,250,50))
        add.text = "カレンダーに追加する"
        add.font = UIFont.systemFontOfSize(CGFloat(15))
        add.textAlignment = NSTextAlignment.Center
        add.layer.position = CGPoint(x: self.view.bounds.width/2,y: 400)
        self.view.addSubview(add)
        
        
        sanka = UIButton()
        sanka.frame = CGRectMake(0,0,200,40)
        sanka.backgroundColor = UIColor.orangeColor()
        sanka.layer.masksToBounds = true
        sanka.setTitle("参加する", forState: UIControlState.Normal)
        sanka.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        sanka.layer.cornerRadius = 20.0
        sanka.layer.position = CGPoint(x: self.view.frame.width/2, y:550)
        sanka.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(sanka)
        
        
        Alamofire.request(.GET, url)
            .responseJSON { response in
                debugPrint(response.result.value)
                let json = JSON(response.result.value!)
                let eventAraay = json["events"].array! as Array
                for events in eventAraay {
                    let id = events["event"]["id"].int! as Int
                    if self.eventId == id {
                        name.text = events["event"]["title"].string! as String
                    }
                }
        }
        
        
        
    }
    
    func onClickMyButton(sender: UIButton){
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
