//
//  CreateEventVC.swift
//  ExsampleCafeVer2
//
//  Created by Shohei_Hayashi on 2015/12/20.
//  Copyright © 2015年 Shohei Hayashi. All rights reserved.
//

import UIKit

class CreateEventVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, 200, 30))
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColorFromRGB(0xFFFFFF)
        label.text = "イベントを企画する"
        self.navigationItem.titleView = label
        
        let assetsLabel = UILabel(frame: CGRectMake(0,0,self.view.frame.width/4,self.view.frame.height/10))
        assetsLabel.text = "持ち物"
        assetsLabel.layer.position = CGPointMake(self.view.frame.width/4, self.view.frame.height/6)
        
        let numLabel = UILabel(frame: CGRectMake(0,0,self.view.frame.width/4,self.view.frame.height/10))
        numLabel.text = "定員"
        numLabel.layer.position = CGPointMake(self.view.frame.width/4, self.view.frame.height/3)
        
        let tagLabel = UILabel(frame: CGRectMake(0,0,self.view.frame.width/4,self.view.frame.height/10))
        tagLabel.text = "タグ"
        tagLabel.layer.position = CGPointMake(self.view.frame.width/4, self.view.frame.height/2)
        
        let jumpInLabel = UILabel(frame: CGRectMake(0,0,self.view.frame.width/3,self.view.frame.height/10))
        jumpInLabel.text = "飛び入れ参加OK"
        jumpInLabel.layer.position = CGPointMake(self.view.frame.width/4, self.view.frame.height/3*2)
        
        let makeButton = UIButton (frame: CGRectMake(0,0,self.view.frame.width/5,self.view.frame.height/10))
        makeButton.layer.masksToBounds = true
        makeButton.layer.cornerRadius = 20.0
        makeButton.addTarget(self, action: "onClickMakeButton:", forControlEvents: .TouchUpInside)
        makeButton.backgroundColor = UIColor.redColor()
        makeButton.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/6*5)

        
        self.view.addSubview(assetsLabel)
        self.view.addSubview(numLabel)
        self.view.addSubview(tagLabel)
        self.view.addSubview(jumpInLabel)
        self.view.addSubview(makeButton)
        
    }
    
    func onClickMakeButton(sender: UIButton){
        let alertController = UIAlertController(title: "確認", message: "これでよろしいですか？", preferredStyle: .Alert)
        
        let otherAction = UIAlertAction(title: "はい", style: .Default) {
            action in
            NSLog("はいボタンが押されました")
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        let cancelAction = UIAlertAction(title: "いいえ", style: .Cancel) {
            action in
            NSLog("いいえボタンが押されました")
        }
        
        // addActionした順に左から右にボタンが配置されます
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
