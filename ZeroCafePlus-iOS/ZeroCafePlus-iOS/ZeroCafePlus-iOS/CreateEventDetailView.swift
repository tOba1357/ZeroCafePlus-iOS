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

class CreateEventDetailView: UIView,UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate {
    
    var assetText :UITextField!
    var numText :UITextField!
    var tagText :UITextField!
    
    var diveJoinBool:Bool = false
    
    var MenberNumStr:[String] = []
    var MenberNumInt:Int = 2
    
    var createEventDetailDelegate:CreateEventDetailDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        
        for i in 2...23{
            
            MenberNumStr.append("\(i)人")
        }
        let toolBar = UIToolbar(frame: CGRectMake(0, self.frame.size.height/6, self.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height-20.0)
        toolBar.backgroundColor = UIColor.blackColor()
        toolBar.barStyle = UIBarStyle.Black
        toolBar.tintColor = UIColor.whiteColor()
        
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace,target: self,action: "")
      
        let toolBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "onClick:")
        toolBar.items = [spaceBarBtn,toolBarButton]
        

        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self

        
        let assetsLabel = UILabel(frame: CGRectMake(0,self.frame.height*(110/1136),self.frame.width/4,self.frame.height*(28/1136)))
        assetsLabel.text = "持ち物（任意）"
        assetsLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        assetsLabel.textAlignment = NSTextAlignment.Left
        assetsLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        assetsLabel.sizeToFit()
        
        assetText = UITextField(frame: CGRectMake(0,self.frame.height*(162/1136),self.frame.width,self.frame.height*(56/1136)))
        assetText.text = ""
        assetText.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        assetText.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        assetText.placeholder = "例）熱意"
        assetText.layer.cornerRadius = 13.5
        assetText.delegate = self
        assetText.layer.borderWidth = 0.75
        assetText.layer.borderColor = UIColor.hexStr("#808080", alpha: 1.0).CGColor
        
        let numLabel = UILabel(frame: CGRectMake(0,self.frame.height*(286/1136),self.frame.width,self.frame.height*(28/1136)))
        numLabel.text = "定員"
        numLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        numLabel.textAlignment = NSTextAlignment.Left
        numLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        numLabel.sizeToFit()
        
        numText = UITextField(frame: CGRectMake(0,self.frame.height*(338/1136),self.frame.width,self.frame.height*(56/1136)))
        numText.text = "2人"
        numText.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        numText.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        numText.layer.cornerRadius = 13.5
        numText.inputView = pickerView
        numText.inputAccessoryView = toolBar
        numText.delegate = self
        numText.layer.borderWidth = 0.75
        numText.layer.borderColor = UIColor.hexStr("#808080", alpha: 1.0).CGColor
        
        let checkbox = CTCheckbox()
        checkbox.frame = CGRectMake(0,self.frame.height*(446/1136),self.frame.width/5,self.frame.height/10)
        checkbox.checkboxColor = UIColor.blackColor()
        checkbox.addTarget(self, action: "checked:", forControlEvents: .ValueChanged)
        checkbox.checkboxSideLength = 22
        checkbox.setColor(UIColor.hexStr("#FF8010", alpha: 1.0), forControlState: .Normal)
        checkbox.setColor(UIColor.hexStr("#FF8010", alpha: 1.0), forControlState: .Disabled)
        
        let jumpInLabel = UILabel(frame: CGRectMake(checkbox.frame.size.width,self.frame.height*(484/1136),self.frame.width/2,self.frame.height*(28/1136)))
        jumpInLabel.text = "途中参加ＯＫ"
        jumpInLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        jumpInLabel.textAlignment = NSTextAlignment.Left
        jumpInLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        jumpInLabel.sizeToFit()
        
        let tagLabel = UILabel(frame: CGRectMake(0,self.frame.height*(602/1136),self.frame.width,self.frame.height*(28/1136)))
        tagLabel.text = "タグ　※検索で引っかかりやすくなるよ！"
        tagLabel.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        tagLabel.textAlignment = NSTextAlignment.Left
        tagLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        tagLabel.sizeToFit()
        
        tagText = UITextField(frame: CGRectMake(0,self.frame.height*(654/1136),self.frame.width,self.frame.height*(56/1136)))
        tagText.text = ""
        tagText.font = UIFont.systemFontOfSize(self.frame.height*(28/1136))
        tagText.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        tagText.placeholder = "　#祭り #花火"
        tagText.layer.cornerRadius = 13.5
        tagText.delegate = self
        tagText.layer.borderWidth = 0.75
        tagText.layer.borderColor = UIColor.hexStr("#808080", alpha: 1.0).CGColor
        
        let makeButton = UIButton (frame: CGRectMake(0,0,self.frame.width/3,self.frame.height/15))
        makeButton.layer.masksToBounds = true
        makeButton.layer.cornerRadius = 20.0
        makeButton.setTitle("決定", forState: .Normal)
        makeButton.backgroundColor = UIColor.hexStr("#f39800", alpha: 1.0)
        makeButton.addTarget(self, action: "onClickMakeButton:", forControlEvents: .TouchUpInside)
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
            
            self.createEventDetailDelegate.decideEventDetail(assetText.text!, menberNumStr: String(MenberNumInt), diveJoinBool: diveJoinBool, tagStr: tagText.text!)
        }
    }
    
    //pickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return MenberNumStr.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        MenberNumInt = row+2
        return MenberNumStr[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numText.text = "\(MenberNumStr[row])"
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
