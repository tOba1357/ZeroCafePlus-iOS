//
//  FirstViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by Kento Takemoto on 2015/12/11.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol EventViewDelegate {
    
    func pushMyButton(myEventID:Int)
}

class FirstViewController: UIViewController, EventViewDelegate {
    
    private var kitButton: UIButton!
    private var kuButton: UIButton!
    private var favoriteButton: UIButton!
    
    private var myImageView: UIImageView!
    
    @IBOutlet var horizontalSV: UIScrollView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        horizontalSV.pagingEnabled = true
        horizontalSV.directionalLockEnabled = true
        horizontalSV.contentSize.width = view.frame.size.width * 3.0
        horizontalSV.backgroundColor = UIColor.hexStr("#F0ECE2", alpha: 1.0)
        
        //        let kitView = UIView()
        //        let kuView = UIView()
        //        let favoriteView = UIView()
        //        let views = [kitView,kuView, favoriteView]
        
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let myImage = UIImage(named: "twitter-icon.png")
        myImageView = UIImageView(frame: CGRectMake(0,0,78,78))
        myImageView.image = myImage
        myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: 200.0)
        
        kitButton = UIButton(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        kitButton.layer.position = CGPoint(x: screenWidth/6, y: screenHeight/12)
        kitButton.setTitle("工大", forState: .Normal)
        kitButton.titleLabel?.font = UIFont.systemFontOfSize(24)
        kitButton.setTitleColor(UIColor.hexStr("#1A1A1A", alpha: 1.0), forState: .Normal)
        kitButton.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(kitButton)
        
        kuButton = UIButton(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        kuButton.layer.position = CGPoint(x: screenWidth/2.25, y: screenHeight/12)
        kuButton.setTitle("金大", forState: .Normal)
        kuButton.titleLabel?.font = UIFont.systemFontOfSize(24)
        kuButton.setTitleColor(UIColor.hexStr("B3B3B3", alpha: 1.0), forState: .Normal)
        kuButton.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(kuButton)
        
        favoriteButton = UIButton(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        favoriteButton.layer.position = CGPoint(x: screenWidth/1.4, y: screenHeight/12)
        favoriteButton.setTitle("お気に入り", forState: .Normal)
        favoriteButton.titleLabel?.font = UIFont.systemFontOfSize(24)
        favoriteButton.setTitleColor(UIColor.hexStr("B3B3B3", alpha: 1.0), forState: .Normal)
        favoriteButton.addTarget(self, action: "clickProjectButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(favoriteButton)
        
        
        for i in 0...2 {
            let viewHeight = CGFloat(128)
            
            let x = view.frame.width * CGFloat(i)
            let scrollview = UIScrollView(frame: CGRectMake(x, 0, view.frame.size.width, view.frame.size.height))
            
            horizontalSV.addSubview(scrollview)
            
        }
        
        
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if response.result.isSuccess {
                    print("通信成功")
                    
                    let json = JSON(response.result.value!)
                    debugPrint(response.result.value)
                    
                    let eventArray = json["events"].array! as Array
                    let eventLastId = eventArray.count
                    print("持ってきたもの:",eventArray)
                    
                    var myX :CGFloat = 6
                    var myY :CGFloat = 60
                    
                    for events in eventArray.enumerate(){
                        
                        let sideDecide = events.index % 2
                        if sideDecide == 0 {
                            let eve = events.element as JSON
                            let eventID = 28
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
                            let eventViewGenerate:EventView = EventView(frame:CGRectMake(myX,myY, 150, 200),titleNameString: title,id:eventID, dateNameString: dateName, tagNameString: tagName!)
                            eventViewGenerate.mydelegate = self
                            eventViewGenerate.layer.cornerRadius = 10
                            
                            self.horizontalSV.addSubview(eventViewGenerate)
                            myX = 162
                        }else{
                            
                            let eve = events.element as JSON
                            let eventID = 1
                            let title = eve["event"]["title"].string! as String
                            let dateName = eve["event"]["start_time"].string! as String
                            let tagName : String? = { ()->(String) in
                                if eve["event"]["category_tag"] == nil{
                                    return ""
                                }else {
                                    return eve["event"]["category_tag"].string! as String
                                }
                            }()
                            let eventViewGenerate:EventView = EventView(frame:CGRectMake(myX,myY, 150, 200),titleNameString: title,id: eventID, dateNameString: dateName, tagNameString: tagName!)
                            eventViewGenerate.mydelegate = self
                            eventViewGenerate.layer.cornerRadius = 10
                            self.horizontalSV.addSubview(eventViewGenerate)
                            
                            myX = 6
                            myY += 212
                        }
                        
                        self.horizontalSV.contentSize.height = CGFloat((eventArray.count / 2) * 212 + 150)
                        
                    }
                    
                    //                titleName.text = eventArray[0]["event"]["title"].string
                    //                dateName.text = eventArray[0]["event"]["start_time"].string
                    //                tagName.text = eventArray[0]["event"]["tags"].string
                    //
                    //
                    //                titleName.textAlignment = NSTextAlignment.Center
                    //                tagName.numberOfLines = 2
                    //                tagName.font = UIFont.systemFontOfSize(12)
                }else {
                    print("通信失敗")
                }
        }
        
    }
    
    func pushMyButton(myEventID:Int) {
        
        print("success")
        if let eventAttendVC = storyboard!.instantiateViewControllerWithIdentifier("EventsAttendViewController") as? EventsAttendViewController {
            eventAttendVC.getID = myEventID
            self.navigationController?.pushViewController(eventAttendVC, animated: true)
        }
        else{
            print("aaa")
        }
        
    }
}

class EventView :UIView{
    
    var mydelegate: EventViewDelegate!
    var myEventID :Int!
    
    init(frame: CGRect, titleNameString: String, id:Int, dateNameString: String, tagNameString: String) {
        super.init(frame: frame)
        myEventID = id
        self.backgroundColor = UIColor.whiteColor()
        
        let dateData = getDateTime(dateNameString)
        let dateText = "\(dateData[1])/\(dateData[2])\n\(dateData[3]):\(dateData[4])~10:00"
        
        let titleName: UILabel = UILabel(frame: CGRectMake(10,60,130,50))
        titleName.numberOfLines = 2
        let dateName: UILabel = UILabel(frame: CGRectMake(10,90,130,50))
        dateName.numberOfLines = 2
        let tagName: UILabel = UILabel(frame: CGRectMake(10,120,130,50))
        tagName.numberOfLines = 2
        let touchButton: UIButton = UIButton(frame: CGRectMake(10,10,130,180))
        
        titleName.text = titleNameString
        dateName.text = dateText
        tagName.text = tagNameString
        
        
        touchButton.setTitle("", forState: .Normal)
        touchButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        titleName.textColor = UIColor.blackColor()
        
        self.addSubview(titleName)
        self.addSubview(dateName)
        self.addSubview(tagName)
        self.addSubview(touchButton)
    }
    
    func onClickMyButton(sender: UIButton) {
        
        print("success")
        
        self.mydelegate?.pushMyButton(myEventID)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getDateTime(dateTime:String)->[String]{
        let dates:[String] = dateTime.componentsSeparatedByString("T")
        let dateDatas = dates[0].componentsSeparatedByString("-")
        let timeDatas = dates[1].componentsSeparatedByString(":")
        var getDatas = dateDatas
        
        for timeData in timeDatas.enumerate(){
            getDatas.append(timeDatas[timeData.index])
        }
        return getDatas
    }
    
}



