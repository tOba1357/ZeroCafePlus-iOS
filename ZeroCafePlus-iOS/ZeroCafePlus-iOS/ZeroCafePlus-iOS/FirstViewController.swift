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

class FirstViewController: UIViewController {
    
    @IBOutlet var placeView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topEventView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //フレームを生成する
        let leftframe:CGRect = CGRect(x: 6, y: 6, width: 150, height: 200)
        let rightframe:CGRect = CGRect(x: 162, y: 6, width: 150, height: 200)
        
        //カスタマイズViewを生成
        let leftEventView:EventView = EventView(frame: leftframe)
        let rightEventView:EventView = EventView(frame: rightframe)
        
        leftEventView.layer.cornerRadius = 15
        rightEventView.layer.cornerRadius = 15
        
        //カスタマイズViewを追加
        scrollView.addSubview(leftEventView)
        scrollView.addSubview(rightEventView)

    }
    
}

class EventView :UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        
        let titleName: UILabel = UILabel(frame: CGRectMake(10,75,200,50))
        titleName.text = ""
        titleName.textColor = UIColor.blackColor()
        self.addSubview(titleName)

        let url = "https://zerocafe.herokuapp.com/api/v1/events"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                let json = JSON(response.result.value!)
                debugPrint(response.result.value)
                let eventArray = json["events"].array! as Array
                titleName.text = eventArray[0]["event"]["title"].string! as String
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



