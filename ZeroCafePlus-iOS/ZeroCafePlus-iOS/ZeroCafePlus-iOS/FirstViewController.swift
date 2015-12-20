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
        
        //UIViewController.viewの座標取得
        let x:CGFloat = self.view.bounds.origin.x
        let y:CGFloat = self.view.bounds.origin.y
        
        //UIViewController.viewの幅と高さを取得
        let width:CGFloat = self.view.bounds.width
        let height:CGFloat = self.view.bounds.height
        
        //上記より画面ぴったりサイズのフレームを生成する
        let frame:CGRect = CGRect(x: 6, y: 6, width: 150, height: 200)
        
        //カスタマイズViewを生成
        let eventView:EventView = EventView(frame: frame)
        
        //カスタマイズViewを追加
        eventView.layer.cornerRadius = 15
        scrollView.addSubview(eventView)
        

    }
    
    
    override func viewWillAppear(animated: Bool) {
        let url = "https://zerocafe.herokuapp.com/api/v1/events"
        Alamofire.request(.GET, url)
            .responseJSON { response in debugPrint(response.result.value)
//    ここでswiftyJsonなりで値を料理する

        }
    }
    
}

class EventView :UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
