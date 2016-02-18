//
//  SecondViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by Kento Takemoto on 2015/12/11.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIToolbarDelegate {
    
    private var titleIcon:UIImageView!
    private var dateIcon:UIImageView!
    private var genreLabel:UILabel!
    
    private var searchTitle:UITextField!
    private var startTime:UITextField!
    private var endTime:UITextField!
    private var tooLabel: UILabel!
    
    private var studyButton:UIButton!
    private var jobHuntNButton:UIButton!
    private var readButton:UIButton!
    private var gameButton:UIButton!
    private var circleButton:UIButton!
    private var hobbyButton:UIButton!
    private var partyButton:UIButton!
    
    private var studyLabel: UILabel!
    private var jobHuntLabel: UILabel!
    private var readLabel: UILabel!
    private var gameLabel: UILabel!
    private var circleLabel: UILabel!
    private var hobbyLabel:UILabel!
    private var partyLabel: UILabel!
    
    private var startDatePicker:UIDatePicker!
    private var startDatePicker2: UIDatePicker!
    
    private var myToolBar: UIToolbar!
    
    private var clearButton:UIButton!
    private var searchEvents:UIButton!
    
    private var genreCount:[Int] = []
    private var userStartTime: String!
    private var userEndTime: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let countClick = NSUserDefaults.standardUserDefaults()
        countClick.removeObjectForKey("勉強会")
        countClick.removeObjectForKey("パーティ")
        countClick.removeObjectForKey("サークル")
        countClick.removeObjectForKey("大会")
        countClick.removeObjectForKey("読書会")
        countClick.removeObjectForKey("趣味")
        countClick.removeObjectForKey("就活")
        countClick.removeObjectForKey("SearchTitle")
        countClick.removeObjectForKey("StartTime")
        countClick.removeObjectForKey("EndTime")
        countClick.removeObjectForKey("genreCount")
        countClick.synchronize()
        let screenSize: CGSize = UIScreen.mainScreen().bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        self.title = ""
        self.view.backgroundColor = UIColor.whiteColor()
        
        let myKeyboard = UIView(frame: CGRectMake(0, 0, 320, 40))
        myKeyboard.backgroundColor = UIColor.whiteColor()
        
        let myButton = UIButton(frame: CGRectMake(300, 5, 70, 30))
        myButton.backgroundColor = UIColor.whiteColor()
        myButton.setTitle("完了", forState: .Normal)
        myButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        myButton.layer.cornerRadius = 2.0
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        myKeyboard.addSubview(myButton)
        
        let titleImage = UIImage(named: "search_Aa.png")
        titleIcon = UIImageView(image: titleImage )
        titleIcon.frame = CGRectMake(screenWidth/13.9, screenHeight/13.91, screenWidth/11.0, screenHeight/33.4)
        self.view.addSubview(titleIcon)
        
        let dateImage = UIImage(named: "search_calendar.png")
        dateIcon = UIImageView(image: dateImage)
        dateIcon.frame = CGRectMake(screenWidth/13.9, screenHeight/5.0, screenWidth/14.23, screenHeight/25.244)
        self.view.addSubview(dateIcon)
        
        genreLabel = UILabel()
        genreLabel.text = "ジャンル"
        genreLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        genreLabel.frame = CGRectMake(screenWidth/13.9, screenHeight/3, screenWidth/5, screenHeight/17)
        genreLabel.textAlignment = NSTextAlignment.Left
        self.view.addSubview(genreLabel)
        
        let placeholder = NSAttributedString(string: "イベント名、関連ワードなど", attributes: [NSForegroundColorAttributeName : UIColor.hexStr("#a5a5a5", alpha: 1.0)])
        searchTitle = UITextField()
        searchTitle.attributedPlaceholder = placeholder
        searchTitle.inputAccessoryView = myKeyboard
        searchTitle.font = UIFont.systemFontOfSize(16)
        searchTitle.textAlignment = NSTextAlignment.Center
        searchTitle.textColor = UIColor.hexStr("#a5a5a5", alpha: 1.0)
        searchTitle.backgroundColor = UIColor.clearColor()
        searchTitle.frame = CGRectMake(screenWidth/4.5, screenHeight/16.5, screenWidth/1.42, screenHeight/17)
        searchTitle.addUnderline(1.159, color: UIColor.hexStr("#a5a5a5", alpha: 1.0))
        self.view.addSubview(searchTitle)
        
        startDatePicker = UIDatePicker()
        startDatePicker.addTarget(self, action: "changedDateEvent:", forControlEvents: UIControlEvents.ValueChanged)
        startDatePicker.datePickerMode = UIDatePickerMode.Date
        startDatePicker.locale = NSLocale(localeIdentifier: "ja")
        startDatePicker2 = UIDatePicker()
        startDatePicker2.addTarget(self, action: "changedDateEvent2:", forControlEvents: UIControlEvents.ValueChanged)
        startDatePicker2.locale = NSLocale(localeIdentifier: "ja")
        startDatePicker2.datePickerMode = UIDatePickerMode.Date
        
        myToolBar = UIToolbar(frame: CGRectMake(0, screenHeight/6, screenWidth, 40.0))
        myToolBar.layer.position = CGPoint(x: screenWidth/2, y: screenHeight-20.0)
        myToolBar.backgroundColor = UIColor.whiteColor()
        myToolBar.barStyle = UIBarStyle.Black
        myToolBar.tintColor = UIColor.blueColor()
        let myToolBarButton = UIBarButtonItem(title: "完了", style: UIBarButtonItemStyle.Done, target: self, action: "onClick:")
        myToolBarButton.tag = 1
        myToolBar.items = [myToolBarButton]
        
        let placeholder2 = NSAttributedString(string: "指定なし", attributes: [NSForegroundColorAttributeName : UIColor.hexStr("#a5a5a5", alpha: 1.0)])
        startTime = UITextField(frame: CGRectMake(screenWidth/4.5, screenHeight/5.0,screenWidth/3.3, screenHeight/21))
        startTime.textColor = UIColor.hexStr("a5a5a5", alpha: 1.0)
        startTime.attributedPlaceholder = placeholder2
        startTime.text = ""
        startTime.textAlignment = NSTextAlignment.Center
        startTime.font = UIFont.systemFontOfSize(12)
        startTime.addUnderline(1.2, color: UIColor.hexStr("#a5a5a5", alpha: 1.0))
        startTime.inputView = startDatePicker
        startTime.inputAccessoryView = myToolBar
        self.view.addSubview(startTime)
        
        endTime = UITextField(frame: CGRectMake(screenWidth/1.6, screenHeight/5.0,screenWidth/3.3, screenHeight/21))
        endTime.textColor = UIColor.hexStr("a5a5a5", alpha: 1.0)
        endTime.attributedPlaceholder = placeholder2
        endTime.text = ""
        endTime.font = UIFont.systemFontOfSize(12)
        endTime.addUnderline(1.2, color: UIColor.hexStr("#a5a5a5", alpha: 1.0))
        endTime.textAlignment = NSTextAlignment.Center
        endTime.inputView = startDatePicker2
        endTime.inputAccessoryView = myToolBar
        self.view.addSubview(endTime)
        
        tooLabel = UILabel(frame: CGRectMake(screenWidth/1.85, screenHeight/5.0, screenWidth/14.2, screenHeight/30))
        tooLabel.text = "〜"
        tooLabel.font = UIFont.systemFontOfSize(18)
        tooLabel.textColor = UIColor.hexStr("a5a5a5", alpha: 1.0)
        tooLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(tooLabel)
        
        clearButton = UIButton(frame: CGRectMake(screenWidth/13.9, screenHeight/1.28, screenWidth/3.1606, screenHeight/17.75))
        clearButton.setTitle("クリア", forState: .Normal)
        clearButton.setTitleColor(UIColor.hexStr("#FFFFFF", alpha: 1.0), forState: .Normal)
        clearButton.backgroundColor = UIColor.hexStr("#B3B3B3", alpha: 1.0)
        clearButton.layer.cornerRadius = 8.0
        clearButton.addTarget(self, action: "clearEverything:", forControlEvents: .TouchUpInside)
        self.view.addSubview(clearButton)
        
        searchEvents = UIButton(frame: CGRectMake(screenWidth-screenWidth/1.927, screenHeight/1.28, screenWidth/2.237, screenHeight/17.75))
        searchEvents.setTitle("検索する", forState: .Normal)
        searchEvents.setTitleColor(UIColor.hexStr("#FFFFFF", alpha: 1.0), forState: .Normal)
        searchEvents.backgroundColor = UIColor.hexStr("#FF8010", alpha: 1.0)
        searchEvents.layer.cornerRadius = 8.0
        searchEvents.addTarget(self, action: "searchStart:", forControlEvents: .TouchUpInside)
        self.view.addSubview(searchEvents)
        
        hobbyButton = UIButton()
        hobbyButton.tag = 5
        hobbyButton.setImage(UIImage(named: "Zerohobby.png"), forState: .Normal)
        hobbyButton.addTarget(self, action: "clickGenreButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(hobbyButton)
        hobbyButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.hobbyButton,attribute: .Top,relatedBy: .Equal,toItem: self.genreLabel,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/27.0),
            NSLayoutConstraint(item: self.hobbyButton,attribute: .Left,relatedBy: .Equal,toItem: self.view,attribute: .Left,multiplier: 1.0,constant: screenWidth/6.80),
            NSLayoutConstraint(item: self.hobbyButton,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.hobbyButton,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/14.564)]
        )
        
        jobHuntNButton = UIButton()
        jobHuntNButton.tag = 7
        jobHuntNButton.setImage(UIImage(named: "Zerojobhunt.png"), forState: .Normal)
        jobHuntNButton.addTarget(self, action: "clickGenreButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(jobHuntNButton)
        jobHuntNButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.jobHuntNButton,attribute: .Top,relatedBy: .Equal,toItem: self.hobbyButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/15.35),
            NSLayoutConstraint(item: self.jobHuntNButton,attribute: .Left,relatedBy: .Equal,toItem: self.view,attribute: .Left,multiplier: 1.0,constant: screenWidth/6.8),
            NSLayoutConstraint(item: self.jobHuntNButton,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.jobHuntNButton,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/14.564)]
        )
        
        gameButton = UIButton()
        gameButton.tag = 4
        gameButton.setImage(UIImage(named: "Zerogame.png"), forState: .Normal)
        gameButton.addTarget(self, action: "clickGenreButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(gameButton)
        gameButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.gameButton,attribute: .Top,relatedBy: .Equal,toItem: self.genreLabel,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/27.0),
            NSLayoutConstraint(item: self.gameButton,attribute: .Left,relatedBy: .Equal,toItem: self.hobbyButton,attribute: NSLayoutAttribute.Right,multiplier: 1.0,constant: screenWidth/13.334),
            NSLayoutConstraint(item: self.gameButton,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.gameButton,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/14.564)]
        )
        
        partyButton = UIButton()
        partyButton.tag = 2
        partyButton.setImage(UIImage(named: "Zeroparty.png"), forState: .Normal)
        partyButton.addTarget(self, action: "clickGenreButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(partyButton)
        partyButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.partyButton,attribute: .Top,relatedBy: .Equal,toItem: self.gameButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/15.35),
            NSLayoutConstraint(item: self.partyButton,attribute: .Left,relatedBy: .Equal,toItem: self.jobHuntNButton,attribute: .Right,multiplier: 1.0,constant: screenWidth/13.334),
            NSLayoutConstraint(item: self.partyButton,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.partyButton,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/14.564)]
        )
        
        readButton = UIButton()
        readButton.tag = 6
        readButton.setImage(UIImage(named: "Zeroread.png"), forState: .Normal)
        readButton.addTarget(self, action: "clickGenreButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(readButton)
        readButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.readButton,attribute: .Top,relatedBy: .Equal,toItem: self.genreLabel,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/27.0),
            NSLayoutConstraint(item: self.readButton,attribute: .Left,relatedBy: .Equal,toItem: self.gameButton,attribute: NSLayoutAttribute.Right,multiplier: 1.0,constant: screenWidth/13.334),
            NSLayoutConstraint(item: self.readButton,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.readButton,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/14.564)]
        )
        
        circleButton = UIButton()
        circleButton.tag = 3
        circleButton.setImage(UIImage(named: "Zerocircle.png"), forState: .Normal)
        circleButton.addTarget(self, action: "clickGenreButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(circleButton)
        circleButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.circleButton,attribute: .Top,relatedBy: .Equal,toItem: self.readButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/15.35),
            NSLayoutConstraint(item: self.circleButton,attribute: .Left,relatedBy: .Equal,toItem: self.partyButton,attribute: .Right,multiplier: 1.0,constant: screenWidth/13.334),
            NSLayoutConstraint(item: self.circleButton,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.circleButton,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/14.564)]
        )
        
        studyButton = UIButton()
        studyButton.tag = 1
        studyButton.setImage(UIImage(named: "Zerostudy.png"), forState: .Normal)
        studyButton.addTarget(self, action: "clickGenreButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(studyButton)
        studyButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.studyButton,attribute: .Top,relatedBy: .Equal,toItem: self.genreLabel,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/27.0),
            NSLayoutConstraint(item: self.studyButton,attribute: .Left,relatedBy: .Equal,toItem: self.readButton,attribute: NSLayoutAttribute.Right,multiplier: 1.0,constant: screenWidth/13.334),
            NSLayoutConstraint(item: self.studyButton,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.studyButton,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/14.564)]
        )
        
        hobbyLabel = UILabel()
        hobbyLabel.text = "趣味"
        hobbyLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        hobbyLabel.font = UIFont.systemFontOfSize(15.25)
        hobbyLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(hobbyLabel)
        hobbyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.hobbyLabel,attribute: .Top,relatedBy: .Equal,toItem: self.hobbyButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/100),
            NSLayoutConstraint(item: self.hobbyLabel,attribute: .Left,relatedBy: .Equal,toItem: self.view,attribute: .Left,multiplier: 1.0,constant: screenWidth/6.80),
            NSLayoutConstraint(item: self.hobbyLabel,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.hobbyLabel,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/40)]
        )
        
        jobHuntLabel = UILabel()
        jobHuntLabel.text = "就活"
        jobHuntLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        jobHuntLabel.textAlignment = NSTextAlignment.Center
        jobHuntLabel.font = UIFont.systemFontOfSize(15.25)
        self.view.addSubview(jobHuntLabel)
        jobHuntLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.jobHuntLabel,attribute: .Top,relatedBy: .Equal,toItem: self.jobHuntNButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/100),
            NSLayoutConstraint(item: self.jobHuntLabel,attribute: .Left,relatedBy: .Equal,toItem: self.view,attribute: .Left,multiplier: 1.0,constant: screenWidth/6.80),
            NSLayoutConstraint(item: self.jobHuntLabel,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.jobHuntLabel,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/40)]
        )
        
        gameLabel = UILabel()
        gameLabel.text = "大会"
        gameLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        gameLabel.font = UIFont.systemFontOfSize(15.25)
        gameLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(gameLabel)
        gameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.gameLabel,attribute: .Top,relatedBy: .Equal,toItem: self.gameButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/100),
            NSLayoutConstraint(item: self.gameLabel,attribute: .Left,relatedBy: .Equal,toItem: self.hobbyButton,attribute: .Right,multiplier: 1.0,constant: screenWidth/13.334),
            NSLayoutConstraint(item: self.gameLabel,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8.2),
            NSLayoutConstraint(item: self.gameLabel,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/40)]
        )
        
        partyLabel = UILabel()
        partyLabel.text = "パーティ"
        partyLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        partyLabel.font = UIFont.systemFontOfSize(14)
        partyLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(partyLabel)
        partyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.partyLabel,attribute: .Top,relatedBy: .Equal,toItem: self.partyButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/100),
            NSLayoutConstraint(item: self.partyLabel,attribute: .Left,relatedBy: .Equal,toItem: self.hobbyButton,attribute: .Right,multiplier: 1.0,constant: screenWidth/16),
            NSLayoutConstraint(item: self.partyLabel,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/6),
            NSLayoutConstraint(item: self.partyLabel,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/40)]
        )
        
        readLabel = UILabel()
        readLabel.text = "読書会"
        readLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        readLabel.font = UIFont.systemFontOfSize(15.25)
        readLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(readLabel)
        readLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.readLabel,attribute: .Top,relatedBy: .Equal,toItem: self.readButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/100),
            NSLayoutConstraint(item: self.readLabel,attribute: .Left,relatedBy: .Equal,toItem: self.gameButton,attribute: .Right,multiplier: 1.0,constant: screenWidth/13.334),
            NSLayoutConstraint(item: self.readLabel,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8),
            NSLayoutConstraint(item: self.readLabel,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/40)]
        )
        
        circleLabel = UILabel()
        circleLabel.text = "サークル"
        circleLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        circleLabel.font = UIFont.systemFontOfSize(14)
        circleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(circleLabel)
        circleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.circleLabel,attribute: .Top,relatedBy: .Equal,toItem: self.circleButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/100),
            NSLayoutConstraint(item: self.circleLabel,attribute: .Left,relatedBy: .Equal,toItem: self.gameButton,attribute: .Right,multiplier: 1.0,constant: screenWidth/16),
            NSLayoutConstraint(item: self.circleLabel,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/6),
            NSLayoutConstraint(item: self.circleLabel,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/40)]
        )
        
        studyLabel = UILabel()
        studyLabel.text = "勉強会"
        studyLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        studyLabel.textAlignment = NSTextAlignment.Center
        studyLabel.font = UIFont.systemFontOfSize(15.25)
        self.view.addSubview(studyLabel)
        studyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            NSLayoutConstraint(item: self.studyLabel,attribute: .Top,relatedBy: .Equal,toItem: self.studyButton,attribute: NSLayoutAttribute.Bottom,multiplier: 1.0,constant: screenHeight/100),
            NSLayoutConstraint(item: self.studyLabel,attribute: .Left,relatedBy: .Equal,toItem: self.readButton,attribute: .Right,multiplier: 1.0,constant: screenWidth/13.334),
            NSLayoutConstraint(item: self.studyLabel,attribute: .Width,relatedBy: .Equal,toItem: nil,attribute: .Width,multiplier: 1.0,constant: screenWidth/8),
            NSLayoutConstraint(item: self.studyLabel,attribute: .Height,relatedBy: .Equal,toItem: nil,attribute: .Height,multiplier: 1.0,constant: screenHeight/40)]
        )
        // Do any additional setup after loading the view
    }
    
    func clickGenreButton(sender: UIButton){
        let countClick = NSUserDefaults.standardUserDefaults()
        if sender.tag == 1{
            if countClick.objectForKey("勉強会") != nil {
                studyButton.setImage(UIImage(named: "Zerostudy.png"), forState: .Normal)
                countClick.removeObjectForKey("勉強会")
                countClick.synchronize()
            }else {
                studyButton.setImage(UIImage(named: "SelectStudy.png"), forState: .Normal)
                countClick.setObject("first", forKey: "勉強会")
                countClick.synchronize()
            }
        }else if sender.tag == 2 {
            if countClick.objectForKey("パーティ") != nil {
                partyButton.setImage(UIImage(named: "Zeroparty.png"), forState: .Normal)
                countClick.removeObjectForKey("パーティ")
                countClick.synchronize()
            }else {
                partyButton.setImage(UIImage(named: "SelectParty.png"), forState: .Normal)
                countClick.setObject("first", forKey: "パーティ")
                countClick.synchronize()
            }
        }else if sender.tag == 3 {
            if countClick.objectForKey("サークル") != nil {
                circleButton.setImage(UIImage(named: "Zerocircle.png"), forState: .Normal)
                countClick.removeObjectForKey("サークル")
                countClick.synchronize()
                
            }else {
                circleButton.setImage(UIImage(named: "SelectCircle.png"), forState: .Normal)
                countClick.setObject("first", forKey: "サークル")
                countClick.synchronize()
            }
            
        }else if sender.tag == 4 {
            if countClick.objectForKey("大会") != nil {
                gameButton.setImage(UIImage(named: "Zerogame.png"), forState: .Normal)
                countClick.removeObjectForKey("大会")
                countClick.synchronize()
            }else {
                gameButton.setImage(UIImage(named: "SelectGame.png"), forState: .Normal)
                countClick.setObject("first", forKey: "大会")
                countClick.synchronize()
            }
        }else if sender.tag == 5 {
            if countClick.objectForKey("趣味") != nil {
                hobbyButton.setImage(UIImage(named: "Zerohobby.png"), forState: .Normal)
                countClick.removeObjectForKey("趣味")
                countClick.synchronize()
            }else {
                hobbyButton.setImage(UIImage(named: "SelectHobby.png"), forState: .Normal)
                countClick.setObject("first", forKey: "趣味")
                countClick.synchronize()
            }
        } else if sender.tag == 6 {
            if countClick.objectForKey("読書会") != nil {
                readButton.setImage(UIImage(named: "Zeroread.png"), forState: .Normal)
                countClick.removeObjectForKey("読書会")
                countClick.synchronize()
            }else {
                readButton.setImage(UIImage(named: "SelectReadbook.png"), forState: .Normal)
                countClick.setObject("first", forKey: "読書会")
                countClick.synchronize()
            }
        } else if sender.tag == 7 {
            if countClick.objectForKey("就活") != nil {
                jobHuntNButton.setImage(UIImage(named: "Zerojobhunt.png"), forState: .Normal)
                countClick.removeObjectForKey("就活")
                countClick.synchronize()
            }else{
                jobHuntNButton.setImage(UIImage(named: "SelectJobHunt.png"), forState: .Normal)
                countClick.setObject("first", forKey: "就活")
                countClick.synchronize()
            }
        }
    }
    
    func clearEverything(sender: UIButton){
        let countClick = NSUserDefaults.standardUserDefaults()
        studyButton.setImage(UIImage(named: "Zerostudy.png"), forState: .Normal)
        countClick.removeObjectForKey("勉強会")
        partyButton.setImage(UIImage(named: "Zeroparty.png"), forState: .Normal)
        countClick.removeObjectForKey("パーティ")
        circleButton.setImage(UIImage(named: "Zerocircle.png"), forState: .Normal)
        countClick.removeObjectForKey("サークル")
        gameButton.setImage(UIImage(named: "Zerogame.png"), forState: .Normal)
        countClick.removeObjectForKey("大会")
        hobbyButton.setImage(UIImage(named: "Zerohobby.png"), forState: .Normal)
        countClick.removeObjectForKey("趣味")
        readButton.setImage(UIImage(named: "Zeroread.png"), forState: .Normal)
        countClick.removeObjectForKey("読書会")
        jobHuntNButton.setImage(UIImage(named: "Zerojobhunt.png"), forState: .Normal)
        countClick.removeObjectForKey("就活")
        countClick.synchronize()
        searchTitle.text = ""
        startTime.text = ""
        endTime.text = ""
    }
    
    func searchStart(sedner: UIButton){
        let userSearch = NSUserDefaults.standardUserDefaults()
        if searchTitle.text == "" {}else{
            userSearch.setObject(searchTitle.text, forKey: "SearchTitle")
        }
        if startTime.text == "" {}else {
            userSearch.setObject(userStartTime, forKey: "StartTime")
        }
        if endTime.text == "" {}else {
            userSearch.setObject(userEndTime, forKey: "EndTime")
        }
        userSearch.synchronize()
        searchGenre()
//        let SRVC = SearchReslutViewController()
//        presentViewController(SRVC, animated: true, completion: nil)
    }
    
    func searchGenre() {
        let countClick = NSUserDefaults.standardUserDefaults()
        if countClick.objectForKey("勉強会") != nil {
            genreCount.append(1)
        }
        if countClick.objectForKey("パーティ") != nil {
            genreCount.append(2)
        }
        if countClick.objectForKey("サークル") != nil {
            genreCount.append(3)
        }
        if countClick.objectForKey("大会") != nil {
            genreCount.append(4)
        }
        if countClick.objectForKey("趣味") != nil {
            genreCount.append(5)
        }
        if countClick.objectForKey("読書会") != nil {
            genreCount.append(6)
        }
        if countClick.objectForKey("就活") != nil {
            genreCount.append(7)
        }
        if genreCount.isEmpty{}else{
            countClick.setObject(genreCount, forKey: "genreCount")
            countClick.synchronize()
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func onClick(sender: UIBarButtonItem) {
        startTime.resignFirstResponder()
        endTime.resignFirstResponder()
    }
    func changedDateEvent(sender:AnyObject?){
        self.changeLabelDate(startDatePicker.date)
    }
    func changedDateEvent2(sender:AnyObject?){
        self.changeLabelDate2(startDatePicker2.date)
    }
    func changeLabelDate(date:NSDate) {
        startTime.text = self.dateToString(date)
    }
    func changeLabelDate2(date:NSDate) {
        endTime.text = self.dateToString2(date)
    }
    
    func dateToString(date:NSDate) ->String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja")
        dateFormatter.dateFormat = "yyy年MM月dd日"
        let selectedDate: NSString = dateFormatter.stringFromDate(date)
        dateFormatter.dateFormat = "yyy-MM-dd"
        userStartTime = dateFormatter.stringFromDate(date)
        return selectedDate as String
    }
    func dateToString2(date:NSDate) ->String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja")
        dateFormatter.dateFormat = "yyy年MM月dd日"
        let selectedDate: NSString = dateFormatter.stringFromDate(date)
        dateFormatter.dateFormat = "yyy-MM-dd"
        userEndTime = dateFormatter.stringFromDate(date)
        return selectedDate as String
    }
    
    
    func onClickMyButton (sender: UIButton) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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

