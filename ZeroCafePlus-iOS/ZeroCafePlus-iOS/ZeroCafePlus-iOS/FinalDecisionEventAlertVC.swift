//
//  finalDecisionEventAlertVC.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2016/02/03.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

protocol FinalDecisionEventAlertDelegate{
    func closeDecisionEventWindow(btnTag:Int)
}

class FinalDecisionEventAlertVC: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    
    var nextButton :UIButton!
    var closeButton :UIButton!
    
    var eventName :String!
    var eventExposition :String!
    var eventGenre:Int!
    var eventGenreStr:String!
    var eventDate :[String]!
    var eventStartTime :String!
    var eventEndTime :String!
    var eventBelonging:String!
    var eventDiveJoin:Bool!
    var eventMenberNum:Int!
    var eventTag:String!
    
    var lastCheckEventDelegate:FinalDecisionEventAlertDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        //        scrollView.delegate = self
        //        scrollView.contentSize   = CGSizeMake(0, 0)
        //        scrollView.contentOffset = CGPointMake(0.0 , 0.0)
        //        self.view.addSubview(scrollView)
        
        checkGenre()
        
        let nameLabel = UILabel(frame: CGRectMake(0,0,500,60))
        nameLabel.text = "イベント名:\(eventName)"
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/13)
        self.view.addSubview(nameLabel)
        
        let expLabel = UILabel(frame: CGRectMake(0,0,500,300))
        expLabel.text = "内容：\n\(eventExposition)"
        expLabel.textAlignment = NSTextAlignment.Center
        expLabel.sizeToFit()
        expLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/13*2)
        self.view.addSubview(expLabel)
        
        
        let genreLabel = UILabel(frame: CGRectMake(0,0,500,60))
        genreLabel.text = "ジャンル：\(eventGenreStr)"
        genreLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/13*3)
        genreLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(genreLabel)
        
        let timeLabel = UILabel(frame: CGRectMake(0,0,500,120))
        timeLabel.text = "日時：\(eventDate[0])-\(eventDate[1])-\(eventDate[2])\n\(eventStartTime)〜\(eventEndTime)"
        timeLabel.textAlignment = NSTextAlignment.Center
        timeLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/13*4)
        self.view.addSubview(timeLabel)
        
        let belLabel = UILabel(frame: CGRectMake(0,0,500,60))
        belLabel.text = "持ち物：\(eventBelonging)"
        belLabel.textAlignment = NSTextAlignment.Center
        belLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/13*5)
        self.view.addSubview(belLabel)
        
        let numLabel = UILabel(frame: CGRectMake(0,0,500,60))
        numLabel.text = "定員：\(eventMenberNum)人"
        numLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/13*6)
        numLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(numLabel)
        
        
        var joinMessage = ""
        if eventDiveJoin == true {
            joinMessage = "あり"
        }else{
            joinMessage = "なし"
        }
        
        let joinLabel = UILabel(frame: CGRectMake(0,0,500,60))
        joinLabel.text = "途中参加：\(joinMessage)"
        joinLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/13*7)
        joinLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(joinLabel)
        
        let tagLabel = UILabel(frame: CGRectMake(0,0,500,120))
        tagLabel.text = "タグ：\(eventTag)"
        tagLabel.layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/13*8)
        tagLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(tagLabel)
        
        closeButton = UIButton(frame:CGRectMake(0, 0, 150, 50))
        closeButton.backgroundColor = UIColor.redColor()
        closeButton.tag = 1
        closeButton.setTitle("とじる", forState: UIControlState.Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        closeButton.addTarget(self, action: "closeAction:", forControlEvents: .TouchUpInside)
        self.closeButton.layer.position = CGPoint(x: self.view.frame.width/4, y:self.view.frame.size.height/10*9)
        self.view.addSubview(self.closeButton)
        
        self.nextButton = UIButton(frame: CGRectMake(0, 0, 150, 50))
        self.nextButton.backgroundColor = UIColor.orangeColor()
        self.nextButton.tag = 2
        self.nextButton.setTitle("決定する", forState: UIControlState.Normal)
        self.nextButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.nextButton.addTarget(self, action: "closeAction:", forControlEvents: .TouchUpInside)
        self.nextButton.layer.position = CGPoint(x: self.view.frame.width/4*3, y:self.view.frame.size.height/10*9)
        self.view.addSubview(self.nextButton)
        
    }
    
    func checkGenre(){
        switch eventGenre{
        case 1:
            eventGenreStr = "勉強会"
        case 2:
            eventGenreStr = "パーティー"
        case 3:
            eventGenreStr = "サークル"
        case 4:
            eventGenreStr = "大会"
        case 5:
            eventGenreStr = "趣味"
        case 6:
            eventGenreStr = "読書会"
        default:
            break
        }
        
    }
    
    func closeAction(sender: UIButton){
        self.lastCheckEventDelegate.closeDecisionEventWindow(sender.tag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
