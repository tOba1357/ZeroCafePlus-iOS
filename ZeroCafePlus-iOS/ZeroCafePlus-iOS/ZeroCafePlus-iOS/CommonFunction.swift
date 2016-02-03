//
//  CommonFunction.swift
//  ZeroCafePlus-iOS
//
//  Created by Shohei_Hayashi on 2016/02/03.
//  Copyright © 2016年 Smartphone.apps.project. All rights reserved.
//

import UIKit

class CommonFunction: AnyObject {
    
    // imageName : "pngの名前", w or h :サイズ
    func resizingImage(imageName imageName :String, w:CGFloat, h:CGFloat) ->UIImage
    {
        let image = UIImage(named: imageName)
        let size = CGSize(width: w, height: h)
        UIGraphicsBeginImageContext(size)
        image!.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage
    }
    // rgbValue = 色のやつ
    func UIColorFromRGB(rgbValue rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
