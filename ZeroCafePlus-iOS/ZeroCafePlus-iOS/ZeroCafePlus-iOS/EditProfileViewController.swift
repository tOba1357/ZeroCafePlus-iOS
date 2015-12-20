//
//  EditProfileViewController.swift
//  ZeroCafePlus-iOS
//
//  Created by 紺谷和正 on 2015/12/20.
//  Copyright © 2015年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    private var profileImage: UIImageView!
    private var parsefromCameraRoll: UIButton!
    private var currentName: UITextField!
    private var endChange:UIButton!
    
    
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
        
        currentName = UITextField(frame: CGRectMake(100,50,200,100))
        currentName.placeholder = "新しい名前を入力してください"
        currentName.delegate = self
        currentName.text = ""
        currentName.textColor = UIColor.blackColor()
        currentName.backgroundColor = UIColor.whiteColor()
        currentName.inputAccessoryView = myKeyboard
        self.view.addSubview(currentName)
        
        profileImage = UIImageView()
        profileImage.frame = CGRectMake(0, 0, screenWidth/1.1, screenWidth/1.1)
        profileImage.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
        profileImage.layer.cornerRadius = 10.0
        profileImage.contentMode = .ScaleAspectFit
        self.view.addSubview(profileImage)
        
        parsefromCameraRoll = UIButton(frame: CGRectMake(0,0,screenWidth/1.2,200))
        parsefromCameraRoll.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/1.3)
        parsefromCameraRoll.setTitle("画像を変更する", forState: .Normal)
        parsefromCameraRoll.addTarget(self, action: "pressCameraRoll:", forControlEvents: .TouchUpInside)
        parsefromCameraRoll.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.view.addSubview(parsefromCameraRoll)
        
        endChange = UIButton(frame: CGRectMake(0,0,300,60))
        endChange.layer.position = CGPoint(x: screenWidth/2, y: screenHeight/1.11)
        endChange.setTitle("変更を完了する", forState: .Normal)
        endChange.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        endChange.backgroundColor = UIColor.grayColor()
        endChange.layer.cornerRadius = 15.0
        endChange.addTarget(self, action: "clickBarButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(endChange)
        
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
    
    func clickBarButton(sender: UIButton){
        self.navigationController?.popToRootViewControllerAnimated(true)
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
        
        let maxLength: Int = 9
        
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
