//
//  FavoriteTopVC.swift
//  ZeroCafePlus-iOS
//
//  Created by Kento Takemoto on 2015/12/22.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

class FavoriteTopVC: UIViewController {
    
    @IBOutlet var placeView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topEventView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //フレームを生成する
        let leftframe:CGRect = CGRect(x: 6, y: 6, width: 150, height: 200)
        let rightframe:CGRect = CGRect(x: 162, y: 6, width: 150, height: 200)
        let nextframe:CGRect = CGRect(x: 6, y: 218, width: 150, height: 200)
        
        //カスタマイズViewを生成
        let eventViewGenerate:EventView = EventView(frame: leftframe)
        let rightEventView:EventView = EventView(frame: rightframe)
        let nextEventView:EventView = EventView(frame: nextframe)
        
        eventViewGenerate.layer.cornerRadius = 15
        rightEventView.layer.cornerRadius = 15
        nextEventView.layer.cornerRadius = 15
        
        //カスタマイズViewを追加
        scrollView.addSubview(eventViewGenerate)
        scrollView.addSubview(rightEventView)
        scrollView.addSubview(nextEventView)
        
        
        
        
    }
    
}

//class EventView :UIView{
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = UIColor.whiteColor()
//
//
//        let titleName: UILabel = UILabel(frame: CGRectMake(10,60,130,50))
//        let dateName: UILabel = UILabel(frame: CGRectMake(10,90,130,50))
//        let tagName: UILabel = UILabel(frame: CGRectMake(10,120,130,50))
//
//        titleName.text = ""
//        dateName.text = ""
//        tagName.text = ""
//
//        titleName.textColor = UIColor.blackColor()
//
//        self.addSubview(titleName)
//        self.addSubview(dateName)
//        self.addSubview(tagName)
//
//        let url = "https://zerocafe.herokuapp.com/api/v1/events"
//        Alamofire.request(.GET, url)
//            .responseJSON { response in
//                let json = JSON(response.result.value!)
//                debugPrint(response.result.value)
//
//                let eventArray = json["events"].array! as Array
//                let eventLastId = eventArray.count
//
//                titleName.text = eventArray[0]["event"]["title"].string! as String
//                dateName.text = eventArray[0]["event"]["start_time"].string! as String
//                tagName.text = eventArray[0]["event"]["tags"].string! as String
//
//                print("中身：",eventArray)
//
//                titleName.textAlignment = NSTextAlignment.Center
//        }
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


