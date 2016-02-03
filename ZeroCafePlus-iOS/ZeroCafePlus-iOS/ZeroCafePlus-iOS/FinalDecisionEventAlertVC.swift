//
//  finalDecisionEventAlertVC.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2016/02/03.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class FinalDecisionEventAlertVC: UIViewController,UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let nameLabel:UILabel!
    let expositionLabel:UILabel!
    let dataLabel:UILabel!
    let startTimeLabel:UILabel!
    let endTimeLabel:UILabel!
    let belongingLabel:UILabel!
    let diveJoinLabel:UILabel!
    let MenberNumLabel:UILabel!
    let tagLabel:UILabel!
    
    var eventName :String!
    var eventExposition :String!
    var eventDate :[String]!
    var eventStartTime :String!
    var eventEndTime :String!
    var eventBelonging:String!
    var eventDiveJoin:Bool!
    var eventMenberNum:Int!
    var eventTag:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        scrollView.delegate = self
        scrollView.contentSize   = CGSizeMake(0, 0)
        scrollView.contentOffset = CGPointMake(0.0 , 0.0)
        self.view.addSubview(scrollView)
        
        
        
        
    }

}
