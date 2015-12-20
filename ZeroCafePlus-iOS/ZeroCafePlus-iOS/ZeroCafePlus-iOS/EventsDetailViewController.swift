//
//  EventsDetailViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by 紺谷和正 on 2015/12/20.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class EventsDetailViewController: UIViewController EventsDetailViewController: UIViewController {
    
    private var eventTitle: UILabel!
    private var eventDate: UILabel!
    private var eventTime: UILabel!
    private var eventDetails: UILabel!
    private var eventTag: UILabel!
    private var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        eventTitle = UILabel(frame: CGRectMake(screenWidth/2,screenHeight/10,screenWidth/2,screenHeight/6))
        eventTitle.text = "レトロゲーム王者"
        eventTitle.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        eventTitle.numberOfLines = 0
        eventTitle.sizeToFit()
        self.view.addSubview(eventTitle)
        
        eventDate = UILabel(frame: CGRectMake(0,0,100,100))
        eventDate.textColor = UIColor.hexStr("#1A1A1A", alpha:1.0)
        self.view.addSubview(eventDate)
        
        eventTime = UILabel(frame: CGRectMake(0,0,100,100))
        eventTime.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        self.view.addSubview(eventTime)
        
        eventTag = UILabel(frame: CGRectMake(0,0,100,100))
        eventTag.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        self.view.addSubview(eventTag)
        
        eventDetails = UILabel(frame: CGRectMake(0,0,100,100))
        eventDetails.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        self.view.addSubview(eventDetails)
        
        cancelButton = UIButton(frame: CGRectMake(0,0,100,100))
        cancelButton.setTitle("キャンセル連絡をする", forState: .Normal)
        cancelButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        self.view.addSubview(cancelButton)
        
    }
    override func viewWillAppear(animated: Bool) {
        
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
    */
    
}
