//
//  CreateEventVC.swift
//  ExsampleCafeVer2
//
//  Created by Shohei_Hayashi on 2015/12/20.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit

protocol CreateEventDetailDelegate{
    func decideEventDetail(assetStr:String,menberNumStr:String,diveJoinBool:Bool,tagStr:String)
}

class CreateEventDetailView: UIView,UITextFieldDelegate {
    
    var assetText :UITextField!
    var numText :UITextField!
    var tagText :UITextField!
    
    var diveJoinBool:Bool = false
    
    var createEventDetailDelegate:CreateEventDetailDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        let myToolBar = UIToolbar(frame: CGRectMake(0, self.frame.size.height/6, self.frame.size.width, 40.0))
        myToolBar.layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height-20.0)
        myToolBar.backgroundColor = UIColor.blackColor()
        myToolBar.barStyle = UIBarStyle.Black
        myToolBar.tintColor = UIColor.whiteColor()
        
        let myToolBarButton = UIBarButtonItem(title: "Close", style: .Bordered, target: self, action: "onClick:")
        myToolBarButton.tag = 1
        myToolBar.items = [myToolBarButton]
        
        let assetsLabel = UILabel(frame: CGRectMake(0,0,self.frame.width/4,self.frame.height/10))
        assetsLabel.text = "持ち物（任意）"
        assetsLabel.layer.position = CGPointMake(self.frame.width/4, self.frame.height/6)
        
        assetText = UITextField(frame: CGRectMake(0,0,self.frame.width/3,self.frame.height/10))
        assetText.text = ""
        assetText.placeholder = "例）熱意"
        assetText.layer.cornerRadius = 15
        assetText.delegate = self
        assetText.layer.borderWidth = 1
        assetText.layer.borderColor = UIColor.blackColor().CGColor
        assetText.layer.position = CGPointMake(self.frame.width/3*2, self.frame.height/6)
        
        let numLabel = UILabel(frame: CGRectMake(0,0,self.frame.width/4,self.frame.height/10))
        numLabel.text = "定員"
        numLabel.layer.position = CGPointMake(self.frame.width/4, self.frame.height/3)
        
        numText = UITextField(frame: CGRectMake(0,0,self.frame.width/3,self.frame.height/10))
        numText.text = "0"
        numText.placeholder = "例）15"
        numText.inputAccessoryView = myToolBar
        numText.layer.cornerRadius = 15
        numText.delegate = self
        numText.keyboardType = .NumberPad
        numText.layer.borderWidth = 1
        numText.layer.borderColor = UIColor.blackColor().CGColor
        numText.layer.position = CGPointMake(self.frame.width/3*2, self.frame.height/3)

        let checkbox = CTCheckbox()
        checkbox.frame = CGRectMake(0,0,self.frame.width/5,self.frame.height/10)
        checkbox.checkboxColor = UIColor.blackColor()
        checkbox.checkboxSideLength = 22
        checkbox.layer.position = CGPointMake(self.frame.width/4, self.frame.height/2)
        
        let jumpInLabel = UILabel(frame: CGRectMake(0,0,self.frame.width/2,self.frame.height/10))
        jumpInLabel.text = "途中参加ＯＫ"
        jumpInLabel.layer.position = CGPointMake(self.frame.width/3*2, self.frame.height/2)
        
        let tagLabel = UILabel(frame: CGRectMake(0,0,self.frame.width/4,self.frame.height/10))
        tagLabel.text = "タグ　※検索で引っかかりやすくなるよ！"
        tagLabel.layer.position = CGPointMake(self.frame.width/4, self.frame.height/3*2)
        
        tagText = UITextField(frame: CGRectMake(0,0,self.frame.width/3,self.frame.height/10))
        tagText.text = ""
        tagText.placeholder = "例）#祭り"
        tagText.layer.cornerRadius = 15
        tagText.delegate = self
        tagText.layer.borderWidth = 1
        tagText.layer.borderColor = UIColor.blackColor().CGColor
        tagText.layer.position = CGPointMake(self.frame.width/3*2, self.frame.height/3*2)
        
        let makeButton = UIButton (frame: CGRectMake(0,0,self.frame.width/5,self.frame.height/10))
        makeButton.layer.masksToBounds = true
        makeButton.layer.cornerRadius = 20.0
        makeButton.addTarget(self, action: "onClickMakeButton:", forControlEvents: .TouchUpInside)
        makeButton.backgroundColor = UIColor.redColor()
        makeButton.layer.position = CGPointMake(self.frame.width/2, self.frame.height/6*5)

        
        self.addSubview(assetsLabel)
        self.addSubview(assetText)
        self.addSubview(numLabel)
        self.addSubview(numText)
        self.addSubview(tagLabel)
        self.addSubview(tagText)
        self.addSubview(checkbox)
        self.addSubview(jumpInLabel)
        self.addSubview(makeButton)
        
    }
    
    func checked(sender:CTCheckbox) {
        diveJoinBool = !diveJoinBool
    }
    
    func onClickMakeButton(sender: UIButton){
        
        if numText.text?.characters.count > 0 || tagText.text?.characters.count > 0{
            if assetText.text?.characters.count == 0{
                assetText.text = ""
            }
            if tagText.text!.characters.count == 0{
                tagText.text = ""
            }

        self.createEventDetailDelegate.decideEventDetail(assetText.text!, menberNumStr: numText.text!, diveJoinBool: diveJoinBool, tagStr: tagText.text!)
        }
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    //--TextField--
    func textFieldDidBeginEditing(textField: UITextField){
        print("textFieldDidBeginEditing:" + textField.text!)
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing:" + textField.text!)
        return true
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func onClick(sender: UIBarButtonItem) {
        self.endEditing(true)
    }
}
