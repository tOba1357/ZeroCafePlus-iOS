//
//  SearchReslutViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by 紺谷和正 on 2016/02/19.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchReslutViewController: UIViewController {
    
    private var searchVerticalSV: UIScrollView!
    private var kuVerticalSV: UIScrollView!
    private var favoriteVerticalSV: UIScrollView!
    private var searchView: UIView!
    private var kuView:UIView!
    private var favoriteView:UIView!
    private var selectedsearchView:UIView!
    private var selectedKuView:UIView!
    private var selectedFavoriteView :UIView!
    private var horizontalSV: UIScrollView!
    private var returnOriginal: UIButton!
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.whiteColor()
        searchVerticalSV = UIScrollView()
        
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let searchCondition = NSUserDefaults.standardUserDefaults()
        returnOriginal = UIButton(frame: CGRectMake(screenWidth/20,screenHeight/20,screenWidth/10, screenHeight/10))
        returnOriginal.setTitle("戻る", forState: .Normal)
        returnOriginal.setTitleColor(UIColor.hexStr("#BABABA", alpha: 1.0), forState: .Normal)
        returnOriginal.addTarget(self, action: "returnOriginal:", forControlEvents: .TouchUpInside)
        self.view.addSubview(returnOriginal)
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if response.result.isSuccess {
                    print("通信成功")
                    
                    let json = JSON(response.result.value!)
                    var eventArray = json["events"].array! as Array
                    var searchX :CGFloat = 6
                    var searchY :CGFloat = 6
                    
                    if searchCondition.objectForKey("SearchTitle") != nil {
                        var count = 0
                        for (index, event) in eventArray.enumerate(){
                            let title = event["event"]["title"].string! as String
                            let eventTag = event["event"]["category_tag"].string! as String
                            if title.lowercaseString.containsString(searchCondition.objectForKey("SearchTitle") as! String) || eventTag.lowercaseString.containsString(searchCondition.objectForKey("SearchTitle") as! String){
                            }else{
                                eventArray.removeAtIndex(index - count)
                                count++
                            }
                        }
                    }
                    if searchCondition.objectForKey("StartTime") != nil{
                        var count = 0
                        for (index, event) in eventArray.enumerate(){
                            let dateName = event["event"]["start_time"].string! as String
                            if dateName.lowercaseString.containsString(searchCondition.objectForKey("StartTime") as! String){
                            }else{
                                eventArray.removeAtIndex(index - count)
                                count++
                            }
                        }
                    }
                    if searchCondition.objectForKey("EndTime") != nil {
                        var count = 0
                        for (index, event) in eventArray.enumerate(){
                            let dateName2 = event["event"]["end_time"].string! as String
                            if dateName2.lowercaseString.containsString(searchCondition.objectForKey("EndTime") as! String){
                            }else{
                                eventArray.removeAtIndex(index - count)
                                count++
                            }
                        }
                    }
                    if searchCondition.objectForKey("genreCount") != nil {
                        var count = 0
                        for (index, event) in eventArray.enumerate(){
                            let eventGenre = event["event"]["genre"].int
                            var eventDesicion: [Int] = []
                            for genreC in searchCondition.objectForKey("genreCount") as! [Int]{
                                if eventGenre != genreC {
                                    eventDesicion.append(1)
                                }else{
                                    eventDesicion.append(0)
                                }
                            }
                            if eventDesicion.contains(0){
                            }else {
                                eventArray.removeAtIndex(index - count)
                                count++
                            }
                        }
                    }
                    let eveCount = eventArray.count
                    for (index,event) in eventArray.enumerate(){
                        let title = event["event"]["title"].string! as String
                        if index % 2 == 0 {
                            searchX = 6
                            let genreImage = event["event"]["genre"].int
                            let eventID = event["event"]["id"].int
                            let startDate = event["event"]["start_time"].string! as String
                            let endDate = event["event"]["end_time"].string! as String
                            let tagName : String? = { ()->(String) in
                                if event["event"]["category_tag"] == nil{
                                    return ""
                                }else {
                                    return event["event"]["category_tag"].string! as String
                                }
                            }()
                            
                            let eventViewGenerate:EventView = EventView(frame:CGRectMake(searchX,searchY, screenWidth/2.1192, 200),titleNameString: title,id:eventID!, startDateString: startDate, endDateString: endDate, tagNameString: tagName!, genreImageNum: genreImage!)

                            eventViewGenerate.layer.cornerRadius = 10
                            self.searchVerticalSV.addSubview(eventViewGenerate)
                            
                        }else{
                            searchX = screenWidth/1.96319018
                            let genreImage = event["event"]["genre"].int
                            let eventID = event["event"]["id"].int
                            let title = event["event"]["title"].string! as String
                            let startDate = event["event"]["start_time"].string! as String
                            let endDate = event["event"]["end_time"].string! as String
                            let tagName : String? = { ()->(String) in
                                if event["event"]["category_tag"] == nil{
                                    return ""
                                }else {
                                    return event["event"]["category_tag"].string! as String
                                }
                            }()

                            let eventViewGenerate:EventView = EventView(frame:CGRectMake(searchX,searchY, screenWidth/2.1192, 200),titleNameString: title,id: eventID!, startDateString: startDate, endDateString: endDate, tagNameString: tagName!, genreImageNum: genreImage!)

                            eventViewGenerate.layer.cornerRadius = 10
                            self.searchVerticalSV.addSubview(eventViewGenerate)
                            
                            searchY += 206
                        }
                        self.searchVerticalSV.frame = CGRectMake(0, self.view.frame.height-self.view.frame.height/1.2, self.view.frame.width, self.view.frame.height/1.2)
                        self.searchVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((eveCount + 1) / 2) * 212 + 93))
                        self.searchVerticalSV.contentOffset = CGPointMake(0, -50)
                        self.searchVerticalSV.backgroundColor = UIColor.whiteColor()
                    }
                    self.view.addSubview(self.searchVerticalSV)
                }
                // Do any additional setup after loading the view.
        }
    }
    
    func pushMyButton(myEventID:Int) {
                let eventAttendVC = EventsAttendViewController()
                eventAttendVC.getID = myEventID
                print("")
                eventAttendVC.modalTransitionStyle  = UIModalTransitionStyle.CoverVertical
                presentViewController(eventAttendVC, animated: true, completion: nil)
    }
    func returnOriginal(sender: UIButton){
        let scVC = SecondViewController()
        scVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        dismissViewControllerAnimated(true, completion: nil)
    }
    
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
    */}
