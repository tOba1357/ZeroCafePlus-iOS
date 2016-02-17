//
//  CreateEventView.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2016/01/24.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

protocol CreateEventDelegate{
    func createEventNameExposition()
    func nilAlertAction(title:String,message:String)
    func getEventNameExposition(name:String,exposition:String,genreNum:Int)
}

class CreateEventView: UIView,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate {
    
    var titleTextField:UITextField!
    var titleAlertLabel:UILabel!
    var detailTextView:UITextView!
    var detailAlertLabel:UILabel!
    var txtActiveView = UITextView()
    
    var titleTextNum :Int = 0
    var detailTextNum :Int = 0
    
    var isBoolTextView:Bool!
    var genreNum :Int!
    
    var hobyImg:UIImage!
    var hoby_sImg:UIImage!
    var studyImg:UIImage!
    var study_sImg:UIImage!
    var sakuruImg:UIImage!
    var sakuru_sImg:UIImage!
    var tournamentImg:UIImage!
    var tournament_sImg:UIImage!
    var readBookImg:UIImage!
    var readBook_sImg:UIImage!
    var partyImg:UIImage!
    var party_sImg:UIImage!
    
    var genreHobyBtn:UIButton!
    var genreStudyBtn:UIButton!
    var genreSakuruBtn:UIButton!
    var genreTournamentBtn:UIButton!
    var genreReadBookBtn:UIButton!
    var genrePartyBtn:UIButton!
    
    var createEventdelegate : CreateEventDelegate!
    
    enum TextFieldType {
        case Title
        case Detail
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        setImage()
        
