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
    private var horizontalSV: UIScrollView!
    
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


        kitVerticalSV = UIScrollView()
        kuVerticalSV = UIScrollView()
        favoriteVerticalSV = UIScrollView()
        horizontalSV = UIScrollView()
        
        horizontalSV.pagingEnabled = true
        horizontalSV.frame = CGRectMake(0, screenHeight/11, self.view.frame.size.width, self.view.frame.size.height)
        horizontalSV.contentSize = CGSizeMake(self.view.frame.size.width * 3.0,self.view.frame.size.height)
        horizontalSV.contentOffset = CGPointMake(0, screenHeight/11)
        horizontalSV.backgroundColor = UIColor.hexStr("#F0ECE2", alpha: 1.0)
        
        kitVerticalSV.pagingEnabled = false
        kuVerticalSV.pagingEnabled = false
        favoriteVerticalSV.pagingEnabled = false
        
        
        kitLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        kitLabel.layer.position.x = 80
        kitLabel.layer.position.y = screenHeight/15
        kitLabel.text = "工大"
        kitLabel.font = UIFont.systemFontOfSize(20)
        kitLabel.textColor = UIColor.hexStr("1A1A1A", alpha: 1.0)
        kitView.addSubview(kitLabel)
        
        nonSelectedKitLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        nonSelectedKitLabel.layer.position.x = 80
        nonSelectedKitLabel.layer.position.y = screenHeight/15
        nonSelectedKitLabel.text = "工大"
        nonSelectedKitLabel.font = UIFont.systemFontOfSize(20)
        nonSelectedKitLabel.textColor = UIColor.hexStr("B3B3B3", alpha: 1.0)
        selectedKitView.addSubview(nonSelectedKitLabel)
        
        kuLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        kuLabel.layer.position.y = screenHeight/15
        kuLabel.text = "金大"
        kuLabel.font = UIFont.systemFontOfSize(20)
        kuLabel.textColor = UIColor.hexStr("1A1A1A", alpha: 1.0)
        kuView.addSubview(kuLabel)
        
        nonSelectedKuLabel = UILabel(frame: CGRectMake(0,0,screenWidth/3,screenHeight/13))
        nonSelectedKuLabel.layer.position.y = screenHeight/15
        nonSelectedKuLabel.text = "金大"
        nonSelectedKuLabel.font = UIFont.systemFontOfSize(20)
        nonSelectedKuLabel.textColor = UIColor.hexStr("B3B3B3", alpha: 1.0)
        selectedKuView.addSubview(nonSelectedKuLabel)
        
        favoriteLabel = UILabel(frame: CGRectMake(0,0,screenWidth/2.5,screenHeight/13))
        favoriteLabel.layer.position.x = 40
        favoriteLabel.layer.position.y = screenHeight/15
        favoriteLabel.text = "お気に入り"
        favoriteLabel.font = UIFont.systemFontOfSize(20)
        favoriteLabel.textColor = UIColor.hexStr("1A1A1A", alpha: 1.0)
        favoriteView.addSubview(favoriteLabel)
        
        nonSelectedFavoriteLabel = UILabel(frame: CGRectMake(0,0,screenWidth/2.5,screenHeight/13))
        nonSelectedFavoriteLabel.layer.position.x = 40
        nonSelectedFavoriteLabel.layer.position.y = screenHeight/15
        nonSelectedFavoriteLabel.text = "お気に入り"
        nonSelectedFavoriteLabel.font = UIFont.systemFontOfSize(20)
        nonSelectedFavoriteLabel.textColor = UIColor.hexStr("B3B3B3", alpha: 1.0)
        selectedFavoriteView.addSubview(nonSelectedFavoriteLabel)
        
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events.json"
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
                    var myY :CGFloat = 6
                    
                    for event in eventArray.enumerate(){
                        
                        let sideDecide = event.index % 2
                        if sideDecide == 0 {
                            let eve = event.element as JSON
                            let eventID = eve["event"]["id"].int
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
                            let eventViewGenerate:EventView = EventView(frame:CGRectMake(myX,myY, 150, 200),titleNameString: title,id:eventID!, dateNameString: dateName, tagNameString: tagName!)
                            eventViewGenerate.mydelegate = self
                            eventViewGenerate.layer.cornerRadius = 10
                            
                            self.kitVerticalSV.addSubview(eventViewGenerate)
//                            self.kuVerticalSV.addSubview(eventViewGenerate)
//                            self.favoriteVerticalSV.addSubview(eventViewGenerate)
                            myX = 162
                        }else{
                            
                            let eve = event.element as JSON
                            let eventID = eve["event"]["id"].int
                            let title = eve["event"]["title"].string! as String
                            let dateName = eve["event"]["start_time"].string! as String
                            let tagName : String? = { ()->(String) in
                                if eve["event"]["category_tag"] == nil{
                                    return ""
                                }else {
                                    return eve["event"]["category_tag"].string! as String
                                }
                            }()
                            let eventViewGenerate:EventView = EventView(frame:CGRectMake(myX,myY, 150, 200),titleNameString: title,id: eventID!, dateNameString: dateName, tagNameString: tagName!)
                            eventViewGenerate.mydelegate = self
                            eventViewGenerate.layer.cornerRadius = 10
                            self.kitVerticalSV.addSubview(eventViewGenerate)
//                            self.kuVerticalSV.addSubview(eventViewGenerate)
//                            self.favoriteVerticalSV.addSubview(eventViewGenerate)
                            
                            myX = 6
                            myY += 206
                        }
                        
//                        self.verticalSV.contentSize = CGSizeMake(0, CGFloat((eventArray.count / 2) * 212 + 150))
                        self.kitVerticalSV.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
                        self.kitVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((eventArray.count + 1) / 2) * 212 + 77))
                        self.kitVerticalSV.contentOffset = CGPointMake(0, -50)
                        self.kitVerticalSV.backgroundColor = UIColor.hexStr("#F0ECE2", alpha: 1.0)
