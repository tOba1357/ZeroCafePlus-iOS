//
//  AlertFunction.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2016/02/06.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class AlertFunction: AnyObject {
    
    func displayPendingAlert() -> UIAlertController {
        //create an alert controller
        let avc:UIAlertController = UIAlertController(title: "", message: "\n\nWait..", preferredStyle: UIAlertControllerStyle.Alert)
        
        //create an activity indicator
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        indicator.frame = avc.view.bounds
        indicator.frame.origin.y = indicator.frame.origin.y - 15
        indicator.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        //add the activity indicator as a subview of the alert controller's view
        avc.view.addSubview(indicator)
        indicator.userInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
        indicator.startAnimating()
        
        return avc
    }
    
    func hidePendingAlert(avc:UIAlertController) -> Void {
        avc.dismissViewControllerAnimated(false, completion: nil)
    }
}
