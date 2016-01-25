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
    
    @IBOutlet var horizontalSV: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        horizontalSV.pagingEnabled = true
        horizontalSV.directionalLockEnabled = true
        horizontalSV.contentSize.width = view.frame.size.width * 3.0
        horizontalSV.contentSize.height = 1200
        horizontalSV.backgroundColor = UIColor.hexStr("#F5F5DC", alpha: 1.0) 
        
        
        let kitView = UIView()
        let kuView = UIView()
        let favoriteView = UIView()
        let views = [kitView,kuView, favoriteView]
        
        for i in 0...2 {
            let viewHeight = CGFloat(128)
            
            let x = view.frame.width * CGFloat(i)
            let scrollview = UIScrollView(frame: CGRectMake(x, 0, view.frame.size.width, view.frame.size.height))
            
//            scrollview.contentSize.height = 1200
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
                    var myY :CGFloat = 15
                
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
        
        
        let titleName: UILabel = UILabel(frame: CGRectMake(10,60,130,50))
        let dateName: UILabel = UILabel(frame: CGRectMake(10,90,130,50))
        let tagName: UILabel = UILabel(frame: CGRectMake(10,120,130,50))
        let touchButton: UIButton = UIButton(frame: CGRectMake(10,10,130,180))
        
        titleName.text = titleNameString
        dateName.text = dateNameString
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
    


}