        isBoolTextView = false
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.frame.size.height/6, self.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height-20.0)
        toolBar.backgroundColor = UIColor.blackColor()
        toolBar.barStyle = UIBarStyle.Black
        toolBar.tintColor = UIColor.whiteColor()
        
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace,target: self,action: "")

        let toolBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "onClick:")
        
        toolBarButton.tag = 1
        toolBar.items = [spaceBarBtn,toolBarButton]
        
        let titleLabel = UILabel(frame: CGRectMake(0,self.frame.size.height*(160/1136),self.frame.width/4*3,self.frame.height*(28/1136)))
        titleLabel.text = "イベント名(18文字以内)"
        titleLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        titleLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        titleLabel.sizeToFit()
        
        titleTextField = UITextField(frame: CGRectMake(0,self.frame.height*(212/1136),self.frame.width,self.frame.height*(56/1136)))
        titleTextField.layer.borderWidth = 0.75
        titleTextField.layer.borderColor = CommonFunction().UIColorFromRGB(rgbValue: 0x808080).CGColor
        titleTextField.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        titleTextField.textAlignment = NSTextAlignment.Left
        titleTextField.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        titleTextField.layer.cornerRadius = 13.5
        titleTextField.delegate = self
        
        titleAlertLabel = UILabel(frame: CGRectMake(self.frame.width/4*3,self.frame.height*(278/1136),self.frame.width/4,self.frame.height*(20/1136)))
        titleAlertLabel.text = "\(titleTextNum)/18"
        titleAlertLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        titleAlertLabel.textAlignment = NSTextAlignment.Right
        
        let detailLabel = UILabel(frame: CGRectMake(0,self.frame.size.height*(324/1136),self.frame.width/4*3,self.frame.height*(28/1136)))
        detailLabel.text = "内容（１００文字以内）"
        detailLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        
        detailTextView = UITextView(frame: CGRectMake(0,self.frame.size.height*(376/1136),self.frame.width,self.frame.height*(264/1136)))
        detailTextView.layer.borderColor = CommonFunction().UIColorFromRGB(rgbValue: 0x808080).CGColor
        detailTextView.layer.borderWidth = 0.75
        detailTextView.layer.cornerRadius = 27
        detailTextView.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        detailTextView.textAlignment = NSTextAlignment.Left
        detailTextView.inputAccessoryView = toolBar
        detailTextView.delegate = self
        
        detailAlertLabel = UILabel(frame: CGRectMake(self.frame.width/4*3,self.frame.height*(650/1136),self.frame.width/4,self.frame.height*(20/1136)))
        detailAlertLabel.text = "\(detailTextNum)/100"
        detailAlertLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        detailAlertLabel.textAlignment = NSTextAlignment.Right
        
        let genreLabel = UILabel(frame: CGRectMake(0,self.frame.size.height*(696/1136),self.frame.width/4*3,self.frame.height*(28/1136)))
        genreLabel.text = "ジャンル"
        genreLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        genreLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        genreLabel.sizeToFit()
        
        var genreBtnPos:CGFloat = 0
        
        genreHobyBtn = UIButton(frame: CGRectMake(genreBtnPos,self.frame.size.height*(748/1136),(self.frame.size.width-self.frame.size.width*(100/1136))/6,(self.frame.size.width-self.frame.size.width*(100/1136))/6))
        genreHobyBtn.setImage(hobyImg, forState: .Normal)
        genreHobyBtn.tag = 5
        genreHobyBtn.addTarget(self, action: "clickGenre:", forControlEvents:.TouchUpInside)
        
        let hobyLabel = UILabel(frame: CGRectMake(genreBtnPos,self.frame.size.height*(760/1136)+genreHobyBtn.frame.size.height,genreHobyBtn.frame.size.width,self.frame.height*(20/1136)))
        hobyLabel.text = "趣味"
        hobyLabel.textAlignment = NSTextAlignment.Center
        hobyLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        hobyLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        genreBtnPos += genreHobyBtn.frame.size.width+self.frame.size.width*(20/1136)
        
        genreStudyBtn = UIButton(frame: CGRectMake(genreBtnPos,self.frame.size.height*(748/1136),(self.frame.size.width-self.frame.size.width*(100/1136))/6,(self.frame.size.width-self.frame.size.width*(100/1136))/6))
        genreStudyBtn.setImage(studyImg, forState: .Normal)
        genreStudyBtn.tag = 1
        genreStudyBtn.addTarget(self, action: "clickGenre:", forControlEvents:.TouchUpInside)
        
        let studyLabel = UILabel(frame: CGRectMake(genreBtnPos,self.frame.size.height*(760/1136)+genreHobyBtn.frame.size.height,genreHobyBtn.frame.size.width,self.frame.height*(20/1136)))
        studyLabel.text = "勉強会"
        studyLabel.textAlignment = NSTextAlignment.Center
        studyLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        studyLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        genreBtnPos += genreHobyBtn.frame.size.width+self.frame.size.width*(20/1136)
        
        genreSakuruBtn = UIButton(frame: CGRectMake(genreBtnPos,self.frame.size.height*(748/1136),(self.frame.size.width-self.frame.size.width*(100/1136))/6,(self.frame.size.width-self.frame.size.width*(100/1136))/6))
        genreSakuruBtn.setImage(sakuruImg, forState: .Normal)
        genreSakuruBtn.tag = 3
        genreSakuruBtn.addTarget(self, action: "clickGenre:", forControlEvents:.TouchUpInside)
        
        let sakuruLabel = UILabel(frame: CGRectMake(genreBtnPos,self.frame.size.height*(760/1136)+genreHobyBtn.frame.size.height,genreHobyBtn.frame.size.width,self.frame.height*(20/1136)))
        sakuruLabel.text = "サークル"
        sakuruLabel.textAlignment = NSTextAlignment.Center
        sakuruLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        sakuruLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        genreBtnPos += genreHobyBtn.frame.size.width+self.frame.size.width*(20/1136)
        
        genreTournamentBtn = UIButton(frame: CGRectMake(genreBtnPos,self.frame.size.height*(748/1136),(self.frame.size.width-self.frame.size.width*(100/1136))/6,(self.frame.size.width-self.frame.size.width*(100/1136))/6))
        genreTournamentBtn.setImage(tournamentImg, forState: .Normal)
        genreTournamentBtn.tag = 4
        genreTournamentBtn.addTarget(self, action: "clickGenre:", forControlEvents:.TouchUpInside)
        
        let tournamentLabel = UILabel(frame: CGRectMake(genreBtnPos,self.frame.size.height*(760/1136)+genreHobyBtn.frame.size.height,genreHobyBtn.frame.size.width,self.frame.height*(20/1136)))
        tournamentLabel.text = "大会"
        tournamentLabel.textAlignment = NSTextAlignment.Center
        tournamentLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        tournamentLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        genreBtnPos += genreHobyBtn.frame.size.width+self.frame.size.width*(20/1136)
        
        genreReadBookBtn = UIButton(frame: CGRectMake(genreBtnPos,self.frame.size.height*(748/1136),(self.frame.size.width-self.frame.size.width*(100/1136))/6,(self.frame.size.width-self.frame.size.width*(100/1136))/6))
        genreReadBookBtn.setImage(readBookImg, forState: .Normal)
        genreReadBookBtn.tag = 6
        genreReadBookBtn.addTarget(self, action: "clickGenre:", forControlEvents:.TouchUpInside)
        
        let readBookLabel = UILabel(frame: CGRectMake(genreBtnPos,self.frame.size.height*(760/1136)+genreHobyBtn.frame.size.height,genreHobyBtn.frame.size.width,self.frame.height*(20/1136)))
        readBookLabel.text = "読書会"
        readBookLabel.textAlignment = NSTextAlignment.Center
        readBookLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        readBookLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        
        genreBtnPos += genreHobyBtn.frame.size.width+self.frame.size.width*(20/1136)
        
        genrePartyBtn = UIButton(frame: CGRectMake(genreBtnPos,self.frame.size.height*(748/1136),(self.frame.size.width-self.frame.size.width*(100/1136))/6,(self.frame.size.width-self.frame.size.width*(100/1136))/6))
        genrePartyBtn.setImage(partyImg, forState: .Normal)
        genrePartyBtn.tag = 2
        genrePartyBtn.addTarget(self, action: "clickGenre:", forControlEvents:.TouchUpInside)
        
        let partyLabel = UILabel(frame: CGRectMake(genreBtnPos,self.frame.size.height*(760/1136)+genreHobyBtn.frame.size.height,genreHobyBtn.frame.size.width,self.frame.height*(20/1136)))
        partyLabel.text = "パーティー"
        partyLabel.textAlignment = NSTextAlignment.Center
        partyLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        partyLabel.font = UIFont.systemFontOfSize(self.frame.height*(20/1136))
        partyLabel.sizeToFit()
        
        let myButton = UIButton(frame: CGRectMake(0,0,self.frame.width/5,self.frame.height/10))
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 20.0
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        myButton.backgroundColor = UIColor.redColor()
        myButton.layer.position = CGPoint(x: self.frame.width/2, y:self.frame.height/10*8.5)
        
        self.addSubview(titleLabel)
        self.addSubview(titleTextField)
        self.addSubview(titleAlertLabel)
        self.addSubview(detailLabel)
        self.addSubview(detailTextView)
        self.addSubview(detailAlertLabel)
        self.addSubview(genreLabel)
        self.addSubview(genreHobyBtn)
        self.addSubview(genreStudyBtn)
        self.addSubview(genreSakuruBtn)
        self.addSubview(genreTournamentBtn)
        self.addSubview(genreReadBookBtn)
        self.addSubview(genrePartyBtn)
        self.addSubview(hobyLabel)
        self.addSubview(studyLabel)
        self.addSubview(sakuruLabel)
        self.addSubview(tournamentLabel)
        self.addSubview(readBookLabel)
        self.addSubview(partyLabel)
        self.addSubview(myButton)
        print(genreHobyBtn.frame)
        print(genreHobyBtn.layer.position.x)
        print(genreHobyBtn.layer.position.y)
    }
    
    func clickGenre(sender: UIButton){
        switch sender.tag{
        case 1:
            genreNum = sender.tag
            genreHobyBtn.setImage(hobyImg, forState: .Normal)
            genreStudyBtn.setImage(study_sImg, forState: .Normal)
            genreSakuruBtn.setImage(sakuruImg, forState: .Normal)
            genreTournamentBtn.setImage(tournamentImg, forState: .Normal)
            genreReadBookBtn.setImage(readBookImg, forState: .Normal)
            genrePartyBtn.setImage(partyImg, forState: .Normal)
        case 2:
            genreNum = sender.tag
            genreHobyBtn.setImage(hobyImg, forState: .Normal)
            genreStudyBtn.setImage(studyImg, forState: .Normal)
            genreSakuruBtn.setImage(sakuruImg, forState: .Normal)
            genreTournamentBtn.setImage(tournamentImg, forState: .Normal)
            genreReadBookBtn.setImage(readBookImg, forState: .Normal)
            genrePartyBtn.setImage(party_sImg, forState: .Normal)

        case 3:
            genreNum = sender.tag
            genreHobyBtn.setImage(hobyImg, forState: .Normal)
            genreStudyBtn.setImage(studyImg, forState: .Normal)
            genreSakuruBtn.setImage(sakuru_sImg, forState: .Normal)
            genreTournamentBtn.setImage(tournamentImg, forState: .Normal)
            genreReadBookBtn.setImage(readBookImg, forState: .Normal)
            genrePartyBtn.setImage(partyImg, forState: .Normal)
            
        case 4:
            genreNum = sender.tag
            genreHobyBtn.setImage(hobyImg, forState: .Normal)
            genreStudyBtn.setImage(studyImg, forState: .Normal)
            genreSakuruBtn.setImage(sakuruImg, forState: .Normal)
            genreTournamentBtn.setImage(tournament_sImg, forState: .Normal)
            genreReadBookBtn.setImage(readBookImg, forState: .Normal)
            genrePartyBtn.setImage(partyImg, forState: .Normal)
            
        case 5:
            genreNum = sender.tag
            genreHobyBtn.setImage(hoby_sImg, forState: .Normal)
            genreStudyBtn.setImage(studyImg, forState: .Normal)
            genreSakuruBtn.setImage(sakuruImg, forState: .Normal)
            genreTournamentBtn.setImage(tournamentImg, forState: .Normal)
            genreReadBookBtn.setImage(readBookImg, forState: .Normal)
            genrePartyBtn.setImage(partyImg, forState: .Normal)

        case 6:
            genreNum = sender.tag
            genreHobyBtn.setImage(hobyImg, forState: .Normal)
            genreStudyBtn.setImage(studyImg, forState: .Normal)
            genreSakuruBtn.setImage(sakuruImg, forState: .Normal)
            genreTournamentBtn.setImage(tournamentImg, forState: .Normal)
            genreReadBookBtn.setImage(readBook_sImg, forState: .Normal)
            genrePartyBtn.setImage(partyImg, forState: .Normal)
            
        default:
            break
        }
    }
    
    func onClickMyButton(sender: UIButton){
        if titleTextField.text?.characters.count > 0 && detailTextView.text?.characters.count > 0 && genreNum != nil{
            if titleTextField.text?.characters.count > 18 || detailTextView.text?.characters.count > 100{
                self.createEventdelegate.nilAlertAction("規定の文字を越えています", message: "イベント名か内容の文字数が越えています")
            }else{
                self.createEventdelegate.createEventNameExposition()
            }
        } else {
            self.createEventdelegate.nilAlertAction("必要な情報が入力されていません", message: "イベント名と内容を入力・ジャンルの選択ができていません")
        }
    }
    
    func postEventDate(){
        if titleTextField.text?.characters.count > 0 && detailTextView.text?.characters.count > 0 {
            if titleTextField.text?.characters.count > 18 || detailTextView.text?.characters.count > 100{
                self.createEventdelegate.nilAlertAction("規定の文字を越えています", message: "イベント名か内容の文字数が越えています")
            }else{
                self.createEventdelegate.getEventNameExposition(titleTextField.text!, exposition: detailTextView.text,genreNum: genreNum)
            }
        } else {
            self.createEventdelegate.nilAlertAction("必要な情報が入力されていません", message: "イベント名と内容を入力されていません")
        }
    }
    
    func setImage(){
        
        hobyImg = CommonFunction().resizingImage(imageName: "hobby.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        hoby_sImg = CommonFunction().resizingImage(imageName: "SelectHobby.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        studyImg = CommonFunction().resizingImage(imageName: "study.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        study_sImg = CommonFunction().resizingImage(imageName: "SelectStudy.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        sakuruImg = CommonFunction().resizingImage(imageName: "sakuru.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        sakuru_sImg = CommonFunction().resizingImage(imageName: "SelectCircle.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        tournamentImg = CommonFunction().resizingImage(imageName: "tournament.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        tournament_sImg = CommonFunction().resizingImage(imageName: "SelectGame.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        readBookImg = CommonFunction().resizingImage(imageName: "readbook.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        readBook_sImg = CommonFunction().resizingImage(imageName: "SelectReadbook.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        partyImg = CommonFunction().resizingImage(imageName: "party.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
        
        party_sImg = CommonFunction().resizingImage(imageName: "SelectParty.png", w: (self.frame.size.width-self.frame.size.width*(100/1136))/6, h: (self.frame.size.width-self.frame.size.width*(100/1136))/6)
    }
    
    //--TextField--
    func textFieldDidBeginEditing(textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        var tmpStr = textField.text! as NSString
        tmpStr = tmpStr.stringByReplacingCharactersInRange(range, withString: string)
        
        titleTextNum = tmpStr.length
        titleAlertLabel.text = "\(titleTextNum)/18"
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //--TextView--
    func textViewDidChange(textView: UITextView) {
        print("textViewDidChange : \(textView.text)");
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing : \(textView.text)");
        txtActiveView = textView
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool{
        var tmpStr = textView.text! as NSString
        tmpStr = tmpStr.stringByReplacingCharactersInRange(range, withString: text)
        
        detailTextNum = tmpStr.length
        detailAlertLabel.text = "\(detailTextNum)/100"
        return true
    }
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        print("textViewShouldEndEditing : \(textView.text)");
        return true
    }
    
    func onClick(sender: UIBarButtonItem) {
        self.endEditing(true)
    }
    
}
