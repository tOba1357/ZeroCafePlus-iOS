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
        
        let assetsLabel = UILabel(frame: CGRectMake(0,self.frame.height*(110/1136),self.frame.width/4,self.frame.height*(28/1136)))
        assetsLabel.text = "持ち物（任意）"
        assetsLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        assetsLabel.textAlignment = NSTextAlignment.Left
        assetsLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        assetsLabel.sizeToFit()
        
        assetText = UITextField(frame: CGRectMake(0,self.frame.height*(162/1136),self.frame.width,self.frame.height*(56/1136)))
        assetText.text = ""
        assetText.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        assetText.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        assetText.placeholder = "例）熱意"
        assetText.layer.cornerRadius = 13.5
        assetText.delegate = self
        assetText.layer.borderWidth = 0.75
        assetText.layer.borderColor = CommonFunction().UIColorFromRGB(rgbValue: 0x808080).CGColor
        
        let numLabel = UILabel(frame: CGRectMake(0,self.frame.height*(286/1136),self.frame.width,self.frame.height*(28/1136)))
        numLabel.text = "定員"
        numLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        numLabel.textAlignment = NSTextAlignment.Left
        numLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        numLabel.sizeToFit()
        
        numText = UITextField(frame: CGRectMake(0,self.frame.height*(338/1136),self.frame.width,self.frame.height*(56/1136)))
        numText.text = "0"
        numText.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        numText.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        numText.placeholder = "例）15"
        numText.inputAccessoryView = myToolBar
        numText.layer.cornerRadius = 13.5
        numText.delegate = self
        numText.keyboardType = .NumberPad
        numText.layer.borderWidth = 0.75
        numText.layer.borderColor = CommonFunction().UIColorFromRGB(rgbValue: 0x808080).CGColor
        
        let checkbox = CTCheckbox()
        checkbox.frame = CGRectMake(0,self.frame.height*(446/1136),self.frame.width/5,self.frame.height/10)
        checkbox.checkboxColor = UIColor.blackColor()
        checkbox.checkboxSideLength = 22
        checkbox.setColor(CommonFunction().UIColorFromRGB(rgbValue: 0xFF8010), forControlState: .Normal)
        checkbox.setColor(CommonFunction().UIColorFromRGB(rgbValue: 0xFF8010), forControlState: .Disabled)
        
        let jumpInLabel = UILabel(frame: CGRectMake(checkbox.frame.size.width,self.frame.height*(484/1136),self.frame.width/2,self.frame.height*(28/1136)))
        jumpInLabel.text = "途中参加ＯＫ"
        jumpInLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        jumpInLabel.textAlignment = NSTextAlignment.Left
        jumpInLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        jumpInLabel.sizeToFit()
        
        let tagLabel = UILabel(frame: CGRectMake(0,self.frame.height*(602/1136),self.frame.width,self.frame.height*(28/1136)))
        tagLabel.text = "タグ　※検索で引っかかりやすくなるよ！"
        tagLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        tagLabel.textAlignment = NSTextAlignment.Left
        tagLabel.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        tagLabel.sizeToFit()
        
        tagText = UITextField(frame: CGRectMake(0,self.frame.height*(654/1136),self.frame.width,self.frame.height*(56/1136)))
        tagText.text = ""
        tagText.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        tagText.textColor = CommonFunction().UIColorFromRGB(rgbValue: 0x1A1A1A)
        tagText.placeholder = "#祭り"
        tagText.layer.cornerRadius = 13.5
        tagText.delegate = self
        tagText.layer.borderWidth = 0.75
        tagText.layer.borderColor = CommonFunction().UIColorFromRGB(rgbValue: 0x808080).CGColor
        
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