//                        self.view.addSubview(self.horizontalSV)
//                        self.horizontalSV.addSubview(self.kitVerticalSV)
                        
                        self.kuVerticalSV.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
                        self.kuVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((eventArray.count + 1) / 2) * 212 + 77))
                        self.kuVerticalSV.contentOffset = CGPointMake(0, -50)
                        self.kuVerticalSV.backgroundColor = UIColor.hexStr("#F0ECE2", alpha: 1.0)
                        
                        self.favoriteVerticalSV.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
                        self.favoriteVerticalSV.contentSize = CGSizeMake(self.view.frame.width, CGFloat(((eventArray.count + 1) / 2) * 212 + 77))
                        self.favoriteVerticalSV.contentOffset = CGPointMake(0, -50)
                        self.favoriteVerticalSV.backgroundColor = UIColor.hexStr("#F0ECE2", alpha: 1.0)
                        
                        
                    }
                    let views = [
                        ViewPagerElement(selectedTitleView: kitView, noSelectedTitleView: selectedKitView, mainView: self.kitVerticalSV),
                        ViewPagerElement(selectedTitleView: kuView, noSelectedTitleView: selectedKuView, mainView: self.kuVerticalSV),
                        ViewPagerElement(selectedTitleView: favoriteView, noSelectedTitleView: selectedFavoriteView, mainView: self.favoriteVerticalSV)
                    ]
                    let frame = CGRect(x: 0, y: 10, width: self.view.frame.width, height: self.view.frame.height - 10)
                    let tabView = ViewPager(frame: frame, tabHeigh: screenHeight/11, views: views)
                    self.view.addSubview(tabView)
                }else {
                    print("通信失敗")
                }
        }
        
    }
    
    func pushMyButton(myEventID:Int) {
        
        print("success")
        if let eventAttendVC = storyboard!.instantiateViewControllerWithIdentifier("EventsAttendViewController") as? EventsAttendViewController {
            eventAttendVC.getID = myEventID
            print("")
            self.navigationController?.pushViewController(eventAttendVC, animated: true)
        }
        else{
            print("error")
        }
        
    }
}

class EventView :UIView{
    
    private var myImageView: UIImageView!
    
    var mydelegate: EventViewDelegate!
    var myEventID :Int!
    
    init(frame: CGRect, titleNameString: String, id:Int, dateNameString: String, tagNameString: String) {
        super.init(frame: frame)
        myEventID = id
        self.backgroundColor = UIColor.whiteColor()
        
        let dateData = getDateTime(dateNameString)
        let dateText = "\(dateData[1])/\(dateData[2])\n\(dateData[3]):\(dateData[4])~10:00"
        
        let titleName: UILabel = UILabel(frame: CGRectMake(10,60,130,70))
        titleName.numberOfLines = 2
        titleName.textAlignment = NSTextAlignment.Center
        let dateName: UILabel = UILabel(frame: CGRectMake(10,120,130,50))
        dateName.numberOfLines = 2
        dateName.textAlignment = NSTextAlignment.Center
        let tagName: UILabel = UILabel(frame: CGRectMake(10,150,130,70))
        tagName.numberOfLines = 2
        tagName.textAlignment = NSTextAlignment.Center
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
        
        
        let myImage = UIImage(named: "party.png")
        myImageView = UIImageView(frame: CGRectMake(0,0,70,70))
        myImageView.image = myImage
        myImageView.layer.position = CGPoint(x: 75, y: 40)
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10.0
        self.addSubview(myImageView)
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



