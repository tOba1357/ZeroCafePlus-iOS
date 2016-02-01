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
    
    
    private var TakeFriends:UILabel!
    private var event_detail_add_friend: UIImageView!
    private var add: UIPickerView!
    private let myValues: NSArray = ["0人","1人","2人","3人","4人","5人","6人","7人","8人","9人","10人","11人","12人","13人","14人","15人","16人","17人","18人","19人","20人"]
    private var event_detail_info: UIImageView!
    private var sankaButton: UIButton!
    
    var MygetID: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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


        
        add = UIPickerView()
        add.frame = CGRectMake(0,0,self.view.bounds.width/6, self.view.bounds.height/9)
        add.layer.position = CGPoint(x: self.view.bounds.width/1.25,y: self.view.bounds.height/4.52)
        add.delegate = self
        add.dataSource = self
        self.view.addSubview(add)
        
        
        event_detail_info = UIImageView(frame: CGRectMake(0,self.view.bounds.height/3.82,self.view.bounds.width/1.27,self.view.bounds.height/12.08))
        let detail_info = UIImage(named: "event_detail_info.png")
        event_detail_info.image = detail_info
        event_detail_info.layer.position.x = CGFloat(self.view.bounds.width/2)
        self.view.addSubview(event_detail_info)
        
        
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
    
    /*
    pickerが選択された際に呼ばれるデリゲートメソッド.
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(myValues[row])")
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
        
        let myEventsAttendViewController = EventsAttendViewController()
        myEventsAttendViewController.getID = MygetID
        self.navigationController?.pushViewController(myEventsAttendViewController, animated: true)

    
        
        
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
