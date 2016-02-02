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
    func getEventNameExposition(name:String,exposition:String)
}

class CreateEventView: UIView,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate {
    
    var titleTextField:UITextField!
    var titleAlertLabel:UILabel!
    var detailTextView:UITextView!
    var detailAlertLabel:UILabel!
    var txtActiveView = UITextView()
    var isBoolTextView:Bool!
    
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
        
        isBoolTextView = false
        
        let myToolBar = UIToolbar(frame: CGRectMake(0, self.frame.size.height/6, self.frame.size.width, 40.0))
        myToolBar.layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height-20.0)
        myToolBar.backgroundColor = UIColor.blackColor()
        myToolBar.barStyle = UIBarStyle.Black
        myToolBar.tintColor = UIColor.whiteColor()
        
        let myToolBarButton = UIBarButtonItem(title: "Close", style: .Bordered, target: self, action: "onClick:")
        myToolBarButton.tag = 1
        myToolBar.items = [myToolBarButton]
        
        
        let titleLabel = UILabel(frame: CGRectMake(0,0,self.frame.width/4*3,self.frame.height/10))
        titleLabel.text = "イベント名(18文字以内)"
        titleLabel.sizeToFit()
        titleLabel.layer.position = CGPointMake(self.frame.width/2,  self.frame.height/10)
        
        titleTextField = UITextField(frame: CGRectMake(0,0,self.frame.width,self.frame.height/10))
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor.blackColor().CGColor
        titleTextField.layer.cornerRadius = 15
        titleTextField.delegate = self
        titleTextField.layer.position = CGPointMake(self.frame.width/2, self.frame.height/5)
        
        titleAlertLabel = UILabel(frame: CGRectMake(0,0,self.frame.width/4*3,self.frame.height/20))
        titleAlertLabel.text = "⚠️18文字を超えています。"
        titleAlertLabel.sizeToFit()
        titleAlertLabel.backgroundColor = UIColor.redColor()
        titleAlertLabel.hidden = true
        titleAlertLabel.layer.position = CGPointMake(self.frame.width/3*2, self.frame.height/3)
        
        let detailLabel = UILabel(frame: CGRectMake(0,0,self.frame.width/4*3,self.frame.height/10))
        detailLabel.text = "どんなイベント？（１２０文字以内）"
        detailLabel.sizeToFit()
        detailLabel.layer.position = CGPointMake(self.frame.width/2, titleTextField.layer.position.y + titleAlertLabel.frame.height*2 + detailLabel.frame.height)
        
        detailTextView = UITextView(frame: CGRectMake(0,0,self.frame.width,self.frame.height/5))
        detailTextView.layer.borderColor = UIColor.blackColor().CGColor
        detailTextView.layer.borderWidth = 1
        detailTextView.layer.cornerRadius = 15
        detailTextView.textAlignment = NSTextAlignment.Left
        detailTextView.inputAccessoryView = myToolBar
        detailTextView.delegate = self
        detailTextView.layer.position = CGPointMake(self.frame.width/2, self.frame.height/2)
        
        detailAlertLabel = UILabel(frame: CGRectMake(0,0,self.frame.width/4*3,self.frame.height/20))
        detailAlertLabel.text = "⚠️120文字を超えています。"
        detailAlertLabel.sizeToFit()
        detailAlertLabel.backgroundColor = UIColor.redColor()
        detailAlertLabel.hidden = true
        detailAlertLabel.layer.position = CGPointMake(self.frame.width/3*2, self.frame.height/3*2)
        
        let myButton = UIButton(frame: CGRectMake(0,0,self.frame.width/5,self.frame.height/10))
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 20.0
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        myButton.backgroundColor = UIColor.redColor()
        myButton.layer.position = CGPoint(x: self.frame.width/2, y:self.frame.height/5*4)
        
        self.addSubview(titleLabel)
        self.addSubview(titleTextField)
        self.addSubview(titleAlertLabel)
        self.addSubview(detailLabel)
        self.addSubview(detailTextView)
        self.addSubview(detailAlertLabel)
        self.addSubview(myButton)
        
    }
    
    func onClickMyButton(sender: UIButton){
        if titleTextField.text?.characters.count > 0 && detailTextView.text?.characters.count > 0 {
            self.createEventdelegate.createEventNameExposition()
        } else {
            self.createEventdelegate.nilAlertAction("必要な情報が入力されていません", message: "イベント名と内容を入力してください")
        }
    }
    
    func postEventDate(){
        if titleTextField.text?.characters.count > 0 && detailTextView.text?.characters.count > 0 {
            self.createEventdelegate.getEventNameExposition(titleTextField.text, exposition: detailTextView.text)
        } else {
            self.createEventdelegate.nilAlertAction("必要な情報が入力されていません", message: "イベント名と内容を入力してください")
        }
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
        
        if tmpStr.length > 16 {
            titleAlertLabel.hidden = false
            return false
        }
        titleAlertLabel.hidden = true
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
        
        if tmpStr.length > 120 {
            detailAlertLabel.hidden = false
            return false
        }
        detailAlertLabel.hidden = true
        return true
    }
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        print("textViewShouldEndEditing : \(textView.text)");
        return true
    }
    
    func onClick(sender: UIBarButtonItem) {
        self.endEditing(true)
    }

    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
