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
    
    private var kitLabel: UILabel!
    private var kuLabel: UILabel!
    private var favoriteLabel: UILabel!
    private var nonSelectedKitLabel: UILabel!
    private var nonSelectedKuLabel: UILabel!
    private var nonSelectedFavoriteLabel: UILabel!
    private var kitVerticalSV: UIScrollView!
    private var kuVerticalSV: UIScrollView!
    private var favoriteVerticalSV: UIScrollView!
    //    private var horizontalSV: UIScrollView!
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let kitView = UIView()
        let kuView = UIView()
        let favoriteView = UIView()
        let selectedKitView = UIView()
        let selectedKuView = UIView()
        let selectedFavoriteView = UIView()
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let backButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        self.view.backgroundColor = UIColor.hexStr("#F0ECE2", alpha: 1.0)
        
        kitLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        kitLabel.layer.position.x = screenWidth/3.3
        kitLabel.layer.position.y = screenHeight/15
        kitLabel.text = "工大"
        kitLabel.font = UIFont.systemFontOfSize(20)
        kitLabel.textColor = UIColor.hexStr("1A1A1A", alpha: 1.0)
        kitView.addSubview(kitLabel)
        
        nonSelectedKitLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        nonSelectedKitLabel.layer.position.x = screenWidth/3.3
        nonSelectedKitLabel.layer.position.y = screenHeight/15
        nonSelectedKitLabel.text = "工大"
        nonSelectedKitLabel.font = UIFont.systemFontOfSize(20)
        nonSelectedKitLabel.textColor = UIColor.hexStr("B3B3B3", alpha: 1.0)
        selectedKitView.addSubview(nonSelectedKitLabel)
        
        kuLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        kuLabel.layer.position.x = screenWidth/3.8
        kuLabel.layer.position.y = screenHeight/15
        kuLabel.text = "金大"
        kuLabel.font = UIFont.systemFontOfSize(20)
        kuLabel.textColor = UIColor.hexStr("1A1A1A", alpha: 1.0)
        kuView.addSubview(kuLabel)
        
        nonSelectedKuLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        nonSelectedKuLabel.layer.position.x = screenWidth/3.8
        nonSelectedKuLabel.layer.position.y = screenHeight/15
        nonSelectedKuLabel.text = "金大"
        nonSelectedKuLabel.font = UIFont.systemFontOfSize(20)
        nonSelectedKuLabel.textColor = UIColor.hexStr("B3B3B3", alpha: 1.0)
        selectedKuView.addSubview(nonSelectedKuLabel)
        
        favoriteLabel = UILabel(frame: CGRectMake(0,0,screenWidth/2.5,screenHeight/13))
        favoriteLabel.layer.position.x = screenWidth/5
        favoriteLabel.layer.position.y = screenHeight/15
        favoriteLabel.text = "お気に入り"
        favoriteLabel.font = UIFont.systemFontOfSize(20)
        favoriteLabel.textColor = UIColor.hexStr("1A1A1A", alpha: 1.0)
        favoriteView.addSubview(favoriteLabel)
        
        nonSelectedFavoriteLabel = UILabel(frame: CGRectMake(0,0,screenWidth/2.5,screenHeight/13))
        nonSelectedFavoriteLabel.layer.position.x = screenWidth/5
        nonSelectedFavoriteLabel.layer.position.y = screenHeight/15
        nonSelectedFavoriteLabel.text = "お気に入り"
        nonSelectedFavoriteLabel.font = UIFont.systemFontOfSize(20)
        nonSelectedFavoriteLabel.textColor = UIColor.hexStr("B3B3B3", alpha: 1.0)
        selectedFavoriteView.addSubview(nonSelectedFavoriteLabel)

        let eventListSVFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        kitVerticalSV = UIScrollView(frame: eventListSVFrame)
        kuVerticalSV = UIScrollView(frame: eventListSVFrame)
        favoriteVerticalSV = UIScrollView(frame: eventListSVFrame)
        kitVerticalSV.pagingEnabled = false
        kuVerticalSV.pagingEnabled = false
        favoriteVerticalSV.pagingEnabled = false
        
        let views = [
            ViewPagerElement(selectedTitleView: kitView, noSelectedTitleView: selectedKitView, mainView: self.kitVerticalSV),
            ViewPagerElement(selectedTitleView: kuView, noSelectedTitleView: selectedKuView, mainView: self.kuVerticalSV),
            ViewPagerElement(selectedTitleView: favoriteView, noSelectedTitleView: selectedFavoriteView, mainView: self.favoriteVerticalSV)
        ]
        let frame = CGRect(x: 0, y: 10, width: self.view.frame.width, height: self.view.frame.height - 10)
        let tabView = ViewPager(frame: frame, tabHeigh: screenHeight/11, views: views)
        self.view.addSubview(tabView)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    let eventArray = json["events"].array! as Array
                    
                    var kitX :CGFloat = screenWidth*(12/640)
                    var kitY :CGFloat = screenHeight*(12/1136)
                    var kuX :CGFloat = screenWidth*(12/640)
                    var kuY :CGFloat = screenHeight*(12/1136)
                    var favoriteX :CGFloat = screenWidth*(12/640)
                    var favoriteY :CGFloat = screenHeight*(12/1136)
                    
                    var kitSideDecide = 0
                    var kitCount = 0
                    var kuSideDecide = 0
                    var kuCount = 0
                    var favoriteSideDecide = 0
                    var favoriteCount = 0
                    
                    for event in eventArray.enumerate(){
                        
                        let eve = event.element as JSON
                        let placeDecide = eve["event"]["place"]
                        let genreImage = eve["event"]["genre"].int
                        let eventID = eve["event"]["id"].int
                        let title = eve["event"]["title"].string! as String
                        let startDate = eve["event"]["start_time"].string! as String
                        let endDate = eve["event"]["end_time"].string! as String
                        let tagName : String? = { ()->(String) in
                            if eve["event"]["category_tag"] == nil{
                                return ""
                            }else {
                                return eve["event"]["category_tag"].string! as String
                            }
                        }()
                        
                        if placeDecide == 0 {
                            //金沢工業大学のEventViewの表示 1page
                            
                            if kitSideDecide % 2 == 0 {
                                kitX = screenWidth*(12/640)
                            }else{
                                kitX = screenWidth*(324/640)
                            }
                            
                                let eventViewGenerate:EventView = EventView(frame:CGRectMake(kitX,kitY, screenWidth*(300/640), screenHeight*(335/1136)),titleNameString: title,id:eventID!, startDateString: startDate, endDateString: endDate,tagNameString: tagName!, genreImageNum: genreImage!)
                                eventViewGenerate.mydelegate = self
                                eventViewGenerate.layer.cornerRadius = screenWidth/80
                                self.kitVerticalSV.addSubview(eventViewGenerate)
                            
                            if kitCount % 2 == 1{
                                kitY += screenHeight*(347/1136)
                            }
                            
                            kitSideDecide++
                            kitCount++
                            
                        }else if placeDecide == 1{
                            //                            金沢大学のEventViewの表示 2page
                            
                            if kuSideDecide % 2 == 0 {
                                kuX = screenWidth*(12/640)
                            }else{
                                kuX = screenWidth*(324/640)
                            }
                            let eventViewGenerate:EventView = EventView(frame:CGRectMake(kuX,kuY, screenWidth*(300/640), screenHeight*(335/1136)),titleNameString: title,id:eventID!, startDateString: startDate, endDateString: endDate,tagNameString: tagName!, genreImageNum: genreImage!)
                            eventViewGenerate.mydelegate = self
                            eventViewGenerate.layer.cornerRadius = screenWidth/80
                            self.kuVerticalSV.addSubview(eventViewGenerate)
                            
                            if kuCount % 2 == 1{
                                kuY += screenHeight*(347/1136)
                            }
                            kuSideDecide++
                            kuCount++
                        }
                        
                        //お気に入りページの作成
                        if favoriteSideDecide % 2 == 0 {
                            favoriteX = screenWidth*(12/640)
                        }else{
                            favoriteX = screenWidth*(324/640)
                        }
                        
                        let defaults = NSUserDefaults.standardUserDefaults()
                        
                        if  let _favoriteEventList = defaults.objectForKey("EVENT_ID"){
                            var favoriteEventIdList = _favoriteEventList as! [Int]
                            for (key,_) in favoriteEventIdList.enumerate(){
                                if favoriteEventIdList[key] == eventID {
                                    print(favoriteEventIdList[key])
                                    let eventViewGenerate:EventView = EventView(frame:CGRectMake(favoriteX,favoriteY, screenWidth*(300/640),screenHeight*(335/1136)),titleNameString: title,id:eventID!, startDateString: startDate, endDateString: endDate,tagNameString: tagName!, genreImageNum: genreImage!)
                                    eventViewGenerate.mydelegate = self
                                    eventViewGenerate.layer.cornerRadius = screenWidth/80
                                    self.favoriteVerticalSV.addSubview(eventViewGenerate)
                                    
                                    if favoriteCount % 2 == 1 {
                                        favoriteY += screenHeight*(347/1136)
                                    }
                                    favoriteSideDecide++
                                    favoriteCount++
                                }
                            }
                        }
                    }
                    self.kitVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((kitCount + 1) / 2)) * screenHeight * (335/1136) + 153)
                    self.kitVerticalSV.contentOffset = CGPointMake(0, -50)
                    self.kitVerticalSV.backgroundColor = UIColor.hexStr("#F0ECE2", alpha: 1.0)
                    
                    self.kuVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((kuCount + 1) / 2) * 212 + 93))
                    self.kuVerticalSV.contentOffset = CGPointMake(0, -50)
                    self.kuVerticalSV.backgroundColor = UIColor.hexStr("#F0ECE2", alpha: 1.0)
                    
                    self.favoriteVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((favoriteCount + 1) / 2) * 212 + 93))
                    self.favoriteVerticalSV.contentOffset = CGPointMake(0, -50)
                    self.favoriteVerticalSV.backgroundColor = UIColor.hexStr("#F0ECE2", alpha: 1.0)

                }else {
                    print("通信失敗")
                }
        }
        
        
    }
    
    func pushMyButton(myEventID:Int) {
        
        print("success")
        let eventAttendVC = storyboard!.instantiateViewControllerWithIdentifier("EventsAttendViewController") as? EventsAttendViewController
        eventAttendVC!.getID = myEventID
        print("")
        self.navigationController?.pushViewController(eventAttendVC!, animated: true)
    }
}
