//
//  EditProfileViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by 紺谷和正 on 2015/12/20.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    private var nameLabel: UILabel!
    private var profileImage: UIImageView!
    private var parsefromCameraRoll: UIButton!
    private var currentName: UITextField!
    private var currentProfile: UITextView!
    private var endChange:UIButton!
    private var countProfile:UILabel!
    private var cancelUpdate: UIButton!
    private var saveUpdate: UIButton!
    private var titleLabel: UILabel!
    let user_name = NSUserDefaults.standardUserDefaults()
    var now = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        nameLabel = UILabel(frame: CGRectMake(0,0,screenWidth/2, screenHeight/19))
        nameLabel.layer.position = CGPoint(x: screenWidth/1.7, y:screenHeight/5.9)
        nameLabel.text = "Name"
        nameLabel.font = UIFont.systemFontOfSize(16.5)
        nameLabel.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        self.view.addSubview(nameLabel)
        
        countProfile = UILabel(frame: CGRectMake(0,0,screenWidth/10,screenHeight/10))
        countProfile.layer.position = CGPoint(x: screenWidth/1.05, y: screenHeight/2)
        countProfile.text? = String(currentProfile.text.characters.count)
        countProfile.textColor = UIColor.hexStr("#8395a3", alpha: 1.0)
        countProfile.backgroundColor = UIColor.clearColor()
        self.view.addSubview(countProfile)
        
        currentName = UITextField(frame: CGRectMake(0,0,screenWidth/1.7,screenHeight/22.72))
        currentName.layer.cornerRadius = 8.0
        currentName.layer.position = CGPoint(x: screenWidth*0.63, y: screenHeight/4.7)
        currentName.delegate = self
        currentName.text = ""
        currentName.layer.borderColor = UIColor.hexStr("#999999 ", alpha: 1.0).CGColor
        currentName.layer.borderWidth = 0.75
        currentName.font = UIFont.systemFontOfSize(19.5)
        currentName.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        currentName.backgroundColor = UIColor.clearColor()
        currentName.inputAccessoryView = myKeyboard
        self.view.addSubview(currentName)
        
        currentProfile = UITextView(frame: CGRectMake(0,0,screenWidth/1.167888321,screenHeight/5.68))
        currentProfile.backgroundColor = UIColor.clearColor()
        currentProfile.layer.cornerRadius = 15.0
        currentProfile.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/2.75)
        currentProfile.delegate = self
        
        currentProfile.font = UIFont.systemFontOfSize(20)
        currentProfile.layer.borderColor = UIColor.hexStr("#999999 ", alpha: 1.0).CGColor
        currentProfile.layer.borderWidth = 0.75
        currentProfile.textAlignment = NSTextAlignment.Left
        currentProfile.dataDetectorTypes = UIDataDetectorTypes.All
        currentProfile.text = user_name.objectForKey("myProfile") as? String
        self.view.addSubview(currentProfile)
        
        profileImage = UIImageView(image: UIImage(named: "twitter-icon.png"))
        profileImage.layer.masksToBounds = true
        profileImage.frame = CGRectMake(0, 0, screenWidth/6.2, screenWidth/6.2)
        profileImage.layer.position = CGPoint(x: screenWidth/6.1, y: screenHeight/5.2)
        profileImage.layer.cornerRadius = 10
        profileImage.backgroundColor = UIColor.redColor()
        self.view.addSubview(profileImage)
        
        let profile_camera = UIImage(named: "profile_camera.png")
        parsefromCameraRoll = UIButton(frame: CGRectMake(0,0,screenWidth/15.22,screenHeight/25.47))
        parsefromCameraRoll.layer.position = CGPoint(x: screenWidth/6.1, y: screenHeight/5.2)
        parsefromCameraRoll.setImage(profile_camera, forState: .Normal)
        parsefromCameraRoll.alpha = 0.7
        parsefromCameraRoll.contentMode = .ScaleAspectFit
        parsefromCameraRoll.addTarget(self, action: "pressCameraRoll:", forControlEvents: .TouchUpInside)
        parsefromCameraRoll.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.view.addSubview(parsefromCameraRoll)
        
        cancelUpdate = UIButton(frame: CGRectMake(0,0,screenWidth/4, screenHeight/15))
        cancelUpdate.layer.position = CGPoint(x: screenWidth/8, y: screenHeight/15)
        cancelUpdate.setTitle("Cancel", forState: .Normal)
        cancelUpdate.setTitleColor(UIColor.yellowColor(), forState: .Normal)
        cancelUpdate.backgroundColor = UIColor.clearColor()
        cancelUpdate.addTarget(self, action: "clickBarButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(cancelUpdate)
        
        saveUpdate = UIButton(frame: CGRectMake(0,0,screenWidth/4, screenHeight/15))
        saveUpdate.layer.position = CGPoint(x: screenWidth - screenWidth/8, y: screenHeight/15)
        saveUpdate.setTitle("Save", forState: .Normal)
        saveUpdate.setTitleColor(UIColor.blueColor(), forState: .Normal)
        saveUpdate.backgroundColor = UIColor.clearColor()
        saveUpdate.addTarget(self, action: "clickBarButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(saveUpdate)
        
        titleLabel = UILabel(frame: CGRectMake(0,0,screenWidth/2, screenHeight/15))
        titleLabel.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/15)
        titleLabel.text = "Edit profile"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont.systemFontOfSize(21)
        titleLabel.backgroundColor = UIColor.clearColor()
        self.view.addSubview(titleLabel)
        
        // Do any additional setup after loading the view.
    }
    
    func pickImageFromLibrary() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    func createUserView(){
        
        let url = "https://zerocafe.herokuapp.com/api/v1/events"
        Alamofire.request(.GET, url)
            .responseJSON { response in
                let json = JSON(response.result.value!)
                debugPrint(response.result.value)
                
                let eventArray = json["events"].array! as Array
                let eventLastId = eventArray.count
                var myX :CGFloat = 6
                var myY :CGFloat = 15
                for events in eventArray.enumerate(){
                    let sideDecide = events.index % 2
                    if sideDecide == 0 {
                        let eve = events.element as JSON
                        let eventID = "1234"
                        let title = eve["event"]["title"].string! as String
                        let tagName : String? = { ()->(String) in
                            if eve["event"]["category_tag"] == nil{
                                return ""
                            }else {
                                return eve["event"]["category_tag"].string! as String
                            }
                        }()
                        
                        myX = 162
                    }else{
                        
                        let eve = events.element as JSON
                        let eventID = "1234"
                        let title = eve["event"]["title"].string! as String
                        
                        myX = 6
                        myY += 212
                    }
                    
                }
        }
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let input: NSMutableString = textView.text!.mutableCopy() as! NSMutableString
        now = (input.length)
        countProfile.text = String(now)
        countProfile.setNeedsDisplay()
        let maxLength = 88
        if now > maxLength {
            currentProfile.textColor = UIColor.redColor()
        }else {
            currentProfile.textColor = UIColor.hexStr("#1A1A1A", alpha: 1.0)
        }
        return true
    }
    
    func clickBarButton(sender: UIButton){
        let fv = ForthViewController()
        fv.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(fv, animated: true, completion: nil)
        user_name.setObject(currentName.text, forKey: "NewName")
        user_name.synchronize()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String: AnyObject]) {
        if didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] != nil {
            profileImage.image = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage
            
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func pressCameraRoll(sender: UIButton){
        pickImageFromLibrary()
    }
    
    func onClickMyButton (sender: UIButton) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
        
        let maxLength: Int = 8
        
        let str = textField.text! + string
        
        if str.characters.count < maxLength {
            return true
        }
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
